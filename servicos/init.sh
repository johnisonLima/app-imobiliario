#!/bin/bash

# Configurações do MongoDB
MONGO_USER="root"
MONGO_PASS="admin"
MONGO_PORT=27017
MONGO_DB="lh_imoveis"
MONGO_URI="mongodb://${MONGO_USER}:${MONGO_PASS}@banco:${MONGO_PORT}/${MONGO_DB}?authSource=admin"

# mongosh ${MONGO_URI} --quiet --eval "db.stats()" # Testar conexão
# mongosh ${MONGO_URI} --quiet --eval "db.comentarios.countDocuments()" # Testar coleção

mongosh -u root -p admin --authenticationDatabase admin --file /dados/collections.js
# mongosh ${MONGO_URI} --file /dados/collections.js

# # Função para importar dados, com verificação de existência
# importar_dados() {
#     local colecao=$1
#     local arquivo=$2

#     echo "Verificando dados na coleção '${colecao}'..."
#     count=$(mongosh "${MONGO_URI}" --quiet --eval "db.${colecao}.countDocuments()")
#     if [ "${count}" -gt 0 ]; then
#         echo "A coleção '${colecao}' já contém dados. Pulando importação."
#         return
#     fi

#     echo "Importando dados para a coleção '${colecao}' do arquivo '${arquivo}'..."
#     mongoimport -u ${MONGO_USER} -p ${MONGO_PASS} --authenticationDatabase admin --db ${MONGO_DB}  --collection "${colecao}" --file "${arquivo}" --jsonArray
#     if [ $? -ne 0 ]; then
#         echo "Erro ao importar dados para a coleção '${colecao}'!"
#         exit 1
#     fi
# }

# Importar dados
# importar_dados "imoveis" "/dados/dados_imoveis.json"
# importar_dados "comentarios" "/dados/dados_comentarios.json"
# importar_dados "likes" "/dados/dados_likes.json"
# importar_dados "usuarios" "/dados/dados_usuarios.json"

echo "Importação concluída com sucesso!"
