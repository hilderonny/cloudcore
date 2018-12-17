const bodyParser = require('body-parser');
const bcryptjs = require('bcryptjs');
const compression = require('compression');
const cors = require('cors');
const express = require('express');
const http = require('http');
const jsonwebtoken = require('jsonwebtoken');
const ws = require('ws');
const Db = require('./db')(process.env.DB_URL);

/* params = {
    *  db: string,
    *  collection: string,
    *  filter?: object,
    *  options?: object
    */
async function handleSearch(request, response) {
    const result = await Db.search(request.body.db, request.body.collection, request.body.filter, request.body.options);
    if (request.body.collection === 'users') result.forEach(function (e) { delete e.password; });
    response.json(result);
}

async function getLoggedInUserId(request) {
    return new Promise(function(resolve) {
        const token = request.body.token;
        if (!token) return resolve(undefined);
        jsonwebtoken.verify(token, process.env.SECRET, function(error, decoded) {
            if (error) return resolve(undefined);
            resolve(decoded._id);
        });
    });
}

/* params = {
 *  db: string,
 *  collection: string,
 *  token: string,
 *  data: object
 */
async function handleCreate(request, response) {
    const userId = await getLoggedInUserId(request);
    if (!userId) return response.status(403).end('Not allowed');
    request.body.data._ownerId = userId;
    const result = await Db.create(request.body.db, request.body.collection, request.body.data);
    if (request.body.collection === 'users') delete result.password;
    response.json(result);
}

/* params = {
 *  db: string,
 *  collection: string,
 *  _id: string,
 *  options?: object
 */
async function handleRead(request, response) {
    const result = await Db.read(request.body.db, request.body.collection, request.body._id, request.body.options);
    if (!result) return response.status(404).end('Not found');
    if (request.body.collection === 'users') delete result.password;
    response.json(result);
}

/* params = {
 *  db: string,
 *  collection: string,
 *  token: string,
 *  _id: string,
 *  data: object
 */
async function handleUpdate(request, response) {
    const userId = await getLoggedInUserId(request);
    if (!userId) return response.status(403).end('Not allowed');
    const result = await Db.update(request.body.db, request.body.collection, { _id: request.body._id, _ownerId: userId }, { $set: request.body.data });
    if (!result) return response.status(404).end('Not found');
    if (request.body.collection === 'users') delete result.password;
    response.json(result);
}

/* params = {
 *  db: string,
 *  collection: string,
 *  token: string,
 *  _id: string
 */
async function handleDelete(request, response) {
    const userId = await getLoggedInUserId(request);
    if (!userId) return response.status(403).end('Not allowed');
    const result = await Db.delete(request.body.db, request.body.collection, { _id: request.body._id, _ownerId: userId });
    if (!result) return response.status(404).end('Not found');
    if (request.body.collection === 'users') delete result.password;
    response.json(result);
}

/* params = {
 *  db: string,
 *  name: string,
 *  password: string
 */
async function handleLogin(request, response) {
    const user = await Db.read(request.body.db, 'users', { name: request.body.name }, '_id password');
    if (user && bcryptjs.compareSync(request.body.password, user.password)) {
        delete user.password;
        user.token = jsonwebtoken.sign({
            _id: user._id,
            time: Date.now()
        }, process.env.SECRET, {
            expiresIn: '24h'
        });
        response.json(user);
    } else {
        response.status(403).send('Login failed');
    }
}

/* params = {
 *  db: string,
 *  name: string,
 *  password: string
 */
async function handleRegister(request, response) {
    if (!request.body.password) return response.status(400).send('Password required');
    const existingUser = await Db.read(request.body.db, 'users', { name: request.body.name }, '_id');
    if (existingUser) return response.status(400).send('Username already taken');
    const newUser = await Db.create(request.body.db, 'users', { name: request.body.name, password: bcryptjs.hashSync(request.body.password) });
    await Db.update(request.body.db, 'users', newUser._id, { $set: { _ownerId: newUser._id.toString() } }); // Assign the user to himself so that only he can delete himself
    handleLogin(request, response); // Login new user
}

const requestMap = {
    'search': handleSearch,
    'create': handleCreate,
    'read': handleRead,
    'update': handleUpdate,
    'delete': handleDelete,
    'login': handleLogin,
    'register': handleRegister
};

async function handleRestRequest(request, response) {
    if (!request.body && !request.body.type) return;
    const handler = requestMap[request.body.type];
    if (!handler) return;
    try {
        await handler(request, response);
    } catch (ex) {
        response.status(500).end(ex.stack);
    }
}

(function () {
    // App Server initialisieren
    const app = express();
    app.use(compression()); // Ausgabekomprimierung
    app.use(bodyParser.json()); // JSON Request-Body-Parser -> req.body
    app.use(bodyParser.urlencoded({ extended: true })); // Formulare parsen application/x-www-form-urlencoded
    app.use(cors()); // CORS sktivieren
    app.use(express.static(__dirname + '/../client')); // Statische Ressourcen im client-Verzeichnis, lädt bei root-Aufruf automatisch index.html
    const server = http.createServer(app);
    server.listen(process.env.PORT, function () {
        console.log('Server running at port ' + process.env.PORT);
    });
    // Routen definieren, alle REST Methoden laufenüber POST-Requests
    app.post('/', handleRestRequest);
    // Websocket broadcaster einrichten
    const openSockets = [];
    const socketServer = new ws.Server({ server: server });
    socketServer.on('connection', function(socket) {
        openSockets.push(socket);
        socket.on('close', function() {
            openSockets.splice(openSockets.indexOf(socket), 1);
        });
        socket.on('message', function(message) { // Simply send the message to all sockets except the sender
            openSockets.forEach(function(s) {
                if (s === socket || s.readyState !== 1) return;
                s.send(message);
            });
        });
    });
    socketServer
})();
