var bodyParser = require('body-parser');
var express = require('express');
var http = require('http');
var fs = require('fs');
var db = require('./middleware/db');

// Server konfigurieren
var app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(db);

// APIs einbinden
fs.readdirSync(__dirname + '/api').forEach(apifile => {
    var fileparts = apifile.split('.');
    if (fileparts[fileparts.length - 1] !== 'js') return;
    var apiname = fileparts[0];
    app.use('/api/' + apiname, require('./api/' + apiname));
});

// Server starten
var port = process.env.PORT || 8080;
var server = http.createServer(app);
server.listen(port, function () {
    console.log('Server running at port ' + port);
});