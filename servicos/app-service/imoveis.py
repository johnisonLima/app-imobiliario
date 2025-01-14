from flask import Flask, jsonify # type: ignore
# from pymongo import MongoClient # type: ignore
from flask import request # type: ignore
from bson.objectid import ObjectId # type: ignore
from db_config import db

servico = Flask("imoveis")

DESCRICAO = "Serviço de Listagem e Cadastro de Imóveis"
VERSAO = "1.0"

""" # Configurações do MongoDB
MONGO_USER = "root"
MONGO_PASS = "admin@banco"
MONGO_PORT = 27017
MONGO_DB = "lh_imoveis"
MONGO_URI = f"mongodb://{MONGO_USER}:{MONGO_PASS}:{MONGO_PORT}/{MONGO_DB}?authSource=admin"

# Inicializa o cliente 
client = MongoClient(MONGO_URI)
db = client[MONGO_DB] """


@servico.get("/info")
def get_info():
    return jsonify(descricao = DESCRICAO, versao = VERSAO)

@servico.get("/imoveis")
def get_todos_imoveis():
    imoveis = list(db.imoveis.find())
    for imovel in imoveis:
        imovel["_id"] = str(imovel["_id"])
    return jsonify(imoveis)

@servico.get("/imoveis/<string:ultimo_id>/<int:tamanho_da_pagina>")
def get_imoveis(ultimo_id, tamanho_da_pagina):
    # Recupera o parâmetro de consulta `operacao` (opcional)
    operacao = request.args.get("operacao")

    # Monta o filtro inicial
    filtro = {}

    # Adiciona filtro de operação (venda ou aluguel) se fornecido
    if operacao:
        filtro["operacao"] = operacao

    # Verifica se o último ID foi fornecido
    if ultimo_id != "0":
        # Adiciona filtro para IDs maiores que o último ID
        filtro["_id"] = {"$gt": ObjectId(ultimo_id)}

    # Busca no banco com limite de página
    imoveis_cursor = db.imoveis.find(filtro).limit(tamanho_da_pagina)

    # Converte os resultados para uma lista
    imoveis = list(imoveis_cursor)

    # Converte ObjectId para string
    for imovel in imoveis:
        imovel["_id"] = str(imovel["_id"])

    return jsonify(imoveis)

if __name__ == "__main__":
    servico.run(host="0.0.0.0", debug=True)