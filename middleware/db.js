var pg = require('pg');

var isConnected = false;
var client = new pg.Client();
client.on('end', () => isConnected = false);

module.exports = async (req, _, next) => {
    if (!isConnected) {
        await client.connect();
        isConnected = true;
    }
    req.db = {
        query: async q => {
            try {
                return await client.query(q);
            } catch (ex) {
                return { error: ex };
            }
        }
    };
    next();
};