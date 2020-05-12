var testhelper = require('../testhelper');

beforeAll(testhelper.prepareandinstall);
beforeEach(async() => {
    await testhelper.uploadpackage('./tests/testpackage1.zip');
});
afterAll(testhelper.cleanup);

test('Tabellen apps, routers, tabs, users, views', async () => {
    var tables = (await testhelper.query("select tablename from pg_tables where schemaname='public';")).rows.map(r => r.tablename);
    expect(tables).toContain('apps');
    expect(tables).toContain('routers');
    expect(tables).toContain('tabs');
    expect(tables).toContain('users');
    expect(tables).toContain('views');
});

test('Spalten in Tabelle apps: label, ispublic, userid', async () => {
    var columns = (await testhelper.query("select column_name from information_schema.columns where table_name = 'apps';")).rows.map(r => r.column_name);
    expect(columns).toContain('label');
    expect(columns).toContain('ispublic');
    expect(columns).toContain('userid');
});

test('Spalten in Tabelle routers: code, url, ispublic, userid', async () => {
    var columns = (await testhelper.query("select column_name from information_schema.columns where table_name = 'routers';")).rows.map(r => r.column_name);
    expect(columns).toContain('code');
    expect(columns).toContain('url');
    expect(columns).toContain('ispublic');
    expect(columns).toContain('userid');
});

test('Spalten in Tabelle tabs: appid, label, url, ispublic, userid', async () => {
    var columns = (await testhelper.query("select column_name from information_schema.columns where table_name = 'tabs';")).rows.map(r => r.column_name);
    expect(columns).toContain('appid');
    expect(columns).toContain('label');
    expect(columns).toContain('url');
    expect(columns).toContain('ispublic');
    expect(columns).toContain('userid');
});

test('Spalten in Tabelle users: password, username', async () => {
    var columns = (await testhelper.query("select column_name from information_schema.columns where table_name = 'users';")).rows.map(r => r.column_name);
    expect(columns).toContain('password');
    expect(columns).toContain('username');
});

test('Spalten in Tabelle views: content, contenttype, url, ispublic, userid', async () => {
    var columns = (await testhelper.query("select column_name from information_schema.columns where table_name = 'views';")).rows.map(r => r.column_name);
    expect(columns).toContain('content');
    expect(columns).toContain('contenttype');
    expect(columns).toContain('url');
    expect(columns).toContain('ispublic');
    expect(columns).toContain('userid');
});

test('user "system" angelegt', async () => {
    var usernames = (await testhelper.query("select username from users;")).rows.map(r => r.username);
    expect(usernames).toContain('system');
});

test('Views: /assets/slds.css, /ccc/cc-globalnav, /', async () => {
    expect((await testhelper.get('/assets/slds.css')).status).toBe(200);
    expect((await testhelper.get('/ccc/cc-globalnav')).status).toBe(200);
    expect((await testhelper.get('/')).status).toBe(200);
});

test('Router get /api-schema/columns/:tablename', async() => {
    var response = await testhelper.get('/api-schema/columns/testtable1');
    expect(response.status).toBe(200);
    var columns = response.body.map(r => r.column_name);
    expect(columns).toContain('field1');
});

test('Router post /api-schema/columns/:tablename/:columnname/:columntype', async() => {
    var response = await testhelper.post('/api-schema/columns/testtable1/testcol/text', {});
    expect(response.status).toBe(200);
    var columns = (await testhelper.query("select column_name from information_schema.columns where table_name = 'testtable1';")).rows.map(r => r.column_name);
    expect(columns).toContain('testcol');
});

test('Router delete /api-schema/columns/:tablename/:columnname', async() => {
    var response = await testhelper.del('/api-schema/columns/testtable1/field1', {});
    expect(response.status).toBe(200);
    var columns = (await testhelper.query("select column_name from information_schema.columns where table_name = 'testtable1';")).rows.map(r => r.column_name);
    expect(columns).not.toContain('field1');
});

test('Router get /api-schema/tables', async() => {
    var response = await testhelper.get('/api-schema/tables');
    expect(response.status).toBe(200);
    var tables = response.body.map(r => r.table_name);
    expect(tables).toContain('apps');
    expect(tables).toContain('tabs');
    expect(tables).toContain('routers');
    expect(tables).toContain('users');
    expect(tables).toContain('views');
    expect(tables).toContain('testtable1');
    expect(tables).toContain('testtable2');
});

test('Router post /api-schema/tables/:tablename', async() => {
    var response = await testhelper.post('/api-schema/tables/meinedicketesttabelle');
    expect(response.status).toBe(200);
    var tables = (await testhelper.query("select tablename from pg_tables where schemaname='public';")).rows.map(r => r.tablename);
    expect(tables).toContain('meinedicketesttabelle');
});

test('Router delete /api-schema/tables/:tablename', async() => {
    var response = await testhelper.del('/api-schema/tables/testtabelle1');
    expect(response.status).toBe(200);
    var tables = (await testhelper.query("select tablename from pg_tables where schemaname='public';")).rows.map(r => r.tablename);
    expect(tables).not.toContain('testtabelle1');
});

test('Router get /api-data/list/:tablename', async() => {
    var response = await testhelper.get('/api-data/list/testtable1');
    expect(response.status).toBe(200);
    expect(response.body.length).toBe(1);
    expect(response.body[0].id).toBe('11111111-1111-1111-1111-111111111111');
    var columns = Object.keys(response.body[0]);
    expect(columns).toContain('id');
    expect(columns).toContain('field1');
});

test('Router get /api-data/list/:tablename/:columns', async() => {
    var response1 = await testhelper.get('/api-data/list/testtable1/id');
    expect(response1.status).toBe(200);
    expect(response1.body.length).toBe(1);
    var columns = Object.keys(response1.body[0]);
    expect(columns).toContain('id');
    expect(columns).not.toContain('field1');
    var response2 = await testhelper.get('/api-data/list/testtable1/id,field1');
    expect(response2.status).toBe(200);
    expect(response2.body.length).toBe(1);
    var columns = Object.keys(response2.body[0]);
    expect(columns).toContain('id');
    expect(columns).toContain('field1');
});

test('Router get /api-data/list/:tablename/:columns/:filter', async() => {
    var response = await testhelper.get('/api-data/list/views/url,ispublic/where%20url%3D%27%2F%27'); // where url='/'
    expect(response.status).toBe(200);
    expect(response.body.length).toBe(1);
    var columns = Object.keys(response.body[0]);
    expect(columns).toContain('url');
    expect(columns).toContain('ispublic');
    expect(columns).not.toContain('id');
});

test('Router get /api-data/:tablename/:id', async() => {
    var response = await testhelper.get('/api-data/testtable2/22222222-2222-2222-2222-222222222222');
    expect(response.status).toBe(200);
    expect(response.body.length).toBe(1);
    expect(response.body[0].uuid1).toBe('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa');
    expect(response.body[0].integer1).toBe(12345);
    expect(response.body[0].boolean1).toBe(true);
    var columns = Object.keys(response.body[0]);
    expect(columns).toContain('id');
    expect(columns).toContain('text1');
    expect(columns).toContain('numeric1');
    expect(columns).toContain('real1');
    expect(columns).toContain('json1');
});

test('Router post /api-data/:tablename', async() => {
    var response = await testhelper.post('/api-data/testtable1', { field1: 'feld1' });
    expect(response.status).toBe(200);
    expect(response.body.length).toBe(1);
    var id = response.body[0].id;
    expect(!!id).toBe(true);
    var rows = (await testhelper.query("select id from testtable1 where field1='feld1';")).rows;
    expect(rows.length).toBe(1);
    expect(rows[0].id).toBe(id);
});

test('Router put /api-data/:tablename/:id', async() => {
    var response = await testhelper.put('/api-data/testtable1/11111111-1111-1111-1111-111111111111', { field1: 'schnulli' });
    expect(response.status).toBe(200);
    var rows = (await testhelper.query("select field1 from testtable1 where id='11111111-1111-1111-1111-111111111111';")).rows;
    expect(rows.length).toBe(1);
    expect(rows[0].field1).toBe('schnulli');
});

test('Router delete /api-data/:tablename/:id', async() => {
    var response = await testhelper.del('/api-data/testtable1/11111111-1111-1111-1111-111111111111');
    expect(response.status).toBe(200);
    var rows = (await testhelper.query("select * from testtable1 where id='11111111-1111-1111-1111-111111111111';")).rows;
    expect(rows.length).toBe(0);
});

test('packages, packagefields und packageentities', async() => {
    var packages = (await testhelper.query("select id from packages where name='core';")).rows;
    expect(packages.length).toBe(1);
    var packageid = packages[0].id;
    var packagefields = (await testhelper.query("select * from packagefields where packageid='" + packageid + "';")).rows;
    expect(packagefields.length).toBe(19);
    expect(packagefields.find(f => f.tablename === 'apps' && f.fieldname === 'ispublic')).not.toBe(undefined);
    expect(packagefields.find(f => f.tablename === 'apps' && f.fieldname === 'label')).not.toBe(undefined);
    expect(packagefields.find(f => f.tablename === 'apps' && f.fieldname === 'userid')).not.toBe(undefined);
    expect(packagefields.find(f => f.tablename === 'routers' && f.fieldname === 'code')).not.toBe(undefined);
    expect(packagefields.find(f => f.tablename === 'routers' && f.fieldname === 'ispublic')).not.toBe(undefined);
    expect(packagefields.find(f => f.tablename === 'routers' && f.fieldname === 'url')).not.toBe(undefined);
    expect(packagefields.find(f => f.tablename === 'routers' && f.fieldname === 'userid')).not.toBe(undefined);
    expect(packagefields.find(f => f.tablename === 'tabs' && f.fieldname === 'appid')).not.toBe(undefined);
    expect(packagefields.find(f => f.tablename === 'tabs' && f.fieldname === 'ispublic')).not.toBe(undefined);
    expect(packagefields.find(f => f.tablename === 'tabs' && f.fieldname === 'label')).not.toBe(undefined);
    expect(packagefields.find(f => f.tablename === 'tabs' && f.fieldname === 'url')).not.toBe(undefined);
    expect(packagefields.find(f => f.tablename === 'tabs' && f.fieldname === 'ispublic')).not.toBe(undefined);
    expect(packagefields.find(f => f.tablename === 'users' && f.fieldname === 'password')).not.toBe(undefined);
    expect(packagefields.find(f => f.tablename === 'users' && f.fieldname === 'username')).not.toBe(undefined);
    expect(packagefields.find(f => f.tablename === 'views' && f.fieldname === 'content')).not.toBe(undefined);
    expect(packagefields.find(f => f.tablename === 'views' && f.fieldname === 'contenttype')).not.toBe(undefined);
    expect(packagefields.find(f => f.tablename === 'views' && f.fieldname === 'ispublic')).not.toBe(undefined);
    expect(packagefields.find(f => f.tablename === 'views' && f.fieldname === 'url')).not.toBe(undefined);
    expect(packagefields.find(f => f.tablename === 'views' && f.fieldname === 'userid')).not.toBe(undefined);
    var packageentities = (await testhelper.query("select * from packageentities where packageid='" + packageid + "';")).rows;
    expect(packageentities.length).toBe(6);
});