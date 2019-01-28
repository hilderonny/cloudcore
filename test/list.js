const assert = require('assert');
const test = require('./utils/test');

describe('API list', function() {

    xit('Responds with 401 when not logged in', async function() {
    });

    xit('Responds with 403 when trying to access users table', async function() {
    });

    xit('Responds list of ids on success', async function() {
    });

    xit('Responds only ids of entities where the user has read access (owner, readableby, publiclyreadable)', async function() {
    });

    xit('Responds ids of all entities when filter not given', async function() {
    });

    xit('Responds ids of all entities when filter is an empty object', async function() {
    });

    xit('Responds ids only of objects matching the given filter', async function() {
    });

    xit('Responds with 400 when the given filter is invalid', async function() {
    });

});