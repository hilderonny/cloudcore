var pg = require('pg');

module.exports = (config) => {
    return async (req, _, next) => {
        req.db = {
            query: async (query) => {
                var client = new pg.Client({
                    user: config.PGUSER,
                    host: config.PGHOST,
                    database: config.PGDATABASE,
                    password: config.PGPASSWORD,
                    port: config.PGPORT,
                });
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
};
