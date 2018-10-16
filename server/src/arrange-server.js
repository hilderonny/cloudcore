var express = require('express');
var http = require('http');
var socketio = require('socket.io');

class ArrangeServer {

    constructor(port, db) {
        var self = this;
        self.eventhandlers = {};
        self.db = db;
        // HTTP server
        self.app = express();
        self.httpserver = http.Server(self.app);
        // Websockets
        self.io = socketio(self.httpserver);
        // Handle incoming connection
        self.io.on('connection', function (socket) {
            // iterate over registered event handlers
            var eventnames = Object.keys(self.eventhandlers);
            for (var i = 0; i < eventnames.length; i++) {
                // Register event on socket
                self.registersocketeventhandler(socket, eventnames[i]);
            }
        });

        // Register default events

        self.registereventhandler('createclient', async function (socket, data) {
            if (!socket.user || !socket.user.isadmin) return socket.emit('oncreateclient', undefined);
            var client = await db.createclient(data.name);
            socket.emit('oncreateclient', {
                id: client.id,
                name: client.name
            });
        });

        self.registereventhandler('createuser', async function (socket, data) {
            if (!socket.user || !socket.user.isadmin) socket.emit('oncreateuser', undefined);
            var user = await db.createUser(data.clientid, data.username, data.password);
            socket.emit('oncreateuser', {
                id: user.id,
                clientid: user.clientid,
                username: user.username
            });
        });

        self.registereventhandler('disconnect', async function (socket) {
            if (socket.user) await db.logout(socket.user.username);
            delete socket.user;
        });

        self.registereventhandler('login', async function (socket, data) {
            if (socket.user) await db.logout(socket.user.username);
            var user = await db.login(data.username, data.password);
            if (!user) return socket.emit('onlogin', undefined);
            socket.user = user;
            socket.emit('onlogin', {
                id: user.id,
                clientid: user.clientid,
                username: user.username,
                isadmin: user.isadmin
            });
        });

        self.registereventhandler('logout', async function (socket) {
            if (socket.user) await db.logout(socket.user.username);
            delete socket.user;
            socket.emit('onlogout', undefined);
        });

        // Start
        var listener = self.httpserver.listen(port, function () {
            console.log('Arrange server is listening on port ' + listener.address().port);
        });

    }

    handleincomingevent(socket, eventname, incomingdata) {
        var eventhandlers = this.eventhandlers[eventname];
        if (!eventhandlers) return;
        for (var i = 0; i < eventhandlers.length; i++) {
            eventhandlers[i](socket, incomingdata);
        }
    }

    registereventhandler(eventname, handlercallback) {
        if (!this.eventhandlers[eventname]) this.eventhandlers[eventname] = [];
        this.eventhandlers[eventname].push(handlercallback);
    }
  
    registersocketeventhandler(socket, eventname) {
      var self = this;
        socket.on(eventname, async function (incomingdata) {
            console.log(eventname);
            self.handleincomingevent(socket, eventname, incomingdata);
        });
    }

    static async run(port, db) {
        // Database
        await db.init();
        return new ArrangeServer(port, db);
    }

}

module.exports = ArrangeServer;
