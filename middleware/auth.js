
module.exports = async (req, _, next) => {
    if (!req.user) {
        // Erst mal nur Standarduser 'system' benutzen
        // TODO: Token validieren und korrekten User ermitteln
        req.user = (await req.db.query("SELECT id, username FROM users WHERE username='system';")).rows[0];
    }
    next();
};