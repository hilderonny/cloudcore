var fs = require('fs');

module.exports = (datapath) => {

    var tables = {}; // Hält Datenbankinhalte inMemory

    function preparetable(data) {
        return {
            lastmodified: Date.now(),
            data: data,
            save: function() {
                this.lastmodified = Date.now();
            }
        };
    }

    for (var datafilename of fs.readdirSync(datapath)) {
        var tablename = datafilename.split('.')[0];
        tables[tablename] = preparetable(JSON.parse(fs.readFileSync(datapath + '/' + datafilename)));
    }

    var lastsaved = Date.now();

    // Einmal je Minute speichern
    setInterval(() => {
        for (var tablename in tables) {
            var table = tables[tablename];
            if (table.lastmodified > lastsaved) {
                fs.writeFileSync(datapath + '/' + tablename + '.json', JSON.stringify(table.data));
                console.log('Speichere ' + tablename);
            }
        }
        lastsaved = Date.now();
    }, 1000);

    return (req, _, next) => {
        req.db = {
            get: (tablename) => { // Direkter Zugriff auf Tabelleninhalt
                var table = tables[tablename];
                if (!table) {
                    table = preparetable(JSON.parse(fs.readFileSync(datapath + '/' + datafilename)));
                    tables[tablename] = table;
                    table.save();
                }
                return table.data;
            }
        };
        next();
    };
};
