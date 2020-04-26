# PACKAGING

Erstellung und Konfiguration von Paketen samt Herunterladen als JSON.

Benötigt das Paket `setup`, damit der Tab `Pakete` angezeigt werden kann.

## Router

* `/api-packages` - Pakete erstellen, Inhalte managen und herunterladen

## Tabs

* `Setup : Pakete` - Tab in der Setup-App, der die Paketverwaltungs-View unter `/setup/packages` öffnet.

## Views

* `/setup/packages` - Pakete erstellen und herunterladen
* `/setup/packages/entities` - Festlegen, welche Tabelleninhalte zum Paket gehören
* `/setup/packages/fields` - Festlegen, welche Tabellenspalten zum Paket gehören

## Tabellen und Felder

Keine - alle notwendigen Felder werden bereits in der Grundinstallation mit `install.js` erstellt.
