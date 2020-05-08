var testhelper = require('../testhelper');

beforeAll(async() => {
    await testhelper.prepareandinstall();
    await testhelper.uploadpackage('./packages/auth.json');
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

test('Spalten in Tabelle apps: ispublic, userid', async () => {
    var columns = (await testhelper.query("select column_name from information_schema.columns where table_name = 'apps';")).rows.map(r => r.column_name);
    expect(columns).toContain('ispublic');
    expect(columns).toContain('userid');
});

test('Spalten in Tabelle routers: ispublic, userid', async () => {
    var columns = (await testhelper.query("select column_name from information_schema.columns where table_name = 'routers';")).rows.map(r => r.column_name);
    expect(columns).toContain('ispublic');
    expect(columns).toContain('userid');
});

test('Spalten in Tabelle tabs: ispublic, userid', async () => {
    var columns = (await testhelper.query("select column_name from information_schema.columns where table_name = 'tabs';")).rows.map(r => r.column_name);
    expect(columns).toContain('ispublic');
    expect(columns).toContain('userid');
});

test('Spalten in Tabelle users: password, username', async () => {
    var columns = (await testhelper.query("select column_name from information_schema.columns where table_name = 'users';")).rows.map(r => r.column_name);
    expect(columns).toContain('password');
    expect(columns).toContain('username');
});

test('Spalten in Tabelle views: ispublic, userid', async () => {
    var columns = (await testhelper.query("select column_name from information_schema.columns where table_name = 'views';")).rows.map(r => r.column_name);
    expect(columns).toContain('ispublic');
    expect(columns).toContain('userid');
});
