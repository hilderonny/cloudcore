const assert = require('assert');
const test = require('./utils/test');

describe('API transferownership', function() {

    beforeEach(async function() {
        await test.server.db('users').remove({}); // Clear all users before test
        let user1id = (await test.post('/api/arrange/register', { username: 'username1', password: 'password1' })).body._id;
        await test.post('/api/arrange/register', { username: 'username2', password: 'password2' });
        await test.post('/api/arrange/register', { username: 'username3', password: 'password3' });
        // Prepare demo data
        await test.server.db('test').remove({});
        await test.server.db('test').insert({ key: 'testdata', _ownerid: user1id });
    });

    it('Responds with error 401 when not logged in', async function() {
        const user2id = (await test.server.db('users').findOne({ username: 'username2' }, '_id'))._id.toString();
        const entityid = (await test.server.db('test').findOne({ key: 'testdata' }, '_id'))._id.toString();
        const response = await test.post('/api/arrange/transferownership/test/' + entityid + '/' + user2id);
        assert.strictEqual(response.status, 401);
        assert.strictEqual(response.body.error, 'Token is missing');
    });

    it('Responds with error 403 when requesting user is not owner of the target object', async function() {
        const user3id = (await test.server.db('users').findOne({ username: 'username3' }, '_id'))._id.toString();
        const entityid = (await test.server.db('test').findOne({ key: 'testdata' }, '_id'))._id.toString();
        let user2 = (await test.post('/api/arrange/login', { username: 'username2', password: 'password2' })).body;
        const response = await test.post('/api/arrange/transferownership/test/' + entityid + '/' + user3id, {}, user2.token);
        assert.strictEqual(response.status, 403);
    });

    it('Returns with error 400 when trying to access the users table', async function() {
        let user1 = (await test.post('/api/arrange/login', { username: 'username1', password: 'password1' })).body;
        const user2id = (await test.server.db('users').findOne({ username: 'username2' }, '_id'))._id.toString();
        const response = await test.post('/api/arrange/transferownership/users/' + user1._id + '/' + user2id, {}, user1.token);
        assert.strictEqual(response.status, 400);
    });

    it('Returns with error 400 when the target user id is in wrong format', async function() {
        const entityid = (await test.server.db('test').findOne({ key: 'testdata' }, '_id'))._id.toString();
        let user1 = (await test.post('/api/arrange/login', { username: 'username1', password: 'password1' })).body;
        const response = await test.post('/api/arrange/transferownership/test/' + entityid + '/wrongformat', {}, user1.token);
        assert.strictEqual(response.status, 400);
        assert.strictEqual(response.body.error, 'User id has wrong format');
    });

    it('Returns with error 404 when there is no user with the target user id', async function() {
        const entityid = (await test.server.db('test').findOne({ key: 'testdata' }, '_id'))._id.toString();
        let user1 = (await test.post('/api/arrange/login', { username: 'username1', password: 'password1' })).body;
        const response = await test.post('/api/arrange/transferownership/test/' + entityid + '/123456789012345678901234', {}, user1.token);
        assert.strictEqual(response.status, 404);
        assert.strictEqual(response.body.error, 'User not found');
    });

    it('Returns with error 400 when the target object _id is in wrong format', async function() {
        const user3id = (await test.server.db('users').findOne({ username: 'username3' }, '_id'))._id.toString();
        let user1 = (await test.post('/api/arrange/login', { username: 'username1', password: 'password1' })).body;
        const response = await test.post('/api/arrange/transferownership/test/wrongformat/' + user3id, {}, user1.token);
        assert.strictEqual(response.status, 400);
        assert.strictEqual(response.body.error, 'Entity id has wrong format');
    });

    it('Returns with error 404 when there is no object with the target _id', async function() {
        const user3id = (await test.server.db('users').findOne({ username: 'username3' }, '_id'))._id.toString();
        let user1 = (await test.post('/api/arrange/login', { username: 'username1', password: 'password1' })).body;
        const response = await test.post('/api/arrange/transferownership/test/123456789012345678901234/' + user3id, {}, user1.token);
        assert.strictEqual(response.status, 404);
        assert.strictEqual(response.body.error, 'Entity not found');
    });

    it('On success the new owner ist set and the previous owner is set as readableBy and writableBy', async function() {
        const user3id = (await test.server.db('users').findOne({ username: 'username3' }, '_id'))._id.toString();
        const entityid = (await test.server.db('test').findOne({ key: 'testdata' }, '_id'))._id.toString();
        const user1 = (await test.post('/api/arrange/login', { username: 'username1', password: 'password1' })).body;
        const user1id = user1._id.toString();
        const response = await test.post('/api/arrange/transferownership/test/' + entityid + '/' + user3id, {}, user1.token);
        assert.strictEqual(response.status, 200);
        const entity = await test.server.db('test').findOne(entityid);
        assert.ok(entity);
        assert.strictEqual(entity._ownerid, user3id);
        assert.ok(entity._readableby);
        assert.ok(entity._readableby.indexOf(user1id) >= 0);
        assert.ok(entity._writableby);
        assert.ok(entity._writableby.indexOf(user1id) >= 0);
    });

    it('On success the readableBy and writableBy gets extended when they have entries', async function() {
        const user2id = (await test.server.db('users').findOne({ username: 'username2' }, '_id'))._id.toString();
        const user3id = (await test.server.db('users').findOne({ username: 'username3' }, '_id'))._id.toString();
        const entityid = (await test.server.db('test').findOne({ key: 'testdata' }, '_id'))._id.toString();
        await test.server.db('test').update(entityid, { $set : { _readableby: [ user2id ], _writableby: [ user2id ] }});
        const user1 = (await test.post('/api/arrange/login', { username: 'username1', password: 'password1' })).body;
        const user1id = user1._id.toString();
        const response = await test.post('/api/arrange/transferownership/test/' + entityid + '/' + user3id, {}, user1.token);
        assert.strictEqual(response.status, 200);
        const entity = await test.server.db('test').findOne(entityid);
        assert.ok(entity);
        assert.ok(entity._readableby);
        assert.strictEqual(entity._readableby.length, 2);
        assert.ok(entity._readableby.indexOf(user1id) >= 0);
        assert.ok(entity._writableby);
        assert.strictEqual(entity._writableby.length, 2);
        assert.ok(entity._writableby.indexOf(user1id) >= 0);
    });

});