var router = require('express').Router();

router.get('/hubbele/:tablename', async (req, res) => {
    var result = await req.db.query("SELECT * FROM information_schema.tables WHERE table_name = $1;", [req.params.tablename]);
    res.json(result.rows);
});

router.get('/eins', async (req, res) => {
    res.send("ODIN");
});

router.get('/zwei/:zahl', async (req, res) => {
    res.send("TWO " + req.params.zahl);
});

module.exports = router;
