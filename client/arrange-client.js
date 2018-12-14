class ArrangeClient {

    constructor(url) {
        this.url = url;
        this.user = {}; // TODO: Weg damit!
    }

    request(data) {
        return new Promise((function(resolve, reject) {
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function() {
                if (this.readyState == 4) {
                    if (this.status == 200) {
                        try {
                            const result = JSON.parse(this.responseText);
                            resolve(result);
                        } catch (ex) {
                            reject(ex);
                        }
                    } else {
                        reject({ status: this.status, responseText: this.responseText });
                    }
                }
            };
            xmlhttp.open('POST', this.url);
            xmlhttp.setRequestHeader('Content-Type', 'application/json');
            xmlhttp.send(JSON.stringify(data));
        }).bind(this));
    }

    search(dbName, collectionName, filter, options) {
        return this.request({
            type: 'search',
            db: dbName,
            collection: collectionName,
            filter: filter,
            options: options
        });
    }

    create(dbName, collectionName, data) {
        return this.request({
            type: 'create',
            token: this.user.token,
            db: dbName,
            collection: collectionName,
            data: data
        });
    }

    read(dbName, collectionName, _id, options) {
        return this.request({
            type: 'read',
            db: dbName,
            collection: collectionName,
            _id: _id,
            options: options
        });
    }

    update(dbName, collectionName, _id, data) {
        return this.request({
            type: 'update',
            token: this.user.token,
            db: dbName,
            collection: collectionName,
            _id: _id,
            data: data
        });
    }

    delete(dbName, collectionName, _id) {
        return this.request({
            type: 'delete',
            token: this.user.token,
            db: dbName,
            collection: collectionName,
            _id: _id
        });
    }

    async login(dbName, name, password) {
        delete this.user; // Delete previous user information
        const result = await this.request({
            type: 'login',
            db: dbName,
            name: name,
            password: password
        });
        this.user = result;
        return result;
    }

    async register(dbName, name, password) {
        delete this.user; // Delete previous user information
        const result = await this.request({
            type: 'register',
            db: dbName,
            name: name,
            password: password
        });
        this.user = result;
        return result;
    }

}