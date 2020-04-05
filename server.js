var bodyParser = require('body-parser');
var express = require('express');
var http = require('http');
var fs = require('fs');
var db = require('./middleware/db');
var routers = require('./middleware/routers');
var views = require('./middleware/views');

// Server konfigurieren
var app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(db);

// Salesforce Lighning Design System unter /assets einbinden, siehe https://www.lightningdesignsystem.com/platforms/heroku/
app.use('/assets', express.static(__dirname + '/node_modules/@salesforce-ux/design-system/assets'));

// VUE.js
app.use('/vue', express.static(__dirname + '/node_modules/vue/dist'));

// Monaco code editor
app.use('/monaco-editor', express.static(__dirname + '/node_modules/monaco-editor'));

// Basis-Funktionen bereitstellen
app.use('/vger', express.static(__dirname + '/vger'));

// APIs einbinden
fs.readdirSync(__dirname + '/api').forEach(apifile => {
    var fileparts = apifile.split('.');
    if (fileparts[fileparts.length - 1] !== 'js') return;
    var apiname = fileparts[0];
    app.use('/api/' + apiname, require('./api/' + apiname));
});

// dynamische Router behandeln
app.use(routers);

// dynamische Views behandeln
app.use(views);

// Server starten
var port = process.env.PORT || 8080;
var server = http.createServer(app);
server.listen(port, function () {
    console.log('Server running at port ' + port);
});