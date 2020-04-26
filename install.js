var pg = require('pg');

(async () => {
    try {
        var client = new pg.Client();
        await client.connect();

        // UUID-Erweiterung anlegen
        await client.query('CREATE EXTENSION IF NOT EXISTS "uuid-ossp";');

        // Tabellen für Pakete anlegen, diese sind hier notwendig, um überhaupt die ersten Pakete hochladen zu können
        await client.query("CREATE TABLE IF NOT EXISTS packages (id UUID PRIMARY KEY DEFAULT uuid_generate_v4());");
        await client.query("CREATE TABLE IF NOT EXISTS packageentities (id UUID PRIMARY KEY DEFAULT uuid_generate_v4());");
        await client.query("CREATE TABLE IF NOT EXISTS packagefields (id UUID PRIMARY KEY DEFAULT uuid_generate_v4());");
        await client.query("ALTER TABLE packages ADD COLUMN IF NOT EXISTS description TEXT;");
        await client.query("ALTER TABLE packages ADD COLUMN IF NOT EXISTS name TEXT;");
        await client.query("ALTER TABLE packageentities ADD COLUMN IF NOT EXISTS entityid TEXT;");
        await client.query("ALTER TABLE packageentities ADD COLUMN IF NOT EXISTS packageid UUID;");
        await client.query("ALTER TABLE packageentities ADD COLUMN IF NOT EXISTS tablename TEXT;");
        await client.query("ALTER TABLE packagefields ADD COLUMN IF NOT EXISTS fieldname TEXT;");
        await client.query("ALTER TABLE packagefields ADD COLUMN IF NOT EXISTS packageid UUID;");
        await client.query("ALTER TABLE packagefields ADD COLUMN IF NOT EXISTS tablename TEXT;");

        await client.end();
    } catch (ex) {
        console.log(ex);
    }
    console.log('FETTIG!');
})();