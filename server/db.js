const monk = require('monk');

module.exports = (function (url) {

    const dbs = {};

    function getCollection(dbName, collectionName) {
        var db = dbs[dbName];
        if (!db) {
            db = monk(`${url}/${dbName}`);
            dbs[dbName] = db;
        }
        return db.get(collectionName);
    }

    return {

        search: (dbName, collectionName, filter, options) => {
            return getCollection(dbName, collectionName).find(filter, options);
        },


        create: async (dbName, collectionName, data) => {
            return getCollection(dbName, collectionName).insert(data);
        },


        read: async (dbName, collectionName, _id) => {
            return getCollection(dbName, collectionName).findOne(_id);
        },


        update: async (dbName, collectionName, _id, data) => {
            return getCollection(dbName, collectionName).findOneAndUpdate(_id, data);
        },


        delete: async (dbName, collectionName, _id) => {
            return getCollection(dbName, collectionName).findOneAndDelete(_id);
        },

    }

});