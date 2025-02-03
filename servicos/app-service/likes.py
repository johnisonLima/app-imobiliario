from flask import Flask, jsonify # type: ignore
from flask import request # type: ignore
from bson.objectid import ObjectId # type: ignore
from datetime import datetime, timezone # type: ignore
from db_config import db

servico = Flask("likes")

DESCRICAO = "serviço de listagem e cadastro de likes"
VERSAO = "1.0"

@servico.get("/info")
def get_info():
    return jsonify(descricao = DESCRICAO, versao = VERSAO)

@servico.get("/likes")
def get_todos_likes():
    likes = list(db.likes.find())

    for like in likes:
        like["_id"] = str(like["_id"])
        like["data"] = like["data"].isoformat()

    return jsonify(likes)

@servico.get("/like/<string:like_id>")
def get_like_por_id(like_id):
    like = db.likes.find_one({"_id": ObjectId(like_id)})

    if not like:
        return jsonify({"erro": "Like não encontrado"}), 404

    like["_id"] = str(like["_id"])
    like["data"] = like["data"].isoformat()

    return jsonify(like)

@servico.route('/likes/<string:imovel_id>', methods=['GET'])
def get_likes_imovel(imovel_id):
    likes = list(db.likes.find({"imovelId": imovel_id}))
    
    if likes == []:
        return jsonify({"erro": "Imóvel não possui likes"}), 404

    for like in likes:
        like["_id"] = str(like["_id"])  
        like["data"] = like["data"].isoformat()  

    return jsonify(likes), 200

@servico.route('/likes/<string:imovel_id>/<string:usuario_id>', methods=['GET'])
def get_like_usuario_imovel(imovel_id, usuario_id):
    like = db.likes.find_one({"imovelId": imovel_id, "usuarioId": usuario_id})

    if like:
        like["_id"] = str(like["_id"])
        return jsonify({"curtiu": True, "like": like}), 200
    else:
        return jsonify({"curtiu": False}), 200


@servico.route('/likes', methods=['POST'])
def registrar_like():
    dados = request.json

    imovel_id = dados.get("imovelId")
    usuario_id = dados.get("usuarioId")

    if not imovel_id or not usuario_id:
        return jsonify({"erro": "Imóvel ID e Usuário ID são obrigatórios"}), 400

    like_existente = db.likes.find_one({"imovelId": imovel_id, "usuarioId": usuario_id})

    if like_existente:
        return jsonify({"mensagem": "Usuário já deu like nesse imóvel"}), 200

    novo_like = {
        "imovelId": imovel_id,
        "usuarioId": usuario_id,
        "data":  datetime.now(timezone.utc),
    }

    resultado = db.likes.insert_one(novo_like)

    db.imoveis.update_one(
        {"_id": ObjectId(imovel_id)},
        {"$inc": {"likesCount": 1}}
    )

    novo_like["_id"] = str(resultado.inserted_id)
    novo_like["data"] = novo_like["data"].isoformat()

    return jsonify(novo_like), 201

@servico.route('/likes/<string:imovel_id>/<string:usuario_id>', methods=['DELETE'])
def excluir_like(imovel_id, usuario_id):
    resultado = db.likes.delete_one({"imovelId": imovel_id, "usuarioId": usuario_id})

    if resultado.deleted_count == 0:
        return jsonify({"erro": "Like não encontrado"}), 404
    
    db.imoveis.update_one(
        {"_id": ObjectId(imovel_id)},
        {"$inc": {"likesCount": -1}}
    )

    return jsonify({"mensagem": "Like removido com sucesso"}), 200

if __name__ == "__main__":
    servico.run(host="0.0.0.0", debug=True)