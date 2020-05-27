var bodyParser = require('body-parser');
var express = require('express');
var fs = require('fs');
var auth = require('./middleware/auth');
var db = require('./middleware/db');

// Konfiguration aus config.json lesen
var config = JSON.parse(fs.readFileSync(__dirname + '/config.json'));

// Datenverzeichnis ggf. anlegen
if (!fs.existsSync(config.DATAPATH)) fs.mkdirSync(config.DATAPATH);

// Server konfigurieren
var app = express();
app.use(bodyParser.text()); // Content-type: text/plain
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(db(config.DATAPATH));
app.use(auth); // Erst nach db, weil die Datenbankfunktionen benutzt werden.
app.config = config;

// Statisches HTML
app.use('/', express.static(__dirname + '/public'));

// Monaco code editor
app.use('/monaco-editor', express.static(__dirname + '/node_modules/monaco-editor'));

// APIs einbinden
fs.readdirSync(__dirname + '/api').forEach(apifile => {
    var fileparts = apifile.split('.');
    if (fileparts[fileparts.length - 1] !== 'js') return;
    var apiname = fileparts[0];
    app.use('/api/' + apiname, require('./api/' + apiname));
});

module.exports = app;