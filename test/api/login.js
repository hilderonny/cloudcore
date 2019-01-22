const arrange = require('../../index');
const chai = require('chai');
const chaiHttp = require('chai-http');

// need to be set as variable in runners
const port = process.env.PORT;
const dbUrl = process.env.DB_URL;

console.log(port, dbUrl);

chai.use(chaiHttp);
chai.should();

describe('API login', function() {

    let server;

    before(async function() {
        server = new arrange.Server(port, dbUrl, true, 'testtokensecret');
    });

    beforeEach(async function() {

    });

    it('Responds with error 400 when no username and no password is given', async function() {
        await chai.request(server.app)
        .post('/api/arrange/login')
        .send()
        .then(function(response) {
            console.log(response);
        });
    });

});