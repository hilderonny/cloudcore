const assert = require('assert');
const test = require('./utils/test');

describe('Middleware validateid', function() {

    it('Responds with error 400 when parameter to validate is not given in request', async function() {
        await test.server.app.post('/api/test1/:param', test.server.validateid('incorrectparameter'), function(request, response) {
            response.status(200).send();
        });
        const response = await test.post('/api/test1/123456789012345678901234', {});
        assert.strictEqual(response.status, 400);
        assert.strictEqual(response.body.error, 'Parameter incorrectparameter is not given');
    });

    it('Responds with error 400 when parameter is not a valid _id', async function() {
        await test.server.app.post('/api/test2/:param', test.server.validateid('param'), function(request, response) {
            response.status(200).send();
        });
        const response = await test.post('/api/test2/wrongformat', {});
        assert.strictEqual(response.status, 400);
        assert.strictEqual(response.body.error, 'Parameter param is no valid id');
    });

    it('Proceeds in request when parameter is a valid _id', async function() {
        await test.server.app.post('/api/test3/:param', test.server.validateid('param'), function(request, response) {
            response.status(200).send();
        });
        const response = await test.post('/api/test3/123456789012345678901234', {});
        assert.strictEqual(response.status, 200);
    });

});