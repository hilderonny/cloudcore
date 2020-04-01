# cloudcore

[![pipeline status](https://gitlab.com/hilderonny/cloudcore/badges/2020/pipeline.svg)](https://gitlab.com/hilderonny/cloudcore/commits/2020)
[![coverage report](https://gitlab.com/hilderonny/cloudcore/badges/2020/coverage.svg)](https://gitlab.com/hilderonny/cloudcore/commits/2020)

CloudCore soll sowas wie eine Mischung aus Arrange und Salesforce sein.
Ich möchte damit auf einem Server mit Datenbank eine Anwendung per Oberfläche bauen können, also Entitäten, APIs und Code schreiben können, ohne die Anwendung ständig neu starten zu müssen.

## Installation unter Windows (Auf Entwicklerrechner)

1. Postgres 12 von [hier](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads) installieren

https://www.postgresql.org/download/linux/ubuntu/

## Erster Start

Zum Vorbereiten der Datenbank muss `node install.js` aufgerufen werden. Das legt die notwendigen Tabellen and und erzeugt eine Hallo-Welt-View.