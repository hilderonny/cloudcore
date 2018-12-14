# arrange

Läuft auf arrange.avorium.de.

Wird von TeamCity unter Ronny seins / Arrange2 per git pull dort hin geholt.

## Umgebungsvariablen

DB_URL - Adresse der Datenbank '127.0.0.1:27017'
PRIV_KEY - Datei mit SSL key 'priv.key'
PUB_CERT - Datei mit SSL Zertifikat 'pub.cert'
PORT - Port, an den der HTTP-Server gebunden werden soll (80)
SECRET - Token Secret für User Token Generierung 'hubbelebubbele'

Zum Debuggen werden diese Werte in der package.json vorgegeben. Debugging mit 'npm run-script debug' oder aus VS Code heraus 'Debug'