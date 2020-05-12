var pg = require('pg').native;

module.exports = (config) => {
    return async (req, _, next) => {
        req.db = {
            config: config, // Wird für Backup benötigt
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
                    // Konsole vorübergehend umleiten, da Warnungen ansonsten rummüllen
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
