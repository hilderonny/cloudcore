var router = require('express').Router();

router.get('/list/:tablename', (req, res) => {
    res.json(req.db.get(req.params.tablename));
});

router.get('/:tablename/:id', async (req, res) => {
    res.json(req.db.get(req.params.tablename)[req.params.id]);
});

// TODO Funktionen auf JSON umbauen

router.post('/:tablename', async (req, res) => {
    var id = Date.now();
    req.db.get(req.params.tablename)[id] = req.body;
    req.db.save(req.params.tablename);
    // TODO Evtl. Authentifizierung einbauen, owner?
    res.send(id);
});

router.put('/:tablename/:id', async (req, res) => {
    req.db.get(req.params.tablename)[id] = req.body;
    req.db.save(req.params.tablename);
    res.sendStatus(200);
});

router.delete('/:tablename/:id', async (req, res) => {
    delete req.db.get(req.params.tablename)[id];
    req.db.save(req.params.tablename);
    res.sendStatus(200);
});

module.exports = router;