# Pakete

Die Grundinstallation bringt nur das automatische Ausführen von views und routern sowie eine grundlegende Benutzerbehandlung mit. Alles andere kommt durch Pakete. Das `core` Paket sollte immer installiert werden, `auth` ist wichtig, wenn Mehrbenutzerfähigkeit gebraucht wird.

## Installation von Paketen

Das geht, indem man die ZIP-Datei eines Paketes an die API `/api/packageupload` sendet:

```sh
curl -F file=@tests/pfad_zu_paket_json.zip http://localhost/api/packageupload/
```

## [core - Kernfunktionen und Authentifizierung](packages/CORE.md)

* Anmeldung und Registrierung verschiedener Benutzer
* Grundlegende router-Funktionen für Tabellenschema- und Datenmanipulation
* Basis-Stylesheet, an Salesforce Lightning Design System angelehnt
* Installieren von Paketen

## [packaging - Paketierung](packages/PACKAGING.md)

* Managen und Herunterladen von Paketen

## [setup - Einstellungen](packages/SETUP.md)

* App und Tabs für Setup
* Code-Editor
* Tabelleneditor
* SQL Konsole