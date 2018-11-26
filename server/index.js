const WebSocket = require('ws');

const wss = new WebSocket.Server({ port: 42001 });

const Arrange = {
    createField: function (socket, data) { console.log(socket, data); },
    createObject: function (socket, data) { console.log(socket, data); },
    createType: function (socket, data) { console.log(socket, data); },
    createUser: function (socket, data) { console.log(socket, data); },
    deleteField: function (socket, data) { console.log(socket, data); },
    deleteObject: function (socket, data) { console.log(socket, data); },
    deleteType: function (socket, data) { console.log(socket, data); },
    deleteUser: function (socket, data) { console.log(socket, data); },
    login: function (socket, data) { console.log(socket, data); },
    logout: function (socket, data) { console.log(socket, data); },
    updateField: function (socket, data) { console.log(socket, data); },
    updateObject: function (socket, data) { console.log(socket, data); },
    updateType: function (socket, data) { console.log(socket, data); },
    updateUser: function (socket, data) { console.log(socket, data); },
}

wss.on('connection', function connection(ws) {

    ws.on('message', function incoming(message) {
        try {
            const data = JSON.parse(message);
            const keys = Object.keys(data);
            if (keys.length !== 1) return;
            const functionName = keys[0];
            if (!Arrange[functionName]) return
            Arrange[functionName](this, data[functionName]);
        } catch (ex) {
            console.error(ex);
        }
    });

    ws.send('Geh strullern!');
});