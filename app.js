var bodyParser = require('body-parser');
var express = require('express');
var fs = require('fs');
var auth = require('./middleware/auth');
var db = require('./middleware/db');
var routers = require('./middleware/routers');
var views = require('./middleware/views');

// Konfiguration aus config.json lesen
var configfilename = __dirname + '/config.json';
if (!fs.existsSync(configfilename)) {
    console.error(configfilename + ' existiert nicht. Kann nicht starten!');
    process.exit();
}
var config = JSON.parse(fs.readFileSync(configfilename));

// Server konfigurieren
var app = express();
app.use(bodyParser.raw()); // Content-type: application/octet-stream
app.use(bodyParser.text()); // Content-type: text/plain
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(db(config));
app.use(auth); // Erst nach db, weil die Datenbankfunktionen benutzt werden.
app.config = config;

// Salesforce Lightning Design System unter /assets einbinden, siehe https://www.lightningdesignsystem.com/platforms/heroku/
app.use('/assets', express.static(__dirname + '/node_modules/@salesforce-ux/design-system/assets'));

// Monaco code editor
app.use('/monaco-editor', express.static(__dirname + '/node_modules/monaco-editor'));

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

module.exports = app;