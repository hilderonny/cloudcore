var fs = require('fs');
var pg = require('pg').native;
var child_process = require('child_process');
var supertest = require('supertest');
var binaryParser = require('superagent-binary-parser');

var app;
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

var testhelper = {
    // config und Datenbank vorbereiten. Wird für install.js Test benutzt.
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
    // Vorbereiten und install.js aufrufen. Wird für alle Tests ausser install.js benutzt. Muss in beforeEach() aufgerufen werden.
    prepareandinstall: async() => {
        await testhelper.prepare();
        child_process.execSync('node ./install.js');
        var modulename = require.resolve('../app'); // Aus cache entfernen, muss stets neu geladen werden
        delete require.cache[modulename];
        app = require('../app'); // Erst hier, damit config vorbereitet werden kann
    },
    // Datenbankabfrage machen
    query: async (sql) => {
        return db.query(sql);
    },
    // config.json zurücksetzen. Muss in afterEach() aufgerufen werden.
    cleanup: async () => {
        await db.end();
        fs.unlinkSync('./config.json');
        if (fs.existsSync('./config.json.orig')) {
            fs.renameSync('./config.json.orig', './config.json');
        }    
    },
    // Macht einen GET Request an die App
    get: async (url) => {
        return supertest(app).get(url).send();
    },
    // Macht einen POST Request an die App
    post: async (url, data) => {
        return supertest(app).post(url).send(data);
    },
    // Macht einen PUT Request an die App
    put: async (url, data) => {
        return supertest(app).put(url).send(data);
    },
    // Macht einen delete-Request
    del: async (url) => {
        return supertest(app).del(url).send();
    },
    // Paket hochladen und damit installieren, liefert response als Promise zurück
    uploadpackage: async (filepath) => {
        return supertest(app).post('/api/packageupload').attach('file', filepath);
    },
    download: async (url) => {
        return supertest(app).get(url).parse(binaryParser).buffer();
    }
};

module.exports = testhelper;