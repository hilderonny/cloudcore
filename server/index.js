const WebSocket = require('ws');

const wss = new WebSocket.Server({ port: 42001 });

wss.on('connection', function connection(ws) {
  console.log('Connected');
  ws.on('message', function incoming(message) {
    console.log('received: %s', message);
  });
  ws.send('Geh pupsen!');
});