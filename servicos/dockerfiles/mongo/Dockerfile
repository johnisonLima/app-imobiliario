FROM mongo

RUN apt-get update && \
    apt-get install -y mongodb-org mongodb-org-tools mongodb-mongosh

COPY dados /dados
COPY init.sh /docker-entrypoint-initdb.d/init.sh

RUN chmod +x /docker-entrypoint-initdb.d/init.sh