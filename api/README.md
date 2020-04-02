# Öffentliche Standard-APIs

## /api/data/:tablename

Daten aus bestimmten Tabellen auslesen und reinschreiben.

| Methode | Endpunkt | Bedeutung |
|---|---|---|
| GET | /list/:tablename | Alle Einträge der Tabelle `tablename` auflisten. |
| GET | /list/:tablename/:columns | Alle Einträge der Tabelle `tablename` auflisten. `columns` kann "*" oder eine kommaseparierte Liste von Spaltennamen sein, z.B. "id,url". |
| GET | /list/:tablename/:columns/:filter | Alle Einträge der Tabelle `tablename` auflisten. Dabei kann `filter` einen Filter oder eine Sortierung in SQL Syntax darstellen, z.B. "WHERE x=y ORDER BY z". `columns` kann "*" oder eine kommaseparierte Liste von Spaltennamen sein, z.B. "id,url". |
| GET | /:tablename/:id | Einen Eintrag mit der gegebenen `id` zurück liefern |
| POST | /:tablename | Neues Element in Tabelle `tablename` anlegen. Im JSON-Body muss dabei der Datensatz enthalten sein. |
| PUT | /:tablename/:id | Element in Tabelle `tablename` überschreiben. Im JSON-Body muss dabei der Datensatz enthalten sein. Es werden nur die Spalten überschrieben, die im Datensatz enthalten sind. |
| DELETE | /:tablename/:id | Element mit gegebener `id` aus Tabelle `tablename` löschen |

## /api/routers/:routername

Dynamische serverseitige Router, die in der Datenbank liegen.
Dazu muss die Tabelle `router` existieren, die in der Spalte `code` den JS-Code des Routers enthält.
In der Spalte `name` muss der Name des Routers (`routername`) enthalten sein.
Ist so ähnlich wie Apex-Klassen mit zugewiesenen Endpoints in Salesforce.

## /api/schema/columns

Spalten an Tabellen bearbeiten.

| Methode | Endpunkt | Bedeutung |
|---|---|---|
| GET | /:tablename | Alle Spalten der Tabelle `tablename` auflisten |
| POST | /:tablename/:columnname/:columntype | Spalte mit Name `columnname` in Tabelle `tablename` anlegen. `columntype` gibt dabei den SQL Typen an, z.B. "VARCHAR NOT NULL". |
| DELETE | /:tablename/:columnname | Spalte mit Name `columnname` aus Tabelle `tablename` löschen |

## /api/schema/tables

Dient zum Manipulieren von Tabellen.

| Methode | Endpunkt | Bedeutung |
|---|---|---|
| GET | / | Alle Tabellen auflisten |
| POST | /:tablename | Tabelle mit Name `tablename` anlegen |
| DELETE | /:tablename | Tabelle mit Name `tablename` löschen |

## /api/views/:viewname

Sowas wie statische Ressourcen, die in der Datenbank liegen.
Kommt aus Tabelle `views` und liefert den `content` mit dem richtigen `contenttype` aus.
In der Spalte `name` muss der Name der View (`viewname`) enthalten sein.
