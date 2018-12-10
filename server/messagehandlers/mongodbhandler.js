/**
 * Handles follwing message types with the help of the database:
 * - search (db, collection, filter?, options?)
 * - create (db, collection, data)
 * - read (db, collection, _id)
 * - update (db, collection, _id, data)
 * - delete (db, collection, _id)
 */
module.exports = (function(db, webSocketServer) {

    /* params = {
     *  db: string,
     *  collection: string,
     *  filter?: object,
     *  options?: object
     */
    async function _handleSearch(params) {
      const result = await db.search(params.db, params.collection, params.filter, params.options);
      if (params.collection === 'users') result.forEach(function(e) { delete e.password; });
      return result;
    }
    
    /* params = {
     *  db: string,
     *  collection: string,
     *  data: object
     */
    async function _handleCreate(params, socket) {
      if (!socket.loggedInUserId) return { error: 'Not logged in' };
      params.data._ownerId = socket.loggedInUserId;
      const result = await db.create(params.db, params.collection, params.data);
      if (params.collection === 'users') delete result.password;
      return result;
    }
    
    /* params = {
     *  db: string,
     *  collection: string,
     *  _id: string,
     *  options?: object
     */
    async function _handleRead(params) {
      const result = await db.read(params.db, params.collection, params._id, params.options);
      if (!result) return { error: 'Not found' };
      if (params.collection === 'users') delete result.password;
      return result;
    }
    
    /* params = {
     *  db: string,
     *  collection: string,
     *  _id: string,
     *  data: object
     */
    async function _handleUpdate(params, socket) {
      if (!socket.loggedInUserId) return { error: 'Not logged in' };
      const result = await db.update(params.db, params.collection, { _id: params._id, _ownerId: socket.loggedInUserId }, { $set: params.data });
      if (!result) return { error: 'Not allowed' };
      if (params.collection === 'users') delete result.password;
      return result;
    }
    
    /* params = {
     *  db: string,
     *  collection: string,
     *  _id: string
     */
    async function _handleDelete(params, socket) {
      if (!socket.loggedInUserId) return { error: 'Not logged in' };
      const result = await db.delete(params.db, params.collection, { _id: params._id, _ownerId: socket.loggedInUserId });
      if (!result) return { error: 'Not allowed' };
      if (params.collection === 'users') delete result.password;
      return result;
    }

    /* params = {
     *  db: string,
     *  name: string,
     *  password: string
     */
    async function _handleLogin(params, socket) {
      const user = await db.read(params.db, 'users', { name: params.name }, '_id password');
      if (user && require('bcryptjs').compareSync(params.password, user.password)) {
        socket.loggedInUserId = user._id;
        delete user.password;
        return user;
      } else {
        delete socket.loggedInUserId;
        return null;
      }
    }
  
    
    webSocketServer.registerMessageHandler('search', _handleSearch);
    webSocketServer.registerMessageHandler('create', _handleCreate);
    webSocketServer.registerMessageHandler('read', _handleRead);
    webSocketServer.registerMessageHandler('update', _handleUpdate);
    webSocketServer.registerMessageHandler('delete', _handleDelete);
    webSocketServer.registerMessageHandler('login', _handleLogin);
    
  });
