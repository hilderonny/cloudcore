#!/bin/sh

# Erstellt DB-Dumps mit aktuallem Datum und commited dieses automatisch.

cd /root/gitlab/hilderonny/cloudcore
git pull
wget http://localhost/backup/ -O ./backup/$(date +"%Y-%m-%d").sql
git add .
git commit -m "Backup"
git push