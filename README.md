# cloudcore

[![pipeline status](https://gitlab.com/hilderonny/cloudcore/badges/2020/pipeline.svg)](https://gitlab.com/hilderonny/cloudcore/commits/2020)
[![coverage report](https://gitlab.com/hilderonny/cloudcore/badges/2020/coverage.svg)](https://gitlab.com/hilderonny/cloudcore/commits/2020)

CloudCore soll sowas wie eine Mischung aus Arrange und Salesforce sein.
Ich möchte damit auf einem Server mit Datenbank eine Anwendung per Oberfläche bauen können, also Entitäten, APIs und Code schreiben können, ohne die Anwendung ständig neu starten zu müssen.

## Installation unter Windows (Auf Entwicklerrechner)

1. Postgres 12 von [hier](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads) installieren

https://www.postgresql.org/download/linux/ubuntu/

## Installation unter Linux

```
curl -sL https://deb.nodesource.com/setup_13.x | bash -
apt install postgresql nodejs gcc g++ make git
mkdir -p gitlab/hilderonny
cd gitlab/hilderonny
git clone https://gitlab.com/hilderonny/cloudcore.git
cd cloudcore
git config credential.helper store
git checkout 2020
npm i
```

Daemon-Skript unter /etc/systemd/system/cloudcore.service eingerichtet.

```
[Unit]
Description=cloudcore
After=network.target
[Service]
Type=idle
WorkingDirectory=/root/gitlab/hilderonny/cloudcore
Environment=PORT=80
Environment=PGHOST=localhost
Environment=PGUSER=cloudcore
Environment=PGPASSWORD=cloudcore
Environment=PGDATABASE=cloudcore
Environment=PGPORT=5432
Environment=TOKENKEY=sachichnich
ExecStart=/usr/bin/node /root/gitlab/hilderonny/cloudcore/server.js
[Install]
WantedBy=default.target
```

Daemon starten

```
chmod 644 /etc/systemd/system/cloudcore.service
systemctl enable cloudcore.service
systemctl daemon-reload
systemctl start cloudcore.service
```

## Erster Start

Auf dem Datenbankserver soll eine Datenbank angelegt werden (mit `su - postgres` und `psql`), siehe [Anleitung](https://medium.com/@mohammedhammoud/postgresql-create-user-create-database-grant-privileges-access-aabb2507c0aa):

```
CREATE DATABASE cloudcore;
CREATE USER cloudcore WITH PASSWORD 'cloudcore';
GRANT ALL PRIVILEGES ON DATABASE cloudcore to cloudcore;
```

Zum Vorbereiten der Datenbank muss `node install.js` aufgerufen werden. Das installiert die Postgres-Erweiterung `uuid-ossp`.

Die Pakete `core.json`, `setup.json` und `packaging.json` können danach mit curl installiert werden.

```
curl --header "Content-Type: application/json" --request POST --data @packages/core.json http://localhost/packageupload/
curl --header "Content-Type: application/json" --request POST --data @packages/setup.json http://localhost/packageupload/
curl --header "Content-Type: application/json" --request POST --data @packages/packaging.json http://localhost/packageupload/
```
