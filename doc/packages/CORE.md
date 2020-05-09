# Paket core - Kernfunktionen und Authentifizierung

Dieses Paket sollte stets installiert sein, um Grundfunktionen für den Betrieb zu liefern.

Bietet Funktionen zur Registrierung, Anmeldung und Validierung von Benutzern. Fügt den Grundtabellen `apps`, `routers`, `tabs` und `views` Besitzerinformationen hinzu, die zur Berechtigungsprüfung benutzt werden können.

## Router

* TODO: Hier soll noch Registrierung und Login rein

* `/api-data` - Inhalte von Tabellen manipulieren
* `/api-schema` - Struktur von Tabellen manipulieren

## Views

* TODO: Hier soll noch Registrierung und Login rein

* `/assets/slds.css` - Basis-Stylesheet, an Salesforce angelehnt
* `/ccc/cc-globalnav` - Webkomponente für Navigation mit Apps und Tabs
* `/` - Startseite

## Tabellen und Felder

* `apps : label` - Bezeichnung für App
* `apps : ispublic` - Angabe, ob App für alle Benutzer verfügbar ist
* `apps : userid` - Besitzer-ID der App
* `routers : code` - Quellcode des Routers
* `routers : url` - Relative URL, unter der der Router lauscht
* `routers : ispublic` - Angabe, ob Router für alle Benutzer verfügbar ist
* `routers : userid` - Besitzer-ID des Routers
* `tabs : appid` - ID der App, zu der der TAb gehört
* `tabs : label`- Text, der auf Tab steht
* `tabs :  url` - URL, die aufgerufen wird, wenn man auf den Tab klickt
* `tabs : ispublic` - Angabe, ob Tab für alle Benutzer verfügbar ist
* `tabs : userid` - Besitzer-ID des Tabs
* `users : password` - Verschlüsseltes Passwort eines Benutzers
* `users : username` - Benutzername
* `views : content` - Inhalt der Sicht (HTML, o.ä.)
* `views : contenttype` - Art des Inhaltes, z.B. "text/html"
* `views : url` - Relative URL, unter der die View erreichbar ist
* `views : ispublic` - Angabe, ob View für alle Benutzer verfügbar ist
* `views : userid` - Besitzer-ID der View
