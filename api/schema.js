var router = require('express').Router();

// Spalten

router.get('/columns/:tablename', async (req, res) => {
    var result = await req.db.query("SELECT * FROM information_schema.columns WHERE table_name = '" + req.params.tablename + "';");
    res.json(result.error || result.rows);
});

router.post('/columns/:tablename/:columnname/:columntype', async (req, res) => {
    var result = await req.db.query("ALTER TABLE " + req.params.tablename + " ADD " + req.params.columnname + " " + req.params.columntype + ";");
    res.json(result.error || result.rows);
});

router.delete('/columns/:tablename/:columnname', async (req, res) => {
    var result = await req.db.query("ALTER TABLE " + req.params.tablename + " DROP COLUMN " + req.params.columnname + ";");
    res.json(result.error || result.rows);
});

// Tabellen

router.get('/tables', async (req, res) => {
    var result = await req.db.query("SELECT * FROM information_schema.tables WHERE table_schema != 'pg_catalog' AND table_schema != 'information_schema';");
    res.json(result.rows);
});

router.post('/tables/:tablename', async (req, res) => {
    res.json(await req.db.query("CREATE TABLE " + req.params.tablename + " (id SERIAL);"));
});

router.delete('/tables/:tablename', async (req, res) => {
    res.json(await req.db.query("DROP TABLE " + req.params.tablename + ";"));
});

module.exports = router;