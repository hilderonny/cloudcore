# CORE

Dieses Paket sollte stets installiert sein, um Grundfunktionen für den Betrieb zu liefern.

## Router

* `/api-data` - Inhalte von Tabellen manipulieren
* `/api-schema` - Struktur von Tabellen manipulieren

## Views

* `/assets/slds.css` - Basis-Stylesheet, an Salesforce angelehnt
* `/ccc/cc-globalnav` - Webkomponente für Navigation mit Apps und Tabs
* `/` - Startseite

## Tabellen und Felder

* `apps : label` - Bezeichnung für App
* `routers : code` - Quellcode des Routers
* `routers : url` - Relative URL, unter der der Router lauscht
* `tabs : appid` - ID der App, zu der der TAb gehört
* `tabs : label`- Text, der auf Tab steht
* `tabs :  url` - URL, die aufgerufen wird, wenn man auf den Tab klickt
* `views : content` - Inhalt der Sicht (HTML, o.ä.)
* `views : contenttype` - Art des Inhaltes, z.B. "text/html"
* `views : url` - Relative URL, unter der die View erreichbar ist
