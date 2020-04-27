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

## Backup und Restore

Auf dem Server ist in `etc/crontab` ein Job eingerichtet, der täglich die `backup.sh` ausführt.

```
# m h dom mon dow user  command
45 23   * * *   root    /root/gitlab/hilderonny/cloudcore/backup.sh
```

Diese wiederum macht per `wget` einen Datenbank-Dump über die Backup-API und commited diesen dann ins git-Reporistory.

```sh
wget http://localhost/backup/ -O ./backup/autobackup.sql
git add .
git commit -m "Automatic backup"
git push
```

Git verhält sich dabei so, dass nur dann ein Commit durchgeführt wurde, wenn es wirklich Änderungen gab. Also nur dann, wenn in der Datenbank was geändert wurde und somit der Dump anders aussieht. Dadurch kann es passieren, dass an manchen Tagen, wo nix passiert, auch kein automatisches Backup im git auftaucht.

