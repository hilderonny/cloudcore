// Zugriffe auf das Dateisystem mocken

var fs = jest.genMockFromModule('fs');

fs.readFileSync = (path) => {
    // Dummy config.json
    if (path.endsWith('/config.json')) {
        return JSON.stringify({
            "PORT": "65080"
        });
    }
    throw 'Path "' + path + '" not supported by mock';
}

module.exports = fs;