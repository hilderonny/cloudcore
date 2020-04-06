var pg = require('pg');
var fs = require('fs');

(async () => {
    try {
        var client = new pg.Client();
        await client.connect();

        // Tabellen anlegen
        await client.query("CREATE TABLE IF NOT EXISTS views (id SERIAL);");
        await client.query("ALTER TABLE views ADD COLUMN IF NOT EXISTS content VARCHAR;");
        await client.query("ALTER TABLE views ADD COLUMN IF NOT EXISTS contenttype VARCHAR(255);");
        await client.query("ALTER TABLE views ADD COLUMN IF NOT EXISTS url VARCHAR(255) UNIQUE;");
        await client.query("CREATE TABLE IF NOT EXISTS routers (id SERIAL);");
        await client.query("ALTER TABLE routers ADD COLUMN IF NOT EXISTS code VARCHAR;");
        await client.query("ALTER TABLE routers ADD COLUMN IF NOT EXISTS url VARCHAR(255) UNIQUE;");

        // Standardviews vorbereiten
        await client.query("INSERT INTO views (url, contenttype, content) VALUES ($1, $2, $3) ON CONFLICT (url) DO NOTHING;", ['/', 'text/html', '<a href="/vger">VGER</a>']);

        // Demo-Router in Datenbank eintragen. Reagiert auf /fubbele/eins und /fubbele/zwei/:zahl und /fubbele/hubbele/:tablename
        await client.query("INSERT INTO routers (url, code) VALUES ($1, $2) ON CONFLICT (url) DO NOTHING;", ['/fubbele', fs.readFileSync(__dirname + '/vger/router.js')]);

        await client.end();
    } catch (ex) {
        console.log(ex);
    }
    console.log('FETTIG!');
})();