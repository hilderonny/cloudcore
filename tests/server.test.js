var testhelper = require('./testhelper');

// Für jeden Test brauchen wir eine neue Instanz
beforeEach(testhelper.prepareandinstall);
afterEach(testhelper.cleanup);

test('Paketupload muss generell funktionieren (testpackage1)', async () => {
    var tablesBefore = (await testhelper.query("select tablename from pg_tables where schemaname='public';")).rows.map(r => r.tablename);
    expect(tablesBefore).not.toContain('testtable1');
    expect(tablesBefore).not.toContain('testtable2');
    var response = await testhelper.uploadpackage('./tests/testpackage1.zip');
    expect(response.status).toBe(200);
    var tablesAfter = (await testhelper.query("select tablename from pg_tables where schemaname='public';")).rows.map(r => r.tablename);
    expect(tablesAfter).toContain('testtable1');
    expect(tablesAfter).toContain('testtable2');
});

test('Paketupload muss bestehende Strukturen und Daten erweitern (testpackage2)', async () => {
    var columnsBefore = (await testhelper.query("select column_name from information_schema.columns where table_name = 'testtable2';")).rows.map(r => r.column_name);
    expect(columnsBefore).not.toContain('text2');
    var response1 = await testhelper.uploadpackage('./tests/testpackage1.zip');
    expect(response1.status).toBe(200);
    var response2 = await testhelper.uploadpackage('./tests/testpackage2.zip');
    expect(response2.status).toBe(200);
    var columnsAfter = (await testhelper.query("select column_name from information_schema.columns where table_name = 'testtable2';")).rows.map(r => r.column_name);
    expect(columnsAfter).toContain('text2');
});

test('Paketupload muss Eintrag in packages mit name und description erstellen', async() => {
    var response = await testhelper.uploadpackage('./tests/testpackage1.zip');
    expect(response.status).toBe(200);
    var rows = (await testhelper.query("select * from packages where name = 'testpackage1';")).rows;
    expect(rows.length).toBe(1);
    expect(rows[0].id).toBe('33a4b329-fb6f-4f9f-9f87-453af01eddab');
    expect(rows[0].description).toBe('Dieses Paket soll zuerst eingespielt werden, damit die Tabelle testtable2 erstellt wird, welche vom testpackage2 erweitert wird');
});

test('Paketupload muss Einträge in packagefields erstellen', async() => {
    var response = await testhelper.uploadpackage('./tests/testpackage1.zip');
    expect(response.status).toBe(200);
    var fields = (await testhelper.query("select packagefields.* from packagefields left join packages on packages.id = packagefields.packageid where packages.name = 'testpackage1';")).rows;
    expect(fields.length).toBe(8);
});

test('Paketupload muss Einträge in packageentities erstellen', async() => {
    var response = await testhelper.uploadpackage('./tests/testpackage1.zip');
    expect(response.status).toBe(200);
    var entities = (await testhelper.query("select packageentities.* from packageentities left join packages on packages.id = packageentities.packageid where packages.name = 'testpackage1';")).rows;
    expect(entities.length).toBe(3);
});
