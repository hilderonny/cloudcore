var pg = require('pg');

module.exports = async (req, _, next) => {
    req.db = {
        query: async (q, p) => {
            var client = new pg.Client();
            await client.connect();
            try {
                return await client.query(q, p);
            } catch (ex) {
                return { error: ex };
            } finally {
                await client.end();
            }
        }
    };
    next();
};