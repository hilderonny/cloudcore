var pg = require('pg');
var fs = require('fs');

(async () => {
    try {
        var client = new pg.Client();
        await client.connect();

        // UUID-Erweiterung anlegen
        await client.query('CREATE EXTENSION IF NOT EXISTS "uuid-ossp";');

        // Tabellen anlegen
        await client.query("CREATE TABLE IF NOT EXISTS views (id UUID PRIMARY KEY DEFAULT uuid_generate_v4());");
        await client.query("ALTER TABLE views ADD COLUMN IF NOT EXISTS content VARCHAR;");
        await client.query("ALTER TABLE views ADD COLUMN IF NOT EXISTS contenttype VARCHAR(255);");
        await client.query("ALTER TABLE views ADD COLUMN IF NOT EXISTS url VARCHAR(255) UNIQUE;");
        await client.query("CREATE TABLE IF NOT EXISTS routers (id UUID PRIMARY KEY DEFAULT uuid_generate_v4());");
        await client.query("ALTER TABLE routers ADD COLUMN IF NOT EXISTS code VARCHAR;");
        await client.query("ALTER TABLE routers ADD COLUMN IF NOT EXISTS url VARCHAR(255) UNIQUE;");

        // TODO: Paketupload als einzige API nativ bereitstellen
        // Standardviews vorbereiten
        await client.query("INSERT INTO views (url, contenttype, content) VALUES ($1, $2, $3) ON CONFLICT (url) DO NOTHING;", ['/', 'text/html', '<a href="/vger">VGER</a>']);

        await client.end();
    } catch (ex) {
        console.log(ex);
    }
    console.log('FETTIG!');
})();