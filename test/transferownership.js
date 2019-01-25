const assert = require('assert');
const test = require('./utils/test');

describe('API transferownership', function() {

    beforeEach(async function() {
        await test.server.db('users').remove({}); // Clear all users before test
        await test.post('/api/arrange/register', { username: 'username1', password: 'password1' });
        await test.post('/api/arrange/register', { username: 'username2', password: 'password2' });
        // Prepare demo data
        await test.server.db('test').remove({});
        await test.server.db('test').insert({ key: 'testdata' });
    });

    xit('Responds with error 401 when not logged in', async function() {
        const user2id = (await test.server.db('users').findOne({ username: 'username2' }, '_id'))._id;
        const entityid = (await test.server.db('test').findOne({ key: 'testdata' }, '_id'))._id;
        const response = await test.post('/api/arrange/transferownership/test/' + entityid + '/' + user2id);
        assert.strictEqual(response.status, 401);
    });

    xit('Responds with error 403 when requesting user is not owner of the target object', async function() {
    });

    xit('Returns with error 400 when trying to access the users table', async function() {
    });

    xit('Returns with error 404 when there is no user with the target user _ownerid', async function() {
    });

    xit('Returns with error 404 when there is no object with the target _id', async function() {
    });

    xit('Returns with error 400 when _id is not given', async function() {
    });

    xit('Returns with error 400 when _ownerid is not given', async function() {
    });

    xit('On success the new owner ist set and the previous owner is set as readableBy and writableBy', async function() {
    });

});