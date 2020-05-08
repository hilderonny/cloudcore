var fs = require('fs');
var pg = require('pg').native;

var db;

var config = {
    PORT: "65080",
    PGHOST: process.env.CI_POSTGRES_HOST || "127.0.0.1", // Wenn GitLab CI Host vorgibt
    PGUSER: "cloudcoretest",
    PGPASSWORD: "cloudcoretest",
    PGDATABASE: "cloudcoretest",
    PGPORT: "5432",
    TOKENKEY: "sachichnich"
};

module.exports = {
    prepare: async () => {
        if (fs.existsSync('./config.json')) {
            fs.renameSync('./config.json', './config.json.orig');
        }
        fs.writeFileSync('./config.json', JSON.stringify(config));
        db = new pg.Client({
            user: config.PGUSER,
            host: config.PGHOST,
            database: config.PGDATABASE,
            password: config.PGPASSWORD,
            port: config.PGPORT,
        });
        await db.connect();
        for (var tablename of (await db.query("select tablename from pg_tables where schemaname='public';")).rows.map(r => r.tablename)) {
            await db.query("drop table " + tablename + " cascade;");
        }
    },
    query: async (sql) => {
        return db.query(sql);
    },
    cleanup: async () => {
        await db.end();
        fs.unlinkSync('./config.json');
        if (fs.existsSync('./config.json.orig')) {
            fs.renameSync('./config.json.orig', './config.json');
        }    
    }
}