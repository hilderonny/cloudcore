const WebSocket = require('ws');

module.exports = (function(wssConfig) {

  const _webSocketServer = new WebSocket.Server(wssConfig);
  const _messageHandlers = {};
  const _openSockets = [];
  
  function _registerMessageHandler(messageType, handler) {
    var handlerList = _messageHandlers[messageType];
    if (!handlerList) {
      handlerList = [];
      _messageHandlers[messageType] = handlerList;
    }
    handlerList.push(handler);
  }
  
  function _handleMessage(socket, message) {
    try {
      const json = JSON.parse(message);
      const type = json.type;
      if (!type) return;
      const handlers = _messageHandlers[type];
      if (!handlers) return;
      handlers.forEach(function(handler) {
        handler(json, socket).then(function(result) { // socket is passed optionally for database authentication
          // Only send response when handler returns anything useful
          if ((typeof(result) !== 'undefinded') && (socket.readyState === 1)) socket.send(JSON.stringify({ request: json, response: result }));
        }, function(error) { /* Ignore rejections, they are used to prevent response sending, e.g. for broadcasts */ });
      });
    } catch(ex) {
      console.log(ex);
    }
  }
  
  _webSocketServer.on('connection', function (socket) {
    
    _openSockets.push(socket);
    
    socket.on('close', function() {
      _openSockets.splice(_openSockets.indexOf(socket), 1);
    });
    
    /* Message must be in JSON format:
     * {
     *   type: message type identifier used to determine responsible message handler
     *   ...: other properties relevant for message handlers
     */
    socket.on('message', function (message) {
      _handleMessage(socket, message);
    });
    
  });
  
  return {
    
    /**
     * List of all currently connected client sockets.
     * Used for broadcasting
     */
    openSockets: _openSockets,
    
    /**
     * messageType, handler
     */
    registerMessageHandler: _registerMessageHandler
    
  }
  
});