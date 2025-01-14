from flask import Flask, jsonify # type: ignore
from pymongo import MongoClient # type: ignore

servico = Flask("likes")

DESCRICAO = "serviço de listagem e cadastro de likes"
VERSAO = "1.0"

# # Configurações do MongoDB
# MONGO_USER = "root"
# MONGO_PASS = "admin@localhost"
# MONGO_PORT = 27017
# MONGO_DB = "lh_imoveis"
# MONGO_URI = f"mongodb://{MONGO_USER}:{MONGO_PASS}:{MONGO_PORT}/{MONGO_DB}"

# client = MongoClient(MONGO_URI)
# db = client[MONGO_DB]

@servico.get("/info")
def get_info():
    return jsonify(descricao = DESCRICAO, versao = VERSAO)

if __name__ == "__main__":
    servico.run(host="0.0.0.0", debug=True)