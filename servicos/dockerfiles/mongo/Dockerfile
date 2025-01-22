FROM mongo

# Instalar MongoDB e suas ferramentas
RUN apt-get update && \
    apt-get install -y mongodb-org mongodb-org-tools mongodb-mongosh

# Copiar os dados e o script de inicialização
COPY dados /dados
COPY init.sh /docker-entrypoint-initdb.d/init.sh

# Garantir que o script de inicialização seja executável
RUN chmod +x /docker-entrypoint-initdb.d/init.sh