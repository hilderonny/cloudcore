var testhelper = require('../testhelper');

beforeAll(async() => {
    await testhelper.prepareandinstall();
    await testhelper.uploadpackage('./packages/auth.json');
    await testhelper.uploadpackage('./packages/core.json');
});
beforeEach(async() => {
    await testhelper.uploadpackage('./tests/testpackage1.json');
});
afterAll(testhelper.cleanup);

test('Tabellen apps, routers, tabs, views', async () => {
    var tables = (await testhelper.query("select tablename from pg_tables where schemaname='public';")).rows.map(r => r.tablename);
    expect(tables).toContain('apps');
    expect(tables).toContain('routers');
    expect(tables).toContain('tabs');
    expect(tables).toContain('views');
});

test('Spalten in Tabelle apps: label', async () => {
    var columns = (await testhelper.query("select column_name from information_schema.columns where table_name = 'apps';")).rows.map(r => r.column_name);
    expect(columns).toContain('label');
});

test('Spalten in Tabelle routers: code, url', async () => {
    var columns = (await testhelper.query("select column_name from information_schema.columns where table_name = 'routers';")).rows.map(r => r.column_name);
    expect(columns).toContain('code');
    expect(columns).toContain('url');
});

test('Spalten in Tabelle tabs: appid, label, url', async () => {
    var columns = (await testhelper.query("select column_name from information_schema.columns where table_name = 'tabs';")).rows.map(r => r.column_name);
    expect(columns).toContain('appid');
    expect(columns).toContain('label');
    expect(columns).toContain('url');
});

test('Spalten in Tabelle views: content, contenttype, url', async () => {
    var columns = (await testhelper.query("select column_name from information_schema.columns where table_name = 'views';")).rows.map(r => r.column_name);
    expect(columns).toContain('content');
    expect(columns).toContain('contenttype');
    expect(columns).toContain('url');
});

test('Views: /assets/slds.css, /ccc/cc-globalnav, /', async () => {
    expect((await testhelper.get('/assets/slds.css')).status).toBe(200);
    expect((await testhelper.get('/ccc/cc-globalnav')).status).toBe(200);
    expect((await testhelper.get('/')).status).toBe(200);
});

test('Router get /api-schema/columns/:tablename', async() => {
    var response = await testhelper.get('/api-schema/columns/testtable1');
    expect(response.status).toBe(200);
    expect(!!response.body).toBe(true);
});

test('Router post /api-schema/columns/:tablename/:columnname/:columntype', async() => {
    var response = await testhelper.post('/api-schema/columns/testtable1/testcol/text', {});
    expect(response.status).toBe(200);
    expect(!!response.body).toBe(true);
});

test('Router delete /api-schema/columns/:tablename/:columnname', async() => {
    var response = await testhelper.del('/api-schema/columns/testtable1/field1', {});
    expect(response.status).toBe(200);
    expect(!!response.body).toBe(true);
});

test('Router get /api-schema/tables', async() => {

});

test('Router post /api-schema/tables/:tablename', async() => {

});

test('Router delete /api-schema/tables/:tablename', async() => {

});

test('Router get /api-data/list/:tablename', async() => {

});

test('Router get /api-data/list/:tablename/:columns', async() => {

});

test('Router get /api-data/list/:tablename/:columns/:filter', async() => {

});

test('Router get /api-data/:tablename/:id', async() => {

});

test('Router post /api-data/:tablename', async() => {

});

test('Router put /api-data/:tablename/:id', async() => {

});

test('Router delete /api-data/:tablename/:id', async() => {

});
