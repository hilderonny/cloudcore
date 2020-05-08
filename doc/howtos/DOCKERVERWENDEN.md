# Docker verwenden

Nachdem Docker lokal installiert ist und ich den Befehl "docker" verwenden kann, kann es losgehen.

Zuerst auf https://hub.docker.com ein Repository `hilderonny/cloudcoretest` anlegen.

Danach im Stammverzeichnis die Datei `Dockerfile` anlegen und konfigurieren.

```
FROM node:latest
RUN apt-get update
RUN apt-get install -y libpq sudo git nano
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN service postgresql start && \
    sudo -u postgres psql -c "CREATE DATABASE cloudcoretest;" && \
    sudo -u postgres psql -c "CREATE USER cloudcoretest WITH PASSWORD 'cloudcoretest';" && \
    sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE cloudcoretest to cloudcoretest;" && \
    sudo -u postgres psql --dbname "cloudcoretest" -c 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp";'
RUN git clone https://hilderonny:Code-2019@gitlab.com/hilderonny/cloudcore.git && \
    cd cloudcore && \
    npm i
```


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
