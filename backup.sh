#!/bin/sh

# Erstellt DB-Dumps mit aktuallem Datum.

wget http://localhost/backup/ -O ./backup/$(date +"%Y-%m-%d").sql