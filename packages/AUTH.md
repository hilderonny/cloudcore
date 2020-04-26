# AUTH

Bietet Funktionen zur Registrierung, Anmeldung und Validierung von Benutzern. Fügt den Grundtabellen `apps`, `routers`, `tabs` und `views` Besitzerinformationen hinzu, die zur Berechtigungsprüfung benutzt werden können.

Erstellt einen Benutzer `system` ohne Passwort, der als Besitzer von öffentlich verfügbaren oder anonym erstellten Entitäten benutzt wird.

## Router

* TODO: Noch leer, hier soll aber Registrierung und Login rein

## Views

* TODO: Noch leer, hier soll aber Registrierung und Login rein

## Tabellen und Felder

* `apps : ispublic` - Angabe, ob App für alle Benutzer verfügbar ist
* `apps : userid` - Besitzer-ID der App
* `routers : ispublic` - Angabe, ob Router für alle Benutzer verfügbar ist
* `routers : userid` - Besitzer-ID des Routers
* `tabs : ispublic` - Angabe, ob Tab für alle Benutzer verfügbar ist
* `tabs : userid` - Besitzer-ID des Tabs
* `users : password` - Verschlüsseltes Passwort eines Benutzers
* `users : username` - Benutzername
* `views : ispublic` - Angabe, ob View für alle Benutzer verfügbar ist
* `views : userid` - Besitzer-ID der View
