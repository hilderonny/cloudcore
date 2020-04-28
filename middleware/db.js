var pg = require('pg');

module.exports = async (req, _, next) => {
    req.db = {
        query: async (query) => {
            var client = new pg.Client();
            await client.connect();
            try {
                return await client.query(query);
            } catch (ex) {
                return { error: ex };
            } finally {
                await client.end();
            }
        }
    };
    next();
};