const assert = require('assert');
const test = require('./utils/test');

describe('API login', function() {

    beforeEach(async function() {
        await test.server.db('users').remove({}); // Clear all users before test
        await test.post('/api/arrange/register', { username: 'username', password: 'password' }); // Create test user
    });

    it('Responds with error 400 when no username and no password is given', async function() {
        const response = await test.post('/api/arrange/login');
        assert.strictEqual(response.status, 400);
    });

    it('Responds with error 400 when no username but a password is given', async function() {
        const response = await test.post('/api/arrange/login', { password: 'password' });
        assert.strictEqual(response.status, 400);
    });

    it('Responds with error 400 when an username but no password is given', async function() {
        const response = await test.post('/api/arrange/login', { username: 'username' });
        assert.strictEqual(response.status, 400);
    });

    it('Responds with error 403 when password is wrong', async function() {
        const response = await test.post('/api/arrange/login', { username: 'username', password: 'wrongpassword' });
        assert.strictEqual(response.status, 403);
    });

    it('Responds with error 403 when logged in user changes his password and tries to re-login with old password', async function() {
        // Login correctly
        const response1 = await test.post('/api/arrange/login', { username: 'username', password: 'password' });
        const token1 = response1.body.token;
        // Change password
        const response2 = await test.post('/api/arrange/setpassword', { password: 'newpassword' }, token1);
        assert.strictEqual(response2.status, 200);
        // Try to re-login with old credentials
        const response3 = await test.post('/api/arrange/login', { username: 'username', password: 'password' });
        assert.strictEqual(response3.status, 403);
    });

    it('Responds with status 200 when username contains \'', async function() {
        const username = 'username with \' in name';
        await test.post('/api/arrange/register', { username: username, password: 'password' });
        const response = await test.post('/api/arrange/login', { username: username, password: 'password' });
        assert.strictEqual(response.status, 200);
    });

    it('Responds with status 200 when username contains "', async function() {
        const username = 'username with " in name';
        await test.post('/api/arrange/register', { username: username, password: 'password' });
        const response = await test.post('/api/arrange/login', { username: username, password: 'password' });
        assert.strictEqual(response.status, 200);
    });

    it('Responds with status 200 when password contains \'', async function() {
        const password = 'password with \' in it';
        await test.post('/api/arrange/register', { username: 'username1', password: password });
        const response = await test.post('/api/arrange/login', { username: 'username1', password: password });
        assert.strictEqual(response.status, 200);
    });

    it('Responds with status 200 when password contains "', async function() {
        const password = 'password with " in it';
        await test.post('/api/arrange/register', { username: 'username1', password: password });
        const response = await test.post('/api/arrange/login', { username: 'username1', password: password });
        assert.strictEqual(response.status, 200);
    });

    it('Responds only with _id, username and token on success', async function() {
        const response = await test.post('/api/arrange/login', { username: 'username', password: 'password' });
        assert.strictEqual(response.status, 200);
        const user = response.body;
        assert.strictEqual(Object.keys(user).length, 3);
        assert.ok(user._id);
        assert.strictEqual(user.username, 'username');
        assert.ok(user.token);
    });

    it('Responds with _id, username and token of new user when the user was logged in before', async function() {
        // First register a new user
        await test.post('/api/arrange/register', { username: 'username1', password: 'password1' });
        // Login with the old user
        const response1 = await test.post('/api/arrange/login', { username: 'username', password: 'password' });
        const user1 = response1.body;
        // Login with the new user
        const response2 = await test.post('/api/arrange/login', { username: 'username1', password: 'password1' });
        assert.strictEqual(response2.status, 200);
        const user2 = response2.body;
        assert.notStrictEqual(user2._id, user1._id);
        assert.notStrictEqual(user2.username, user1.username);
        assert.notStrictEqual(user2.token, user1.token);
    });

    it('Responds with new token when logged in user changes his password and tries to re-login with new password', async function() {
        // Login correctly
        const response1 = await test.post('/api/arrange/login', { username: 'username', password: 'password' });
        const user1 = response1.body;
        // Change password
        const response2 = await test.post('/api/arrange/setpassword', { password: 'newpassword' }, user1.token);
        assert.strictEqual(response2.status, 200);
        // Try to re-login with new credentials
        const response3 = await test.post('/api/arrange/login', { username: 'username', password: 'newpassword' });
        assert.strictEqual(response3.status, 200);
        const user2 = response3.body;
        assert.strictEqual(user2._id, user1._id);
        assert.strictEqual(user2.username, user1.username);
        assert.notStrictEqual(user2.token, user1.token);
    });

    it('Responds with a new token when an already logged in user logs in again', async function() {
        const response1 = await test.post('/api/arrange/login', { username: 'username', password: 'password' });
        const user1 = response1.body;
        const response2 = await test.post('/api/arrange/login', { username: 'username', password: 'password' });
        assert.strictEqual(response2.status, 200);
        const user2 = response2.body;
        assert.strictEqual(user2._id, user1._id);
        assert.strictEqual(user2.username, user1.username);
        assert.notStrictEqual(user2.token, user1.token);
    });

});