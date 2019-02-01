const arrange = require('../../index');
const chai = require('chai');
const chaiHttp = require('chai-http');

// need to be set as variable in runners
const port = process.env.PORT;
const dbUrl = process.env.DB_URL;

chai.use(chaiHttp);
chai.should();

module.exports = {
    chai: chai,
    del: function(url, token) {
        const request = chai.request(this.server.app).del(url);
        const step2 = token ? request.set('x-access-token', token) : request;
        return step2.send();
    },
    get: function(url, token) {
        const request = chai.request(this.server.app).get(url);
        const step2 = token ? request.set('x-access-token', token) : request;
        return step2.send();
    },
    post: function(url, data, token) {
        const request = chai.request(this.server.app).post(url);
        const step2 = token ? request.set('x-access-token', token) : request;
        return step2.send(data);
    },
    server: new arrange.Server(port, dbUrl, 'testtokensecret')
};