# cloudcore

CloudCore soll sowas wie eine Mischung aus Arrange und Salesforce sein.
Ich möchte damit auf einem Server mit Datenbank eine Anwendung per Oberfläche bauen können, also Entitäten, APIs und Code schreiben können, ohne die Anwendung ständig neu starten zu müssen.

Besteht grundlegend aus `routers` - das sind API Endpunkte, die serverseitigen Code ausführen und irgendwelche Aktionen machen und Ergebnisse liefern - und `views`, zumeist reine HTML-Dateien, die die Router benutzen, um mit der Anwendung zu interagieren und dem Benutzer irgendwas anzuzeigen.

[Hier geht's zur Dokumentation](https://hilderonny.gitlab.io/cloudcore)
