var child_process = require('child_process');
var testhelper = require('./testhelper');

beforeEach(testhelper.prepare);
afterEach(testhelper.cleanup);

test('install.js muss notwendige Tabellen erstellen', async () => {
    child_process.execSync('node ./install.js');
    var tables = (await testhelper.query("select tablename from pg_tables where schemaname='public';")).rows.map(r => r.tablename);
    expect(tables).toContain('packages');
    expect(tables).toContain('packageentities');
    expect(tables).toContain('packagefields');
});

test('Vorhandene Pakete core, packaging und setup müssen installiert worde sein', async () => {
    child_process.execSync('node ./install.js');
    var packages = (await testhelper.query("select name from packages;")).rows.map(r => r.name);
    expect(packages).toContain('core');
    expect(packages).toContain('packaging');
    expect(packages).toContain('setup');
});

test('Vorhandenes Paket soll nicht noch einmal drüber installiert werden', async () => {
    // Zuerst normal installieren lassen
    child_process.execSync('node ./install.js');
    // Jetzt Inhalte verändern
    await testhelper.query("update views set content = 'Hallo Welt' where url = '/';");
    // Jetzt nochmal installieren
    child_process.execSync('node ./install.js');
    // Die Änderung darf nicht überschrieben worden sein
    var content = (await testhelper.query("select content from views where url='/';")).rows.map(r => r.content);
    expect(content.length).toBe(1);
    expect(content).toContain('Hallo Welt');
});
