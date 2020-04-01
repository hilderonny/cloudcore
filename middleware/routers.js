
module.exports = async (req, res, next) => {
    var rootpath = req.url.substring(0, req.url.indexOf('/', 1));
    var result = await req.db.query("SELECT code FROM routers WHERE url = $1;", [rootpath]);
    if (result.error) return res.json(result.error);
    if (result.rows.length < 1) return next();
    var code = result.rows[0].code;
    var m = new module.constructor();
    m.paths = module.paths;
    m._compile(code, '');
    req.url = req.url.substring(rootpath.length);
    m.exports.handle(req, res, next);
};
