const assert = require('assert');
const test = require('./utils/test');

describe('API details', function() {

    beforeEach(async function() {
        await test.server.db('users').remove({}); // Clear all users before test
        const user1id = (await test.post('/api/arrange/register', { username: 'username1', password: 'password1' })).body._id; // Create test user
        await test.post('/api/arrange/register', { username: 'username2', password: 'password2' });
        await test.server.db('testdetails').remove({});
        await test.server.db('testdetails').insert({ key: 'testdata', attribute1: 'value1', _ownerid: user1id });
    });

    it('Responds with error 401 when not logged in', async function() {
        const entityid = (await test.server.db('testdetails').findOne({ key: 'testdata' }, '_id'))._id.toString();
        const response = await test.get('/api/arrange/details/testdetails/' + entityid);
        assert.strictEqual(response.status, 401);
    });

    it('Responds with error 400 when id is not valid', async function() {
        const user1 = (await test.post('/api/arrange/login', { username: 'username1', password: 'password1' })).body;
        const response = await test.get('/api/arrange/details/testdetails/wrongformat', user1.token);
        assert.strictEqual(response.status, 400);
        assert.strictEqual(response.body.error, 'Parameter id is no valid id');
    });

    it('Responds with 403 when trying to access users table', async function() {
        const user1 = (await test.post('/api/arrange/login', { username: 'username1', password: 'password1' })).body;
        await test.server.db('users').update(user1._id.toString(), { $set : { _ownerid: user1._id.toString() }});
        const response = await test.get('/api/arrange/details/users/' + user1._id, user1.token);
        assert.strictEqual(response.status, 403);
        assert.strictEqual(response.body.error, 'Access to users table forbidden');
    });

    it('Responds with 403 when user is not owner and not in _readableby and entity is not _publiclyreadable', async function() {
        const entityid = (await test.server.db('testdetails').findOne({ key: 'testdata' }, '_id'))._id.toString();
        const user2 = (await test.post('/api/arrange/login', { username: 'username2', password: 'password2' })).body;
        const response = await test.get('/api/arrange/details/testdetails/' + entityid, user2.token);
        assert.strictEqual(response.status, 403);
        assert.strictEqual(response.body.error, 'Reading not allowed');
    });

    it('Returns 404 when there is no entity with the given id', async function() {
        const user1 = (await test.post('/api/arrange/login', { username: 'username1', password: 'password1' })).body;
        const response = await test.get('/api/arrange/details/testdetails/123456789012345678901234', user1.token);
        assert.strictEqual(response.status, 404);
        assert.strictEqual(response.body.error, 'Entity not found');
    });

    it('Returns 200 when the user is the owner', async function() {
        const user2 = (await test.post('/api/arrange/login', { username: 'username2', password: 'password2' })).body;
        const entityid = (await test.server.db('testdetails').findOne({ key: 'testdata' }, '_id'))._id.toString();
        await test.server.db('testdetails').update(entityid, { $set : { _ownerid: user2._id.toString() }});
        const response = await test.get('/api/arrange/details/testdetails/' + entityid, user2.token);
        assert.strictEqual(response.status, 200);
    });

    it('Returns 200 when the object is publiclyreadable', async function() {
        const user2 = (await test.post('/api/arrange/login', { username: 'username2', password: 'password2' })).body;
        const entityid = (await test.server.db('testdetails').findOne({ key: 'testdata' }, '_id'))._id.toString();
        await test.server.db('testdetails').update(entityid, { $set : { _publiclyreadable: true }});
        const response = await test.get('/api/arrange/details/testdetails/' + entityid, user2.token);
        assert.strictEqual(response.status, 200);
    });

    it('Returns 200 when the user is in readableby', async function() {
        const user2 = (await test.post('/api/arrange/login', { username: 'username2', password: 'password2' })).body;
        const entityid = (await test.server.db('testdetails').findOne({ key: 'testdata' }, '_id'))._id.toString();
        await test.server.db('testdetails').update(entityid, { $set : { _readableby: [ user2._id.toString() ] }});
        const response = await test.get('/api/arrange/details/testdetails/' + entityid, user2.token);
        assert.strictEqual(response.status, 200);
    });

    it('Returns all attributes on success', async function() {
        const user1 = (await test.post('/api/arrange/login', { username: 'username1', password: 'password1' })).body;
        const entityid = (await test.server.db('testdetails').findOne({ key: 'testdata' }, '_id'))._id.toString();
        await test.server.db('testdetails').update(entityid, { $set : { attribute1: 'value1', _ownerid: user1._id.toString(), _publiclyreadable: true, _publiclywritable: true, _readableby: [ user1._id.toString() ], _writableby: [ user1._id.toString() ] }});
        const response = await test.get('/api/arrange/details/testdetails/' + entityid, user1.token);
        assert.strictEqual(response.status, 200);
        assert.strictEqual(Object.keys(response.body).length, 8);
        assert.ok(response.body._id);
        assert.ok(response.body.key);
        assert.ok(response.body.attribute1);
        assert.ok(response.body._ownerid);
        assert.ok(response.body._publiclyreadable);
        assert.ok(response.body._publiclywritable);
        assert.ok(response.body._readableby);
        assert.ok(response.body._writableby);
    });

});