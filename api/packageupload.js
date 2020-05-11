var router = require('express').Router();
var unzipper = require('unzipper');
var multer = require('multer');
var storage = multer.memoryStorage();
var upload = multer({ storage: storage });

// Wird sowohl von dieser API als auch von install.js benutzt
router.handleZipBuffer = async (db, buffer) => {
    var zipcontent = await unzipper.Open.buffer(buffer);
    var fileContent = (await zipcontent.files[0].buffer()).toString('utf8');
    var packagejson = JSON.parse(fileContent);
    var packagename = packagejson.name;
    // Paketinfos anlegen, alte löschen
    var rows = (await db.query("select id from packages where name='" + packagename + "';")).rows;
    for (var row of rows) {
        await db.query("delete from packageentities where packageid='" + row.id + "';");
        await db.query("delete from packagefields where packageid='" + row.id + "';");
        await db.query("delete from packages where id='" + row.id + "';");
    }
    var packageid = (await db.query("insert into packages (name, description) values ('" + packagename + "', '" + packagejson.description + "') returning id;")).rows[0].id;
    // Tabellen und Felder anlegen und erweitern
    for (var [tablename, fields] of Object.entries(packagejson.fields)) {
        await db.query("CREATE TABLE IF NOT EXISTS " + tablename + " (id UUID PRIMARY KEY DEFAULT uuid_generate_v4());");
        for (var [fieldname, datatype] of Object.entries(fields)) {
            await db.query("ALTER TABLE " + tablename + " ADD COLUMN IF NOT EXISTS " + fieldname + " " + datatype + ";");
            await db.query("insert into packagefields (packageid, tablename, fieldname) values ('" + packageid + "', '" + tablename + "', '" + fieldname + "');");
        }
    }
    // Inhalte einspielen
    for (var [tablename, entities] of Object.entries(packagejson.entities)) {
        for (var entity of entities) {
            var query = "INSERT INTO " + tablename + " (" + Object.keys(entity).join(',') + ") VALUES (" + Object.values(entity).map(value => {
                if ((typeof value) === 'object') value = JSON.stringify(value);
                return ((typeof value) === 'string') ? "'" + (value.replace(/\'/g, '\'\'')) + "'" : value
            }).join(',') + ") returning id;";
            var rows = (await db.query(query)).rows;
            var entityid = entity.id || rows[0].id;
            await db.query("insert into packageentities (packageid, tablename, entityid) values ('" + packageid + "', '" + tablename + "', '" + entityid + "');");
        }
    }
}

router.post('/', upload.single('file'), async (req, res) => {
    await router.handleZipBuffer(req.db, req.file.buffer);
    res.send();
});

module.exports = router;