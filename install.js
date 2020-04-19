var pg = require('pg');

(async () => {
    try {
        var client = new pg.Client();
        await client.connect();

        // UUID-Erweiterung anlegen
        await client.query('CREATE EXTENSION IF NOT EXISTS "uuid-ossp";');

        // Tabellen anlegen
        await client.query("CREATE TABLE IF NOT EXISTS users (id UUID PRIMARY KEY DEFAULT uuid_generate_v4());");
        await client.query("ALTER TABLE users ADD COLUMN IF NOT EXISTS username TEXT;");
        await client.query("ALTER TABLE users DROP CONSTRAINT IF EXISTS username;");
        await client.query("ALTER TABLE users ADD CONSTRAINT username UNIQUE (username);");

        // Standardbenutzer 'system' vorbereiten, der dient als Besitzer für alle allgemeinen Datensätze
        await client.query("INSERT INTO users (username) VALUES ('system') ON CONFLICT (username) DO NOTHING;");

        await client.end();
    } catch (ex) {
        console.log(ex);
    }
    console.log('FETTIG!');
})();