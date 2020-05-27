/**
 * Dieses Skript ist ein kleiner Startwrapper für die App.
 * Das musste getrennt werden, damit die Tests die App benutzen können.
 * Die Anwendung selbst ist in app.js drin.
 */
var http = require('http');
var app = require('./app');

// Server starten
var server = http.createServer(app);
server.listen(app.config.PORT, function () {
    console.log('Server running at port ' + app.config.PORT);
});