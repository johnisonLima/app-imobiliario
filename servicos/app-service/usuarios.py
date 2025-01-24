from flask import Flask, jsonify # type: ignore
from flask import request # type: ignore
from datetime import datetime, timezone # type: ignore
from db_config import db

servico = Flask("usuarios")

DESCRICAO = "serviço de listagem e cadastro de usuarios"
VERSAO = "1.0"

@servico.get("/info")
def get_info():
    return jsonify(descricao = DESCRICAO, versao = VERSAO)

@servico.get("/usuarios")
def get_todos_usuarios():
    usuarios = list(db.usuarios.find())
    for usuario in usuarios:
        usuario["_id"] = str(usuario["_id"])
    return jsonify(usuarios)

@servico.route('/usuarios', methods=['POST'])
def registrar_usuario():
    dados = request.json

    uid = dados.get("uid")
    email = dados.get("email")

    if not uid or not email:
        return jsonify({"erro": "UID e Email são obrigatórios"}), 400

    usuario_existente = db.usuarios.find_one({"_id": uid})
    if usuario_existente:
        return jsonify({"mensagem": "Usuário já registrado"}), 200

    novo_usuario = {
        "_id": uid,  # UID do Firebase como chave primária
        "email": email,
        "nome": dados.get("nome"),
        "criadoEm":  datetime.now(timezone.utc),
    }
    db.usuarios.insert_one(novo_usuario)

    return jsonify({"mensagem": "Usuário registrado com sucesso"}), 201

if __name__ == "__main__":
    servico.run(host="0.0.0.0", debug=True)