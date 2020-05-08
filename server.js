var http = require('http');
var app = require('./app');

// Server starten
var server = http.createServer(app);
server.listen(app.config.PORT, function () {
    console.log('Server running at port ' + app.config.PORT);
});