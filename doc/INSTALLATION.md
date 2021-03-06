# Installation

## Installation unter Linux

```sh
# NodeJS
curl -sL https://deb.nodesource.com/setup_13.x | bash -
# Postgres, git
apt install postgresql nodejs gcc g++ make git libpq-dev postgresql-contrib
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

Konfigurationsdatei `config.json` im ausgecheckten Stammordner (neben `server.js`) erstellen.

```json
{
    "PORT": "80",
    "PGHOST": "localhost",
    "PGUSER": "cloudcore",
    "PGPASSWORD": "cloudcore",
    "PGDATABASE": "cloudcore",
    "PGPORT": "5432",
    "TOKENKEY": "sachichnich"
}
```

Daemon-Skript unter /etc/systemd/system/cloudcore.service einrichten.

```
[Unit]
Description=cloudcore
After=network.target
[Service]
Type=idle
WorkingDirectory=/root/gitlab/hilderonny/cloudcore
ExecStart=/usr/bin/node /root/gitlab/hilderonny/cloudcore/server.js
[Install]
WantedBy=default.target
```

Daemon starten

```sh
chmod 644 /etc/systemd/system/cloudcore.service
systemctl enable cloudcore.service
systemctl daemon-reload
systemctl start cloudcore.service
```

## Erster Start

Auf dem Datenbankserver soll eine Datenbank angelegt werden (mit `sudo -u postgres psql`), siehe [Anleitung](https://medium.com/@mohammedhammoud/postgresql-create-user-create-database-grant-privileges-access-aabb2507c0aa):

```sql
CREATE DATABASE cloudcore;
CREATE USER cloudcore WITH PASSWORD 'cloudcore';
GRANT ALL PRIVILEGES ON DATABASE cloudcore to cloudcore;
\connect cloudcore;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
```

Zum Vorbereiten der Datenbank muss `node ./install` aufgerufen werden. Das installiert die Postgres-Erweiterung `uuid-ossp`. Außerdem werden die für die Paketinstallation notwendigen Tabellen erstellt und bereits vorhandene Pakete im `/packages` Ordner installiert. Das sollten normalerweise `core.zip`, `setup.zip` und `packaging.zip` sein.

## Manuell zum Testen starten

```sh
node ./server.js
```

## Entwicklerrechner unter MacOS einrichten

Da das NodeJS Paket `pg-native` die native Library `libpg` benötigt (pg-native wiederum wird von den Docker-Containern benötigt, da das einfache pg dort nicht funktioniert), muss diese vorher installiert werden.

Dazu wird aber Homebrew benötigt.

```sh
curl https://raw.githubusercontent.com/Homebrew/install/master/install.sh > install.sh
chmod +x install.sh
./install.sh
brew install postgres
# Eventuell reinstallieren, wie in https://medium.com/flawless-app-stories/gyp-no-xcode-or-clt-version-detected-macos-catalina-anansewaa-38b536389e8d
sudo rm -r -f /Library/Developer/CommandLineTools
xcode-select --install
```

Danach kann man das native Paket installieren, welches die native Bibliothek kompiliert.

```sh
npm i --save pg pg-native
```

## Entwicklerrechner unter Windows einrichten

Es muss PostgreSQL und Python installiert sein. Außerdem für x64 noch ein paar Build-Tools, folgenden Befehl als Administrator ausführen:

```sh
npm install --global --production windows-build-tools
```

Achja, und das .NET Framework 2.0 SDK muss installiert werden, damit `VCBuild.exe` vorhanden ist:

https://www.microsoft.com/de-de/download/details.aspx?id=15354
