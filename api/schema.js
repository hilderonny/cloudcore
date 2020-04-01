var router = require('express').Router();
var { Client } = require('pg');

router.get('/', async (req, res, next) => {
    var client = new Client();
    await client.connect();
    var now = await client.query('SELECT NOW()');
    await client.end();
    res.send('Hello World! ' + JSON.stringify(now));
});

module.exports = router;