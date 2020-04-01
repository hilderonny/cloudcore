# Öffentliche Standard-APIs

## /api/schema/columns

Spalten an Tabellen bearbeiten.

| Methode | Endpunkt | Bedeutung |
|---|---|---|
| GET | /api/schema/columns/:tablename | Alle Spalten der Tabelle `tablename` auflisten |
| POST | /api/schema/columns/:tablename/:columnname/:columntype | Spalte mit Name `columnname` in Tabelle `tablename` anlegen. `columntype` gibt dabei den SQL Typen an, z.B. "VARCHAR NOT NULL". |
| DELETE | /api/schema/columns/:tablename/:columnname | Spalte mit Name `columnname` aus Tabelle `tablename` löschen |

## /api/schema/tables

Dient zum Manipulieren von Tabellen.

| Methode | Endpunkt | Bedeutung |
|---|---|---|
| GET | /api/schema/tables | Alle Tabellen auflisten |
| POST | /api/schema/tables/:tablename | Tabelle mit Name `tablename` anlegen |
| DELETE | /api/schema/tables/:tablename | Tabelle mit Name `tablename` löschen |
