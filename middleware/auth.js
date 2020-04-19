var queryparser = require('pg-query-parser');

module.exports = async (req, _, next) => {
    var directquery = req.db.query;
    req.db.query = async (query) => {
        var parsedquery = queryparser.parse(query).query;
        var deparsedquery = queryparser.deparse(parsedquery);
        console.log(query, parsedquery, deparsedquery);
        return await directquery(query);
    }
    if (!req.user) {
        // Erst mal nur Standarduser 'system' benutzen
        // TODO: Token validieren und korrekten User ermitteln
        req.user = (await req.db.query("SELECT id, username FROM users WHERE username='system';")).rows[0];
    }
    next();
};