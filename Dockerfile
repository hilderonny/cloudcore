FROM node:latest
RUN apt-get update
RUN apt-get install -y postgresql postgresql-contrib sudo
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN service postgresql start && \
    sudo -u postgres psql -c "CREATE DATABASE cloudcoretest;" && \
    sudo -u postgres psql -c "CREATE USER cloudcoretest WITH PASSWORD 'cloudcoretest';" && \
    sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE cloudcoretest to cloudcoretest;" && \
    sudo -u postgres psql --dbname "cloudcoretest" -c 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp";'
