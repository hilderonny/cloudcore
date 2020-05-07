jest.mock('fs');
jest.mock('pg');

test('install.js muss notwendige Tabellen erstellen', async () => {
    await require('../install')();
    var queries = require('pg').queries;
    expect(queries).toContain('CREATE EXTENSION IF NOT EXISTS "uuid-ossp";');
    expect(queries).toContain('CREATE TABLE IF NOT EXISTS packages (id UUID PRIMARY KEY DEFAULT uuid_generate_v4());');
    expect(queries).toContain('CREATE TABLE IF NOT EXISTS packageentities (id UUID PRIMARY KEY DEFAULT uuid_generate_v4());');
    expect(queries).toContain('CREATE TABLE IF NOT EXISTS packagefields (id UUID PRIMARY KEY DEFAULT uuid_generate_v4());');
    expect(queries).toContain('ALTER TABLE packages ADD COLUMN IF NOT EXISTS description TEXT;');
    expect(queries).toContain('ALTER TABLE packages ADD COLUMN IF NOT EXISTS name TEXT;');
    expect(queries).toContain('ALTER TABLE packageentities ADD COLUMN IF NOT EXISTS entityid TEXT;');
    expect(queries).toContain('ALTER TABLE packageentities ADD COLUMN IF NOT EXISTS packageid UUID;');
    expect(queries).toContain('ALTER TABLE packageentities ADD COLUMN IF NOT EXISTS tablename TEXT;');
    expect(queries).toContain('ALTER TABLE packagefields ADD COLUMN IF NOT EXISTS fieldname TEXT;');
    expect(queries).toContain('ALTER TABLE packagefields ADD COLUMN IF NOT EXISTS packageid UUID;');
    expect(queries).toContain('ALTER TABLE packagefields ADD COLUMN IF NOT EXISTS tablename TEXT;');
});
