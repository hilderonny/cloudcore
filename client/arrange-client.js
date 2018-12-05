const ArrangeClient = (function () {

    var _webSocket;
    const _messageListeners = [];

    function _handleMessage(message) {
        const data = JSON.parse(message.data);
        _messageListeners.forEach(function (listener) {
            listener(data);
        });
    }

    function _addMessageListener(listener) {
        _messageListeners.push(listener);
    }

    function _removeMessageListener(listener) {
        _messageListeners.splice(_messageListeners.indexOf(listener), 1);
    }

    function _send(obj) {
        if (!_webSocket || _webSocket.readyState !== 1) return;
        _webSocket.send(JSON.stringify(obj));
    }

    /**
     * Sends a request message and waits for a response
     */
    function _request(req) {
        return new Promise(function (resolve, reject) {
            try {
                const str = JSON.stringify(req);
                const responseListener = function (msg) {
                    if (!msg || !msg.response || !msg.request === str) return;
                    _removeMessageListener(responseListener);
                    resolve(msg.response);
                };
                _addMessageListener(responseListener);
                _send(req);
            } catch (ex) {
                reject(ex);
            }
        });
    }

    function _search(dbName, collectionName, filter, options) {
        return _request({
            type: 'search',
            db: dbName,
            collection: collectionName,
            filter: filter,
            options: options
        });
    }

    function _create(dbName, collectionName, data) {
        return _request({
            type: 'create',
            db: dbName,
            collection: collectionName,
            data: data
        });
    }

    function _read(dbName, collectionName, _id, options) {
        return _request({
            type: 'read',
            db: dbName,
            collection: collectionName,
            _id: _id,
            options: options
        });
    }

    function _update(dbName, collectionName, _id, data) {
        return _request({
            type: 'update',
            db: dbName,
            collection: collectionName,
            _id: _id,
            data: data
        });
    }

    function _delete(dbName, collectionName, _id) {
        return _request({
            type: 'delete',
            db: dbName,
            collection: collectionName,
            _id: _id
        });
    }

    function _broadcast(message) {
        message.type = 'broadcast';
        _send(message);
    }

    return {

        /**
         * Async function which resolves when the connection was established
         */
        connect: function (url) {
            const self = this;
            return new Promise(function (resolve, reject) {
                _webSocket = new WebSocket(url);
                _webSocket.onmessage = _handleMessage;
                _webSocket.onopen = function () {
                    resolve(self);
                };
                _webSocket.onerror = function (err) {
                    reject(err);
                };
            });
        },

        addMessageListener: _addMessageListener,

        search: _search,
        create: _create,
        read: _read,
        update: _update,
        delete: _delete,
        broadcast: _broadcast

    }

});
