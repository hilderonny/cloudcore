// TODO Überlegen, ob ich die install.js überhaupt noch brauche. Es reicht, wenn die app.js die Tabellen anlegt, die notwendig sind

var pg = require('pg').native;
var fs = require('fs');
var packageupload = require('./api/packageupload');

(async () => {
    var config = JSON.parse(fs.readFileSync(__dirname + '/config.json'));

    var client = new pg.Client({
        user: config.PGUSER,
        host: config.PGHOST,
        database: config.PGDATABASE,
        password: config.PGPASSWORD,
        port: config.PGPORT,
    });
    await client.connect();

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

    // Installierbare Pakete raussuchen und hochladen, wenn sie nicht schon installiert wurden
    var installedpackages = (await client.query("SELECT name FROM packages;")).rows.map(r => r.name);
    var availablezipfiles = fs.readdirSync('./packages/').filter(f => f.endsWith('.zip'));
    for (var zipfile of availablezipfiles) {
        var packagename = zipfile.split('.')[0];
        if (installedpackages.indexOf(packagename) < 0) {
            console.log('Installiere Paket ' + packagename);
            await packageupload.handleZipBuffer(client, fs.readFileSync('./packages/' + zipfile));
        }
    }

    await client.end();
    console.log('FETTIG!');
    process.exit(0);
})();