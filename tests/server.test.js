var testhelper = require('./testhelper');
var fs = require('fs');

// Für jeden Test brauchen wir eine neue Instanz
beforeEach(testhelper.prepareandinstall);
afterEach(testhelper.cleanup);

test('Paketupload muss generell funktionieren (testpackage1)', async () => {
    var tablesBefore = (await testhelper.query("select tablename from pg_tables where schemaname='public';")).rows.map(r => r.tablename);
    expect(tablesBefore).not.toContain('testtable1');
    expect(tablesBefore).not.toContain('testtable2');
    var testpackage1 = JSON.parse(fs.readFileSync('./tests/testpackage1.json'));
    var response = await testhelper.post('/api/packageupload', testpackage1);
    expect(response.status).toBe(200);
    var tablesAfter = (await testhelper.query("select tablename from pg_tables where schemaname='public';")).rows.map(r => r.tablename);
    expect(tablesAfter).toContain('testtable1');
    expect(tablesAfter).toContain('testtable2');
});

test('Paketupload muss bestehende Strukturen und Daten erweitern (testpackage2)', async () => {
    var columnsBefore = (await testhelper.query("select column_name from information_schema.columns where table_name = 'testtable2';")).rows.map(r => r.column_name);
    expect(columnsBefore).not.toContain('text2');
    var testpackage1 = JSON.parse(fs.readFileSync('./tests/testpackage1.json'));
    var response1 = await testhelper.post('/api/packageupload', testpackage1);
    expect(response1.status).toBe(200);
    var testpackage2 = JSON.parse(fs.readFileSync('./tests/testpackage2.json'));
    var response2 = await testhelper.post('/api/packageupload', testpackage2);
    expect(response2.status).toBe(200);
    var columnsAfter = (await testhelper.query("select column_name from information_schema.columns where table_name = 'testtable2';")).rows.map(r => r.column_name);
    expect(columnsAfter).toContain('text2');
});
