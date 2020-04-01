var pg = require('pg');

var isConnected = false;
var client = new pg.Client();
client.on('end', () => isConnected = false);

module.exports = async (req, _, next) => {
    if (!isConnected) {
        await client.connect();
        isConnected = true;
    }
    req.db = client;
    next();
};