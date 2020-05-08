var testdb = require('./testdb');

beforeAll(testdb.prepareandinstall);
afterAll(testdb.cleanup);

test('Paketupload muss generell funktionieren (testpackage1)', async () => {
});

test('Paketupload muss bestehende Strukturen und Daten erweitern (testpackage2)', async () => {
});
