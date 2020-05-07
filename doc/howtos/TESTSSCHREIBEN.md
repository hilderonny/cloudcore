# Tests schreiben

Wie schreibt man Unit Tests und wie mockt man dabei Dateisystem und Datenbankaufrufe?

## Vorbereitung

Zuerst wird Jest installiert, am Besten

```sh
npm install --save-dev jest
```

In der `package.json` wird ein Abschnitt für die Tests eingefügt:

```json
{
    "scripts": {
        "test": "jest"
    }
}
```

Dann können die Tests von der Kommandozeile aus gestartet werden:

```sh
npm test
```

## Mocking

Ich mocke stets komplette Module, die per `require()` eingebunden werden. Dazu wird ein Unterverzeichnis `__mocks__` angelegt, in welches Scripte mit demselben Namen wie das zu mockende Modul gelegt werden ([Anleitung](https://jestjs.io/docs/en/manual-mocks#examples)). Beispiel für Dateisystemmodul `fs`:

```js
var fs = jest.genMockFromModule('fs');

fs.readFileSync = (path) => {
    // Dummy config.json
    if (path.endsWith('/config.json')) {
        return JSON.stringify({
            "PORT": "65080"
        });
    }
}

module.exports = fs;
```

Für die Datenbank habe ich das `pg` - Modul gemockt, welches nach außen dieselben Aufrufe bereitstellt, intern aber eine SQLite Datenbank im Speicher benutzt, da diese keine separate Installation benötigt und die Aufrufe simpel genug sind, dass sie auch von SQLite verstanden werden können (zumindest die Aufrufe aus den Grundpaketen).

## Testfunktionen schreiben

Die Testdateien müssen auf `.test.js` enden, um von Jest standardmäßig gefunden zu werden. Die Syntax ähnelt dabei der von `mocha`. Alle testdateien liegen im Unterordner `tests`.
