const assert = require('assert');
const test = require('./utils/test');

describe('Middleware auth', function() {

    before(async function() {
        // Define API endpoint for testing
        test.server.app.post('/api/test', test.server.auth.bind(test.server), function(request, response) {
            const user = request.user;
            assert.strictEqual(Object.keys(user).length, 2);
            assert.ok(user._id);
            assert.strictEqual(user.username, 'username');
            response.status(200).send();
        });
    });

    beforeEach(async function() {
        await test.server.db('users').remove({}); // Clear all users before test
        await test.post('/api/arrange/register', { username: 'username', password: 'password' }); // Create test user
    });

    it('Responds with error 401 when no token was given', async function() {
        const response = await test.post('/api/test', { });
        assert.strictEqual(response.status, 401);
    });

    it('Responds with error 401 when token was invalid', async function() {
        const response = await test.post('/api/test', { }, 'invalidtoken');
        assert.strictEqual(response.status, 401);
    });

    it('Responds with error 401 when user for token was not found', async function() {
        const response1 = await test.post('/api/arrange/login', { username: 'username', password: 'password' });
        const user1 = response1.body;
        // Delete user
        await test.server.db('users').remove({});
        // Try to use token of invalid user
        const response2 = await test.post('/api/test', { }, user1.token);
        assert.strictEqual(response2.status, 401);
    });

    it('Sets request.user to object with only _id and username and proceeds with API call', async function() {
        const response1 = await test.post('/api/arrange/login', { username: 'username', password: 'password' });
        const user1 = response1.body;
        const response2 = await test.post('/api/test', { }, user1.token);
        assert.strictEqual(response2.status, 200); // Comes from before()
    });

});