from flask import Flask, jsonify # type: ignore
from flask import request # type: ignore
from bson.objectid import ObjectId # type: ignore
from datetime import datetime, timezone # type: ignore
from db_config import db

servico = Flask("comentarios")

DESCRICAO = "Serviço de Listagem e Cadastro de Comentários"
VERSAO = "1.0"

@servico.get("/info")
def get_info():
    return jsonify(descricao = DESCRICAO, versao = VERSAO)

@servico.get("/comentarios")
def get_todos_comentarios():
    cometarios = list(db.comentarios.find())
    for cometario in cometarios:
        cometario["_id"] = str(cometario["_id"])
    return jsonify(cometarios)

@servico.get("/comentarios/<string:ultimo_id>/<int:tamanho_da_pagina>")
def get_comentarios(ultimo_id, tamanho_da_pagina):
    imovelId = request.args.get("imovelId")

    filtro = {}

    if imovelId:
        filtro["imovelId"] = str(imovelId)

    if ultimo_id != "0":
        if ultimo_id != "0":
            ultimo_comentario = db.comentarios.find_one({"_id": ObjectId(ultimo_id)}, {"data": 1})
            if ultimo_comentario and "data" in ultimo_comentario:
                filtro["data"] = {"$lt": ultimo_comentario["data"]}  

    comentarios_cursor = db.comentarios.find(filtro).sort([("data", -1)]).limit(tamanho_da_pagina)

    comentarios = list(comentarios_cursor)

    for comentario in comentarios:
        comentario["_id"] = str(comentario["_id"])
        if "data" in comentario:
            comentario["data"] = comentario["data"].isoformat()

    return jsonify(comentarios)

@servico.post("/comentarios")
def adicionar_comentario():
    try:
        dados = request.get_json()

        campos_obrigatorios = ["texto", "imovelId", "nota", "usuario"]
        if not all(campo in dados for campo in campos_obrigatorios):
            return jsonify({"erro": "Os campos texto, imovelId, nota e usuario são obrigatórios"}), 400

        if not isinstance(dados["usuario"], dict) or not all(
            campo in dados["usuario"] for campo in ["nome", "email"]
        ):
            return jsonify({"erro": "O campo usuario deve conter nome e email"}), 400

        novo_comentario = {
            "texto": dados["texto"],
            "imovelId": dados["imovelId"],
            "nota": dados["nota"],
            "data": datetime.now(timezone.utc),  
            "usuario": {
                "nome": dados["usuario"]["nome"],
                "email": dados["usuario"]["email"]
            }
        }

        resultado = db.comentarios.insert_one(novo_comentario)

        novo_comentario["_id"] = str(resultado.inserted_id)
        novo_comentario["data"] = novo_comentario["data"].isoformat()

        return jsonify(novo_comentario), 201

    except Exception as e:
        print(f"Erro ao adicionar comentário: {e}")
        return jsonify({"erro": "Erro ao adicionar comentário"}), 500

@servico.delete("/comentarios/<string:comentario_id>")
def apagar_comentario(comentario_id):
    try:
        resultado = db.comentarios.delete_one({"_id": ObjectId(comentario_id)})

        if resultado.deleted_count == 0:
            return jsonify({"erro": "Comentário não encontrado"}), 404

        return jsonify({"mensagem": "Comentário apagado com sucesso"}), 200

    except Exception as e:
        print(f"Erro ao apagar comentário: {e}")
        return jsonify({"erro": "Erro ao apagar comentário"}), 500

if __name__ == "__main__":
    servico.run(host="0.0.0.0", debug=True)