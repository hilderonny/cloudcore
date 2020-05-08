module.exports = async (req, _, next) => {
    if (!req.user) {
        // Erst mal nur Standarduser 'system' benutzen, falls das auth-Paket installiert wurde
        // TODO: Token validieren und korrekten User ermitteln
        var systemusers = (await req.db.query("SELECT id, username FROM users WHERE username='system';")).rows;
        req.user = systemusers && systemusers.length > 0 ? systemusers[0] : {};
    }
    next();
};