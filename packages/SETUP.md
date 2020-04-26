# SETUP

In der App Setup sind der Code-Editor, die SQL-Konsole sowie die Oberfläche zur Bearbeitung von TZabellen und deren Inhalte enthalten.

Dient als Grundlage für andere Erweiterungen, wie etwa das `packaging` - Paket, welche neue Tabs dem Setup hinzufügen.

## Apps

* `Setup` - Setup halt

## Router

* `/api-sqlconsole` - API für SQL Konsole
* `/backup` - Kompletten SQL Dump der Datenbank herunterladen

## Tabs

* `Setup : Editor` - View `/setup/editor`
* `Setup : SQL Konsole` - View `/setup/sqlconsole`
* `Setup : Tabellen` - View `/setup/tables`

## Views

* `/setup/editor` - Code-Editor im Stil von VS Code, mit dem Views und Router bearbeitet werden können
* `/setup/sqlconsole` - SQL Konsole für direkten Datenbankzugriff
* `/setup/tables` - Tabelleneditor
* `/setup/tables/content` - Tabelleninhalt auflisten
* `/setup/tables/content/edit` - Inhalt einer Tabellenzeile bearbeiten
* `/setup/tables/columns` - Felder einer Tabelle auflisten
* `/setup/tables/columns/create` - Feld an Tabelle anfügen

## Tabellen und Felder

Keine.