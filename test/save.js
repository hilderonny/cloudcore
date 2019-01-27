const assert = require('assert');
const test = require('./utils/test');

describe.only('API save', function() {

    beforeEach(async function() {
        await test.server.db('users').remove({}); // Clear all users before test
        const user1id = (await test.post('/api/arrange/register', { username: 'username', password: 'password' })).body._id; // Create test user
        await test.server.db('testsave').remove({});
        await test.server.db('testsave').insert({ key: 'testdata', _ownerid: user1id });
    });

    it('Responds with error 401 when not logged in', async function() {
        const response = await test.post('/api/arrange/save/testsave', { key: 'newkey' });
        assert.strictEqual(response.status, 401);
    });

    it('Responds with error 400 when _id is sent but not valid', async function() {
        const user = (await test.post('/api/arrange/login', { username: 'username', password: 'password' })).body;
        const response = await test.post('/api/arrange/save/testsave', { _id: 'wrongformat', key: 'newkey' }, user.token);
        assert.strictEqual(response.status, 400);
        assert.strictEqual(response.body.error, '_id is no valid id');
    });

    xit('Responds with 403 when trying to access users table', async function() {
    });

    xit('Responds with 403 when user is not owner and not in _writableby and entity is not _publiclywritable', async function() {
    });

    xit('Does not overwrite underscore attribtes when sent (_id, _ownerid, _publiclyreadably, _publiclywritable, _readableby, _writableby)', async function() {
    });

    xit('Creates an entity when no _id is given and assigns the logged in user as _owner', async function() {
    });

    xit('Returns 400 when request body is no JSON object', async function() {
    });

    xit('Returns 404 when _id is set but there is no entity with this id in the target table', async function() {
    });

    xit('Overwrites only given attributes, others keep untouched', async function() {
    });

    xit('Returns 200 and the _id of the entity on creation success', async function() {
    });

    xit('Returns 200 and the _id of the entity on update success', async function() {
    });

    xit('Returns 200 and the _id of the entity when the given object is empty', async function() {
    });

});