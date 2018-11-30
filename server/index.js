const fs = require('fs');
const https = require('https');

const Db = require('./db')('127.0.0.1:27017');

const app = https.createServer({
        cert: fs.readFileSync('/etc/letsencrypt/live/avorium.de/fullchain.pem'),
        key: fs.readFileSync('/etc/letsencrypt/live/avorium.de/privkey.pem')
}).listen(42001);

const SocketServer = require('./socketServer')({ server: app });

// Register message handlers
require('./messagehandlers/mongodbhandler')(Db, SocketServer);
require('./messagehandlers/broadcasthandler')(SocketServer);
