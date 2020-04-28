
module.exports = async (req, res, next) => {
    var result = await req.db.query("SELECT content, contenttype FROM views WHERE url='" + req.path + "';");
    if (result.error) return res.json(result.error);
    if (result.rows.length < 1) return next();
    var row = result.rows[0];
    res.type(row.contenttype).send(row.content);
};
