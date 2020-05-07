
var pg = jest.genMockFromModule('pg');

pg.queries = [];

class client {

    constructor() {}

    connect() {}

    async query(sql) {
        pg.queries.push(sql);
    }

    end() {}
}

pg.Client = client;

module.exports = pg;