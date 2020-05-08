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
