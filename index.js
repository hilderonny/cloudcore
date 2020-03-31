var bodyParser = require('body-parser');
var express = require('express');
var http = require('http');
var fs = require('fs');


var app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

fs.readdirSync(__dirname + '/api').forEach(apifile => {
    var apiname = apifile.split('.')[0];
    app.use('/api/' + apiname, require('./api/' + apiname));
});

var port = process.env.PORT || 8080;
var server = http.createServer(app);
server.listen(port, function () {
    console.log('Server running at port ' + port);
});