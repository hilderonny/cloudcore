var testhelper = require('../testhelper');

beforeAll(testhelper.prepareandinstall);
afterAll(testhelper.cleanup);

test('Alle Apps vorhanden', async () => {
    var apps = (await testhelper.query("select id from apps where label='Setup';")).rows;
    expect(apps.length).toBe(1);
});

test('Alle Tabs vorhanden', async () => {
    var tabs = (await testhelper.query("select url from tabs;")).rows.map(t => t.url);
    expect(tabs).toContain('/setup/editor');
    expect(tabs).toContain('/setup/sqlconsole');
    expect(tabs).toContain('/setup/tables');
});

test('Alle Views vorhanden', async () => {
    expect((await testhelper.get('/setup/editor')).status).toBe(200);
    expect((await testhelper.get('/setup/sqlconsole')).status).toBe(200);
    expect((await testhelper.get('/setup/tables')).status).toBe(200);
    expect((await testhelper.get('/setup/tables/content')).status).toBe(200);
    expect((await testhelper.get('/setup/tables/content/edit')).status).toBe(200);
    expect((await testhelper.get('/setup/tables/columns')).status).toBe(200);
    expect((await testhelper.get('/setup/tables/columns/create')).status).toBe(200);
});

test('Router post /api-sqlconsole', async() => {
    var response = await testhelper.post('/api-sqlconsole/', { query: "select * from apps where label='Setup';" });
    expect(response.status).toBe(200);
    expect(response.body.length).toBe(1);
});

test('Router get /backup', async() => {
    var response = await testhelper.get('/backup/');
    expect(response.status).toBe(200);
    expect(response.text.length).not.toBe(0);
});

test('packages, packagefields und packageentities', async() => {
    var packages = (await testhelper.query("select id from packages where name='setup';")).rows;
    expect(packages.length).toBe(1);
    var packageid = packages[0].id;
    var packagefields = (await testhelper.query("select * from packagefields where packageid='" + packageid + "';")).rows;
    expect(packagefields.length).toBe(0);
    var packageentities = (await testhelper.query("select * from packageentities where packageid='" + packageid + "';")).rows;
    expect(packageentities.length).toBe(13);
});