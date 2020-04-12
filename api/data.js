var router = require('express').Router();

router.get('/list/:tablename', async (req, res) => {
    var result = await req.db.query(`SELECT * FROM ${req.params.tablename};`);
    res.json(result.error || result.rows);
});

router.get('/list/:tablename/:columns', async (req, res) => {
    var result = await req.db.query(`SELECT ${req.params.columns} FROM ${req.params.tablename};`);
    res.json(result.error || result.rows);
});

router.get('/list/:tablename/:columns/:filter', async (req, res) => {
    var result = await req.db.query(`SELECT ${req.params.columns} FROM ${req.params.tablename} ${req.params.filter};`);
    res.json(result.error || result.rows);
});

router.get('/:tablename/:id', async (req, res) => {
    var result = await req.db.query("SELECT * FROM " + req.params.tablename + " WHERE id = '" + req.params.id + "';");
    res.json(result.error || result.rows);
});

router.post('/:tablename', async (req, res) => {
    var query = "INSERT INTO " + req.params.tablename + " (" + Object.keys(req.body).join(',') + ") VALUES (" + Object.values(req.body).map(value => ((typeof value) === 'string') ? "'" + (value.replace(/\'/g, '\'\'')) + "'" : value).join(',') + ") RETURNING id;";
    var result = await req.db.query(query);
    res.json(result.error || result.rows);
});

router.put('/:tablename/:id', async (req, res) => {
    var query = "UPDATE " + req.params.tablename + " SET " + Object.keys(req.body).map(key => {
        var value = req.body[key];
        return key + "=" + (((typeof value) === 'string') ? "'" + (value.replace(/\'/g, '\'\'')) + "'" : value);
    }).join(',') + " WHERE id='" + req.params.id + "';";
    var result = await req.db.query(query);
    res.json(result.error || result.rows);
});

router.delete('/:tablename/:id', async (req, res) => {
    var result = await req.db.query("DELETE FROM " + req.params.tablename + " WHERE id = '" + req.params.id + "';");
    res.json(result.error || result.rows);
});

module.exports = router;