const assert = require('assert');
const test = require('./utils/test');

describe('Middleware validatebodyid', function() {

    before(function() {
        // Define API endpoint for testing
        test.server.app.post('/api/testvalidatebodyid', test.server.validatebodyid, function(request, response) {
            response.status(200).send();
        });
    });

    it('Responds with 200 when _id is not given in request body', async function() {
        const response = await test.post('/api/testvalidatebodyid', {});
        assert.strictEqual(response.status, 200);
    });

    it('Responds with error 400 when _id is not valid', async function() {
        const response = await test.post('/api/testvalidatebodyid', { _id: 'wrongformat' });
        assert.strictEqual(response.status, 400);
        assert.strictEqual(response.body.error, '_id is no valid id');
    });

    it('Proceeds in request when _id is valid', async function() {
        const response = await test.post('/api/testvalidatebodyid', { _id: '123456789012345678901234' });
        assert.strictEqual(response.status, 200);
    });

});