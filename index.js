const bcryptjs = require('bcryptjs');
const bodyParser = require('body-parser');
const compression = require('compression');
const cors = require('cors');
const express = require('express');
const http = require('http');
const jsonwebtoken = require('jsonwebtoken');
const monk = require('monk');

class Server {

    /**
     * Server initialisieren.
     * @param {number} port Port, an dem der Server lauschen soll.
     * @param {string} dbUrl URL, an der die MongoDB erreichbar ist. Muss angegeben sein.
     * @param {string} tokenSecret Passphrase, mit der der Auth-Token verschlüsselt wird.
     */
    constructor(port, dbUrl, tokenSecret) {
        this.port = port;
        this.database = monk(dbUrl);
        this.database.catch(function(err) { console.log(err); });
        this.tokenSecret = tokenSecret;
        this.app = express();
        this.app.use(compression());
        this.app.use(cors());
        this.app.use(bodyParser.json());
        this.app.use(bodyParser.urlencoded({ extended: true }));
        // Einbindung in HTML-Seite mit <script src="/arrange/arrange.js"></script>
        this.app.use('/arrange', express.static(__dirname + '/client'));
        // APIs registrieren
        this.app.get('/api/arrange/listusers', this.auth.bind(this), this.listusers.bind(this));
        this.app.post('/api/arrange/login', this.login.bind(this));
        this.app.post('/api/arrange/register', this.register.bind(this));
        this.app.post('/api/arrange/save/:table', this.auth.bind(this), this.save.bind(this));
        this.app.post('/api/arrange/setpassword', this.auth.bind(this), this.setpassword.bind(this));
        this.app.post('/api/arrange/transferownership/:table/:entityid/:userid', this.auth.bind(this), this.transferownership.bind(this));
    }

    /**
     * Middleware zur Benutzerauthentifizierung.
     * Liefert response 401, wenn Benutzer nicht authentifizierbar ist.
     * Schreibt request.user mit _id und username.
     * Verwendung: arrangeInstance.app.post('/api/myapi', arrangeInstance.auth.bind(arrangeInstance), function(req, res) { ... });
     */
    auth(request, response, next) {
        const self = this;
        const token = request.header('x-access-token');
        if (!token) return response.status(401).json({ error: 'Token is missing' });
        jsonwebtoken.verify(token, self.tokenSecret, function(error, tokenUser) {
            if (error) return response.status(401).json({ error: 'Token cannot be validated' });
            self.db('users').findOne(tokenUser._id, '_id username').then(function(user) {
                if (!user) return response.status(401).json({ error: 'User not found' });
                request.user = user;
                user._id = user._id.toString(); // Convert ObjectID to string for compatibility
                next();
            });
        });
    }

    /**
     * Liefert Zugriff auf eine bestimmte Datenbanktabelle
     */
    db(collectionName) {
        return this.database.get(collectionName);
    }

    /**
     * API zum Auflisten aller Benutzer mit _id und _username.
     */
    async listusers(request, response) {
        const users = await this.db('users').find({}, '_id username');
        response.json(users);
    }

    /**
     * API für Benutzer-Login.
     * Erwartet als Post-Parameter "username" und "password".
     */
    async login(request, response) {
        if (!request.body.username) return response.status(400).json({ error: 'Username required' });
        if (!request.body.password) return response.status(400).json({ error: 'Password required' });
        const user = await this.db('users').findOne({ username: request.body.username }, '_id username password');
        if (user && bcryptjs.compareSync(request.body.password, user.password)) {
            delete user.password; // Das Passwort wird nicht zurück gegeben, nur _id und token.
            user.token = jsonwebtoken.sign({
                _id: user._id,
                time: Date.now()
            }, this.tokenSecret, {
                expiresIn: '24h'
            });
            response.json(user);
        } else {
            response.status(403).json({ error: 'Login failed' });
        }
    }

    /**
     * API für Benutzer-Registrierung.
     * Erwartet als Post-Parameter "username" und "password".
     */
    async register(request, response) {
        if (!request.body.username) return response.status(400).json({ error: 'Username required' });
        if (!request.body.password) return response.status(400).json({ error: 'Password required' });
        const collection = this.db('users');
        const existingUser = await collection.findOne({ username: request.body.username }, '_id');
        if (existingUser) return response.status(400).json({ error: 'Username already taken' });
        const createdUser = await collection.insert({ username: request.body.username, password: bcryptjs.hashSync(request.body.password) });
        delete createdUser.password;
        createdUser.token = jsonwebtoken.sign({
            _id: createdUser._id,
            time: Date.now()
        }, this.tokenSecret, {
            expiresIn: '24h'
        });
        response.json(createdUser);
    }

    /**
     * API zum Speichern und Erzeugen von Objekten.
     * Erwartet als URL Parameter den Tabellennamen.
     */
    async save(request, response) {
        const collection = this.db(request.params.table);
        const data = request.body;
        const _id = data._id;
        const toDatabase = Object.keys(data).filter(function(element) {
            return ['_ownerid', '_publiclyreadable', '_publiclywritable', '_readableby', '_writableby'].indexOf(element) < 0;
        });
        if (!_id) { // Create
            const createdEntity = collection.insert(toDatabase);
            response.json(createdEntity);
        } else { // Update
            const updatedEntity = collection.update(_id, { $set: toDatabase });
            response.json(updatedEntity);
        }
    }

    /**
     * API für Passwortänderung.
     * Erwartet als Post-Parameter "password" (neues Passwort).
     * Danach ist alter Token ungültig.
     * Der Benutzer muss vorher angemeldet sein.
     */
    async setpassword(request, response) {
        if (!request.body.password) return response.status(400).json({ error: 'Password required' });
        const user = request.user;
        await this.db('users').update(user._id, { $set: { password: bcryptjs.hashSync(request.body.password) } });
        response.status(200).send();
    }

    /**
     * Übergibt den Beistz eines Objektes an einen anderen Benutzer. Der ursprüngliche Besitzer
     * hat danach immernoch Lese- und Schreibrechte.
     */
    async transferownership(request, response) {
        const tablename = request.params.table;
        if (tablename === 'users') return response.status(400).send();
        const userid = request.user._id.toString();
        const targetuserid = request.params.userid;
        if (targetuserid.length !== 24) return response.status(400).json({ error: 'User id has wrong format' });
        const targetuser = await this.db('users').findOne(targetuserid, '_id');
        if (!targetuser) return response.status(404).json({ error: 'User not found' });
        const entityid = request.params.entityid;
        if (entityid.length !== 24) return response.status(400).json({ error: 'Entity id has wrong format' });
        const entity = await this.db(tablename).findOne(entityid, '_ownerid _readableby _writableby');
        if (!entity) return response.status(404).json({ error: 'Entity not found' });
        if (entity._ownerid.toString() !== userid) return response.status(403).send();
        delete entity._id;
        entity._ownerid = targetuserid;
        if (!entity._readableby) entity._readableby = [];
        entity._readableby.push(userid);
        if (!entity._writableby) entity._writableby = [];
        entity._writableby.push(userid);
        await this.db(tablename).update(entityid, { $set: entity });
        response.status(200).send();
    }

    /**
     * Server starten
     */
    start() {
        const port = this.port;
        // Server erstellen
        this.server = http.createServer(this.app);
        this.server.listen(port, function () {
            console.log('Arrange server running at port ' + port);
        });
    }

}

module.exports = {
    Server: Server
}
