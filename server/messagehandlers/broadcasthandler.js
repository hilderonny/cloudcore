/**
 * Broadcasts messages with type "broadcast" to all connected sockets
 */
module.exports = (function(webSocketServer) {
  
    function _broadcast(message) {
      webSocketServer.openSockets.forEach(function(socket, index) {
        if (socket.readyState === 1) socket.send(JSON.stringify(message));
      });
      return Promise.reject();
    }
    
    webSocketServer.registerMessageHandler('broadcast', _broadcast);
    
  });