var router = require('express').Router();

router.get('/', async (req, res, _) => {
    var result = await req.db.query('SELECT * FROM pg_catalog.pg_tables');
    res.json(result);
});

router.get('/tables', async (req, res, _) => {
    var result = await req.db.query("SELECT * FROM pg_catalog.pg_tables WHERE schemaname != 'pg_catalog' AND schemaname != 'information_schema';");
    res.json(result);
});

module.exports = router;