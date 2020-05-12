var testhelper = require('../testhelper');
var unzipper = require('unzipper');

beforeAll(testhelper.prepareandinstall);
beforeEach(async() => {
    await testhelper.uploadpackage('./tests/testpackage1.zip');
});
afterAll(testhelper.cleanup);

test('Alle Tabs vorhanden', async () => {
    var tabs = (await testhelper.query("select url from tabs;")).rows.map(t => t.url);
    expect(tabs).toContain('/setup/packages');
});

test('/allfields liefert alle vorhandenen Felder samt Tabellenname und Spaltenname', async () => {
    var response = await testhelper.get('/api-packages/allfields');
    expect(response.status).toBe(200);
    var expectedschema = {
        'apps': [ 'label', 'userid', 'ispublic' ],
        'packageentities': [ 'tablename', 'packageid', 'entityid' ],
        'packagefields': [ 'fieldname', 'tablename', 'packageid' ],
        'packages': [ 'name', 'description' ],
        'routers': [ 'code', 'url', 'userid', 'ispublic' ],
        'tabs': [ 'url', 'label', 'appid', 'userid', 'ispublic' ],
        'users': [ 'username', 'password' ],
        'views': [ 'content', 'contenttype', 'url', 'userid', 'ispublic' ],
        'testtable1': [ 'field1' ],
        'testtable2': [ 'boolean1', 'integer1', 'real1', 'json1', 'numeric1', 'text1', 'uuid1' ]
    };
    for (var [tablename, columns] of Object.entries(expectedschema)) {
        var columnsfromresponse = response.body[tablename];
        expect(columnsfromresponse).not.toBe(undefined);
        for (var column of columns) {
            expect(columnsfromresponse).toContain(column);
        }
    }
});

test('/packagefields liefert alle Felder eines Paketes', async () => {
    var packageid = (await testhelper.query("select id from packages where name='testpackage1';")).rows[0].id;
    var response = await testhelper.get('/api-packages/packagefields/' + packageid);
    expect(response.status).toBe(200);
    var fieldnames = response.body.map(r => r.fieldname);
    expect(fieldnames).toContain('boolean1');
    expect(fieldnames).toContain('integer1');
    expect(fieldnames).toContain('real1');
    expect(fieldnames).toContain('json1');
    expect(fieldnames).toContain('numeric1');
    expect(fieldnames).toContain('text1');
    expect(fieldnames).toContain('uuid1');
});

test('/packageentities liefert alle Entitäten eines Paketes', async () => {
    var packageid = (await testhelper.query("select id from packages where name='testpackage1';")).rows[0].id;
    var response = await testhelper.get('/api-packages/packageentities/' + packageid);
    expect(response.status).toBe(200);
    var entityids = response.body.map(r => r.entityid);
    expect(entityids).toContain('11111111-1111-1111-1111-111111111111');
    expect(entityids).toContain('22222222-2222-2222-2222-222222222222');
    expect(entityids).toContain('33333333-3333-3333-3333-333333333333');
});

test('delete / löscht Paket samt Feld- und Entitätsdefinitionen', async () => {
    var packageid = (await testhelper.query("select id from packages where name='testpackage1';")).rows[0].id;
    expect((await testhelper.query("select id from packages where id='" + packageid + "';")).rows.length).not.toBe(0);
    expect((await testhelper.query("select id from packagefields where packageid='" + packageid + "';")).rows.length).not.toBe(0);
    expect((await testhelper.query("select id from packageentities where packageid='" + packageid + "';")).rows.length).not.toBe(0);
    await testhelper.del('/api-packages/' + packageid);
    expect((await testhelper.query("select id from packages where id='" + packageid + "';")).rows.length).toBe(0);
    expect((await testhelper.query("select id from packagefields where packageid='" + packageid + "';")).rows.length).toBe(0);
    expect((await testhelper.query("select id from packageentities where packageid='" + packageid + "';")).rows.length).toBe(0);
});

test('/download liefert ZIP-Datei mit JSON mit Paketnamen', async () => {
    var packageid = (await testhelper.query("select id from packages where name='testpackage1';")).rows[0].id;
    var response = await testhelper.download('/api-packages/download/' + packageid);
    expect(response.type).toBe('application/zip');
    expect(response.headers['content-disposition']).toBe('attachment; filename="testpackage1.zip"');
    var zipcontent = await unzipper.Open.buffer(response.body);
    expect(zipcontent.files.length).toBe(1);
    expect(zipcontent.files[0].path).toBe('testpackage1.json');
});

test('Heruntergeladenes Paket ist vollständig', async() => {
    var packageid = (await testhelper.query("select id from packages where name='testpackage1';")).rows[0].id;
    var response = await testhelper.download('/api-packages/download/' + packageid);
    var zipcontent = await unzipper.Open.buffer(response.body);
    var filecontent = (await zipcontent.files[0].buffer()).toString('utf8');
    var obj = JSON.parse(filecontent);
    expect(obj.id).toBe('33a4b329-fb6f-4f9f-9f87-453af01eddab');
    expect(obj.description).toBe('Dieses Paket soll zuerst eingespielt werden, damit die Tabelle testtable2 erstellt wird, welche vom testpackage2 erweitert wird');
    expect(obj.name).toBe('testpackage1');
    expect(obj.entities).not.toBe(undefined);
    expect(obj.entities.testtable1).not.toBe(undefined);
    expect(obj.entities.testtable1.length).toBe(1);
    expect(obj.entities.testtable2).not.toBe(undefined);
    expect(obj.entities.testtable2.length).toBe(2);
    expect(obj.fields).not.toBe(undefined);
    expect(obj.fields.testtable1).not.toBe(undefined);
    expect(obj.fields.testtable1.field1).not.toBe(undefined);
    expect(obj.fields.testtable2).not.toBe(undefined);
    expect(obj.fields.testtable2.boolean1).not.toBe(undefined);
    expect(obj.fields.testtable2.integer1).not.toBe(undefined);
    expect(obj.fields.testtable2.real1).not.toBe(undefined);
    expect(obj.fields.testtable2.json1).not.toBe(undefined);
    expect(obj.fields.testtable2.numeric1).not.toBe(undefined);
    expect(obj.fields.testtable2.text1).not.toBe(undefined);
    expect(obj.fields.testtable2.uuid1).not.toBe(undefined);
});

test('packages, packagefields und packageentities', async() => {
    var packages = (await testhelper.query("select id from packages where name='packaging';")).rows;
    expect(packages.length).toBe(1);
    var packageid = packages[0].id;
    var packagefields = (await testhelper.query("select * from packagefields where packageid='" + packageid + "';")).rows;
    expect(packagefields.length).toBe(0);
    var packageentities = (await testhelper.query("select * from packageentities where packageid='" + packageid + "';")).rows;
    expect(packageentities.length).toBe(5);
});