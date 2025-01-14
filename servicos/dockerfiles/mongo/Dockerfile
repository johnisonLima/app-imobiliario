FROM mongo

# Instalar MongoDB Tools
RUN apt-get update && apt-get install -y mongodb-org-tools

COPY dados /dados
COPY init.sh /docker-entrypoint-initdb.d/init.sh
