const assert = require('assert');
const test = require('./utils/test');

describe('API setpassword', function() {

    beforeEach(async function() {
        await test.server.db('users').remove({}); // Clear all users before test
        await test.post('/api/arrange/register', { username: 'username', password: 'password' }); // Create test user
    });

    it('Responds with error 401 when not logged in', async function() {
        const response = await test.post('/api/arrange/setpassword', { password: 'newpassword' });
        assert.strictEqual(response.status, 401);
    });

    it('Responds with error 400 when no password was given', async function() {
        const response1 = await test.post('/api/arrange/login', { username: 'username', password: 'password' });
        const user1 = response1.body;
        const response2 = await test.post('/api/arrange/setpassword', { }, user1.token);
        assert.strictEqual(response2.status, 400);
    });

    it('Responds with status 200 when password contains \'', async function() {
        const newpassword = 'password with \' in it';
        const response1 = await test.post('/api/arrange/login', { username: 'username', password: 'password' });
        const user1 = response1.body;
        const response2 = await test.post('/api/arrange/setpassword', { password: newpassword }, user1.token);
        assert.strictEqual(response2.status, 200);
    });

    it('Responds with status 200 when password contains "', async function() {
        const newpassword = 'password with " in it';
        const response1 = await test.post('/api/arrange/login', { username: 'username', password: 'password' });
        const user1 = response1.body;
        const response2 = await test.post('/api/arrange/setpassword', { password: newpassword }, user1.token);
        assert.strictEqual(response2.status, 200);
    });

    it('Responds with status 200 when password change suceeded', async function() {
        const response1 = await test.post('/api/arrange/login', { username: 'username', password: 'password' });
        const user1 = response1.body;
        const response2 = await test.post('/api/arrange/setpassword', { password: 'newpassword' }, user1.token);
        assert.strictEqual(response2.status, 200);
    });

});