# Docker verwenden

Nachdem Docker lokal installiert ist und ich den Befehl "docker" verwenden kann, kann es losgehen.

Zuerst auf https://hub.docker.com ein Repository `hilderonny/cloudcoretest` anlegen.

Danach im Stammverzeichnis die Datei `Dockerfile` anlegen und konfigurieren.

Zum Bauen und Hochladen des Images dann das hier ausführen:

```sh
docker build --pull --rm -f "Dockerfile" -t hilderonny/cloudcoretest:latest "."
docker push hilderonny/cloudcoretest:latest
```

Danach kann ich das Image in `.gitlab-ci.yml` vorkonfiguriert mit einer `cloudcoretest` Datenbank verwenden:

```yml
image: hilderonny/cloudcoretest:latest

stages:
  - test
  - deploy

test:
  stage: test
  before_script:
    - service postgresql start
  script:
    - npm i
    - npm test

pages:
  stage: deploy
  script:
    - mv doc public
  artifacts:
    paths:
    - public
  only:
  - master
```
