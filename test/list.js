const assert = require('assert');
const test = require('./utils/test');

describe('API list', function() {

    beforeEach(async function() {
        await test.server.db('users').remove({}); // Clear all users before test
        const user1id = (await test.post('/api/arrange/register', { username: 'username1', password: 'password1' })).body._id; // Create test user
        const user2id = (await test.post('/api/arrange/register', { username: 'username2', password: 'password2' })).body._id;
        await test.server.db('testlist').remove({});
        await test.server.db('testlist').insert({ attribute1: 'value11', attribute2: 'value2', _ownerid: user1id });
        await test.server.db('testlist').insert({ attribute1: 'value12', attribute2: 'value2', _ownerid: user1id });
        await test.server.db('testlist').insert({ attribute1: 'value13', attribute2: 'value2', _ownerid: user2id });
    });

    it('Responds with list containing only publicly readable entities when not logged in', async function() {
        const user2id = (await test.server.db('users').findOne({ username: 'username2' }, '_id'))._id.toString();
        const e1id = (await test.server.db('testlist').insert({ attribute1: 'pr1', attribute2: 'value2', _ownerid: user2id, _publiclyreadable: true }))._id.toString();
        const e2id = (await test.server.db('testlist').insert({ attribute1: 'pr2', attribute2: 'value2', _ownerid: user2id, _publiclyreadable: true }))._id.toString();
        const response = await test.post('/api/arrange/list/testlist', undefined);
        assert.strictEqual(response.status, 200);
        const list = response.body;
        assert.strictEqual(list.length, 2);
        assert.ok(list.indexOf(e1id) >= 0);
        assert.ok(list.indexOf(e2id) >= 0);
    });

    it('Responds with 403 when trying to access users table', async function() {
        const user1 = (await test.post('/api/arrange/login', { username: 'username1', password: 'password1' })).body;
        await test.server.db('users').update(user1._id.toString(), { $set : { _ownerid: user1._id.toString() }});
        const response = await test.post('/api/arrange/list/users', undefined, user1.token);
        assert.strictEqual(response.status, 403);
        assert.strictEqual(response.body.error, 'Access to users table forbidden');
    });

    it('Responds only ids of entities where the user has read access (owner, readableby, publiclyreadable)', async function() {
        const user1 = (await test.post('/api/arrange/login', { username: 'username1', password: 'password1' })).body;
        const user2id = (await test.server.db('users').findOne({ username: 'username2' }, '_id'))._id.toString();
        const entity4id = (await test.server.db('testlist').insert({ attribute1: 'value14', attribute2: 'value2', _publiclyreadable: true, _ownerid: user2id }))._id.toString();
        const entity5id = (await test.server.db('testlist').insert({ attribute1: 'value15', attribute2: 'value2', _readableby: [ user1._id.toString()], _ownerid: user2id }))._id.toString();
        const response = await test.post('/api/arrange/list/testlist', undefined, user1.token);
        assert.strictEqual(response.status, 200);
        const list = response.body;
        assert.strictEqual(list.length, 4);
        assert.ok(list.indexOf(entity4id) >= 0);
        assert.ok(list.indexOf(entity5id) >= 0);
    });

    it('Responds ids of all entities when filter not given', async function() {
        const entity1id = (await test.server.db('testlist').findOne({ attribute1: 'value11' }, '_id'))._id.toString();
        const entity2id = (await test.server.db('testlist').findOne({ attribute1: 'value12' }, '_id'))._id.toString();
        const user1 = (await test.post('/api/arrange/login', { username: 'username1', password: 'password1' })).body;
        const response = await test.post('/api/arrange/list/testlist', undefined, user1.token);
        assert.strictEqual(response.status, 200);
        const list = response.body;
        assert.strictEqual(list.length, 2);
        assert.ok(list.indexOf(entity1id) >= 0);
        assert.ok(list.indexOf(entity2id) >= 0);
    });

    it('Responds ids of all entities when filter is an empty object', async function() {
        const entity1id = (await test.server.db('testlist').findOne({ attribute1: 'value11' }, '_id'))._id.toString();
        const entity2id = (await test.server.db('testlist').findOne({ attribute1: 'value12' }, '_id'))._id.toString();
        const user1 = (await test.post('/api/arrange/login', { username: 'username1', password: 'password1' })).body;
        const response = await test.post('/api/arrange/list/testlist', {}, user1.token);
        assert.strictEqual(response.status, 200);
        const list = response.body;
        assert.strictEqual(list.length, 2);
        assert.ok(list.indexOf(entity1id) >= 0);
        assert.ok(list.indexOf(entity2id) >= 0);
    });

    it('Responds ids only of objects matching the given filter', async function() {
        const entity1id = (await test.server.db('testlist').findOne({ attribute1: 'value11' }, '_id'))._id.toString();
        const user1 = (await test.post('/api/arrange/login', { username: 'username1', password: 'password1' })).body;
        const response = await test.post('/api/arrange/list/testlist', { attribute1: 'value11' }, user1.token);
        assert.strictEqual(response.status, 200);
        const list = response.body;
        assert.strictEqual(list.length, 1);
        assert.ok(list.indexOf(entity1id) >= 0);
    });

    it('Responds with 400 when the given filter is invalid', async function() {
        const user1 = (await test.post('/api/arrange/login', { username: 'username1', password: 'password1' })).body;
        const response = await test.post('/api/arrange/list/testlist', { $schnulli: 'value11' }, user1.token);
        assert.strictEqual(response.status, 400);
        assert.strictEqual(response.body.error, 'Filter is invalid');
    });

});