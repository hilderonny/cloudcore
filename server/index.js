
const Db = require('./db')('127.0.0.1:27017');

const SocketServer = require('./socketServer')({ port: 42001 });

// Register message handlers
require('./messagehandlers/dbhandler')(Db, SocketServer);
require('./messagehandlers/broadcasthandler')(SocketServer);
