/* global io */

/**
 * Arrange client library
 */
class Arrange {

    /**
     * Connect to server.
     * @param {String} url URL of the server, defaults to window.location at same host
     */
    constructor(url) {
        this.websocket = io(url);
    }

    /**
     * Creates a client and returns it with an id. When the name contains invalid characters
     * (all except lower letters), null is returned.
     */
    async createclient(clientname) {
        return this.dorequest('createclient', { clientname: clientname }, 'oncreateclient');
    }

    /**
     * Creates a datatype and returns it with an id. When the name contains invalid characters
     * (all except lower letters), null is returned.
     */
    async createdatatype(datatypename) {
        return this.dorequest('createdatatype', { datatypename: datatypename }, 'oncreatedatatype');
    }

    /**
     * Creates a field for a datatype. Returns the field with the generated id.
     * When the datatype or fieldtype does not exist, null is returned.
     */
    async createfield(datatypeid, fieldname, fieldtype) {
        return this.dorequest('createfield', { datatypeid: datatypeid, fieldname: fieldname, fieldtype: fieldtype }, 'oncreatefield');
    }

    /**
     * Creates an user within the given client.
     * Returns the user without a password but with the generated id.
     * When there is no client with the given name, null is returned.
     */
    async createuser(clientname, username, password) {
        return this.dorequest('createuser', { clientname: clientname, username: username, password: password }, 'oncreateuser');
    }

    /**
     * Delete a datatype and its corresponding database table.
     * When there is no datatype of the given id, nothing happens
     */
    async deletedatatype(datatypeid) {
        return this.dorequest('deletedatatype', { datatypeid: datatypeid }, 'ondeletedatatype');
    }

    /**
     * Delete a field of an object. All data of all objects in this field will be lost.
     * The field will be removed from the database table. When there is no field or datatype with the given id,
     * nothing happens.
     */
    async deletefield(datatypeid, fieldid) {
        return this.dorequest('deletefield', { datatypeid: datatypeid, fieldid: fieldid }, 'ondeletedatatype');
    }

    /**
     * Deletes an object of the given datatype and id.
     * When the datatype or object does not exists, nothing happens
     */
    async deleteobject(datatypeid, objectid) {
        return this.dorequest('deleteobject', { datatypeid: datatypeid, objectid: objectid }, 'ondeleteobject');
    }

    /**
     * Performs a request to the server and waits for the given result event
     */
    async dorequest(eventtosend, objecttosend, eventtowaitfor) {
        var ws = this.websocket;
        return new Promise(function (resolve, reject) {
            var timeout, callback;
            timeout = setTimeout(function () {
                ws.off(eventtowaitfor, callback);
                reject();
            }, 2000);
            callback = function (result) {
                clearTimeout(timeout);
                ws.off(eventtowaitfor, callback);
                resolve(result);
            };
            ws.on(eventtowaitfor, callback);
            ws.emit(eventtosend, objecttosend);
        });
    }

    /**
     * Returns all datatypes with their fields. There is no need to obtain
     * information about special datatypes or fields separately because this call
     * contains a very small amount of data, so it can be retrieved all at once.
     */
    async getdatatypes() {
        return this.dorequest('getdatatypes', null, 'ongetdatatypes');
    }

    /**
     * Login an user
     */
    async login(username, password) {
        return this.dorequest('login', { username: username, password: password }, 'onlogin');
    }

    /**
     * Logout the currently logged in user
     */
    async logout() {
        return this.dorequest('logout', null, 'onlogout');
    }

    /**
     * Creates or updates an object. When the data parameter contains
     * an id field and an object with this id exists, it will be updated.
     * Otherwise a new object will be created.
     * Only those fields get updated which are contained in the data.
     * The response contains the full object with an id field.
     */
    async saveobject(datatypeid, data) {
        return this.dorequest('saveobject', { datatypeid: datatypeid, data: data }, 'onsaveobject');
    }

    /**
     * Connect to the server
     */
    static async connect() {
        return new Arrange();
    }

}
