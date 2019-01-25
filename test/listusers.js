const assert = require('assert');
const test = require('./utils/test');

describe('API listusers', function() {

    beforeEach(async function() {
        await test.server.db('users').remove({}); // Clear all users before test
        await test.post('/api/arrange/register', { username: 'username1', password: 'password1' });
        await test.post('/api/arrange/register', { username: 'username2', password: 'password2' });
    });

    it('Responds with error 401 when not logged in', async function() {
        const response = await test.get('/api/arrange/listusers');
        assert.strictEqual(response.status, 401);
    });

    it('Responds with only _id and username of all existing users', async function() {
        const token = (await test.post('/api/arrange/login', { username: 'username1', password: 'password1' })).body.token;
        const response = await test.get('/api/arrange/listusers', token);
        assert.strictEqual(response.status, 200);
        const users = response.body;
        assert.strictEqual(users.length, 2);
        users.forEach(function(user) {
            assert.strictEqual(Object.keys(user).length, 2);
            assert.ok(user._id);
            assert.ok(user.username);
        });
    });

});