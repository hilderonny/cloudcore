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
    function _handleSearch(params) {
      return db.search(params.db, params.collection, params.filter, params.options);
    }
    
    /* params = {
     *  db: string,
     *  collection: string,
     *  data: object
     */
    function _handleCreate(params) {
      return db.create(params.db, params.collection, params.data);
    }
    
    /* params = {
     *  db: string,
     *  collection: string,
     *  _id: string,
     *  options?: object
     */
    function _handleRead(params) {
      return db.read(params.db, params.collection, params._id, params.options);
    }
    
    /* params = {
     *  db: string,
     *  collection: string,
     *  _id: string,
     *  data: object
     */
    function _handleUpdate(params) {
      return db.update(params.db, params.collection, params._id, params.data);
    }
    
    /* params = {
     *  db: string,
     *  collection: string,
     *  _id: string
     */
    function _handleDelete(params) {
      return db.delete(params.db, params.collection, params._id);
    }
  
    
    webSocketServer.registerMessageHandler('search', _handleSearch);
    webSocketServer.registerMessageHandler('create', _handleCreate);
    webSocketServer.registerMessageHandler('read', _handleRead);
    webSocketServer.registerMessageHandler('update', _handleUpdate);
    webSocketServer.registerMessageHandler('delete', _handleDelete);
    
  });