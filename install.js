var pg = require('pg');

(async () => {
    try {
        var client = new pg.Client();
        await client.connect();

        // UUID-Erweiterung anlegen
        await client.query('CREATE EXTENSION IF NOT EXISTS "uuid-ossp";');

        await client.end();
    } catch (ex) {
        console.log(ex);
    }
    console.log('FETTIG!');
})();