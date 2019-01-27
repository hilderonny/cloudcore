const assert = require('assert');
const test = require('./utils/test');

describe('API addwritableby', function() {

    xit('Responds with 401 when not logged in', async function() {
    });

    xit('Responds with 403 when trying to access users table', async function() {
    });

    xit('Responds with 400 when object _id is missing', async function() {
    });

    xit('Responds with 400 when object _id is invalid', async function() {
    });

    xit('Responds with 404 when there is no object with given _id', async function() {
    });

    xit('Responds with 400 when userid is missing', async function() {
    });

    xit('Responds with 400 when userid is invalid', async function() {
    });

    xit('Responds with 404 when there is no user with given userid', async function() {
    });

    xit('Responds with 403 when calling user is not owner', async function() {
    });

    xit('Responds with 200 on success', async function() {
    });

    xit('Target user can write on success, but not read automatically', async function() {
    });

    xit('When target user is already in writable, no double entry is made in array', async function() {
    });

});