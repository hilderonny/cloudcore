# cloudcore

CloudCore soll sowas wie eine Mischung aus Arrange und Salesforce sein.
Ich möchte damit auf einem Server mit Datenbank eine Anwendung per Oberfläche bauen können, also Entitäten, APIs und Code schreiben können, ohne die Anwendung ständig neu starten zu müssen.

Besteht grundlegend aus `routers` - das sind API Endpunkte, die serverseitigen Code ausführen und irgendwelche Aktionen machen und Ergebnisse liefern - und `views`, zumeist reine HTML-Dateien, die die Router benutzen, um mit der Anwendung zu interagieren und dem Benutzer irgendwas anzuzeigen.

[Hier geht's zur Dokumentation](https://hilderonny.gitlab.io/cloudcore)

## Branch postgres2020

Dieser Branch enthält einen experimentellen Stand, mit dem ich die Salesforce-Architektur nachbilden wollte.

* PostgreSQL Datenbank
* Views und Routers in Datenbank gespeichert
* Paketierung
* Online-Editor

Diesen Versuch gab ich aus folgenden Gründen auf:

* Fehlverhalten von Postgres bei Tests
* Komplizierte Sicherung und Versionierung
* Performance Bedenken
* Aufwand der Paketierung ohne Mehrwert für mich

Ich wollte effizienter werden und entschied mich daher, wieder auf einfache Standards zurückzugreifen.