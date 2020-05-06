# Installation

## Installation unter Linux

```sh
# NodeJS
curl -sL https://deb.nodesource.com/setup_13.x | bash -
# Postgres, git
apt install postgresql nodejs gcc g++ make git
mkdir -p gitlab/hilderonny
cd gitlab/hilderonny
# Repository klonen
git clone https://gitlab.com/hilderonny/cloudcore.git
cd cloudcore
git config credential.helper store
# Branch master auschecken
git checkout master
npm i
```

Daemon-Skript unter /etc/systemd/system/cloudcore.service einrichten.

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

Zum Vorbereiten der Datenbank muss `node install.js` aufgerufen werden. Das installiert die Postgres-Erweiterung `uuid-ossp`. Außerdem werden die für die Paketinstallation notwendigen Tabellen erstellt.

Die Pakete `core.json`, `setup.json` und `packaging.json` können danach mit curl über die API `/packageupload` installiert werden.

```
curl --header "Content-Type: application/json" --request POST --data @packages/core.json http://localhost/packageupload/
curl --header "Content-Type: application/json" --request POST --data @packages/setup.json http://localhost/packageupload/
curl --header "Content-Type: application/json" --request POST --data @packages/packaging.json http://localhost/packageupload/
```

## Manuell zum Testen starten

```sh
PORT=80 PGPORT=5432 PGHOST=localhost PGUSER=cloudcore PGPASSWORD=cloudcore PGDATABASE=cloudcore TOKENKEY=sachichnich node ./server.js
```

