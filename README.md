# cloudcore

CloudCore soll sowas wie eine Mischung aus Arrange und Salesforce sein.
Ich möchte damit auf einem Server mit Datenbank eine Anwendung per Oberfläche bauen können, also Entitäten, APIs und Code schreiben können, ohne die Anwendung ständig neu starten zu müssen.

Besteht grundlegend aus `routers` - das sind API Endpunkte, die serverseitigen Code ausführen und irgendwelche Aktionen machen und Ergebnisse liefern - und `views`, zumeist reine HTML-Dateien, die die Router benutzen, um mit der Anwendung zu interagieren und dem Benutzer irgendwas anzuzeigen.

[Hier geht's zur Dokumentation](https://hilderonny.gitlab.io/cloudcore)

## IndexedDB Wrapper

Unter https://glitch.com/edit/#!/web-database-proxy?path=script.js%3A90%3A0 habe ich einen Wrapper gebaut, der IndexedDB-Zugriffe so kapselt, dass sie sich wie ganz einfache Objektzugriffe anfühlen.

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

## Ideen

### MiiVersum nachbauen

Eigenartig, dass es die Wii Spiele,  bei denen man die Controller einsetzt, nicht bereits als VR-Adaptionen für Quest und Co. gibt.

Es sollte doch recht einfach und performant sein, diese simplen Figuren und Gegenden nachzubauen.

* Mii Editor
* Tennis
* Tischtennis
* Obst zerhacken
* Schwertkampf
* Surfen
* Laufen bzw. Radfahren (MotionSickness beachten)
* Insel nachbauen
* Bogenschießen
* Multiplayer mit Treffen und Chatten

### LIAGA (das mit Karten) bauen

In einem der Notizbücher hatte ioch ein GPS-Spiel. Das will ich umsetzen, damit ich mit dem Handy draußen rumlaufen kann.

### Habitica nachbauen

### VR Editor

Ich will endlich in der Quest einen Editor haben, mit dem ich mir virtuelle Welten erstellen kann.

## VR Grundgerüst

Da soll man sich sowohl mit dem PC als auch mit der Quest drin bewegen und kommunizieren können.

Als Webkomponente bauen. AFRAME bietet sich hier an, weil dieses bereits auf Komponenten basiert.
