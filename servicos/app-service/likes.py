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

@servico.route('/likes/<string:imovel_id>', methods=['GET'])
def get_likes_imovel(imovel_id):
    # Buscar todos os likes para o imóvel
    likes = list(db.likes.find({"imovelId": imovel_id}))

    # Formatar o resultado
    for like in likes:
        like["_id"] = str(like["_id"])  # Convertendo ObjectId para string
        like["data"] = like["data"].isoformat()  # Convertendo datetime para string ISO

    return jsonify(likes), 200

@servico.route('/likes/<string:imovel_id>/<string:usuario_id>', methods=['GET'])
def get_like_usuario_imovel(imovel_id, usuario_id):
    # Consulta para verificar se existe um like com o imovelId e usuarioId
    like = db.likes.find_one({"imovelId": imovel_id, "usuarioId": usuario_id})

    if like:
        # Convertendo o _id para string
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

    # Verificar se o like já existe
    like_existente = db.likes.find_one({"imovelId": imovel_id, "usuarioId": usuario_id})

    if like_existente:
        return jsonify({"mensagem": "Usuário já deu like nesse imóvel"}), 200

    # Inserir novo like
    novo_like = {
        "imovelId": imovel_id,
        "usuarioId": usuario_id,
        "data":  datetime.now(timezone.utc),
    }

    db.likes.insert_one(novo_like)

    # Incrementar o contador de likes no imóvel
    db.imoveis.update_one(
        {"_id": ObjectId(imovel_id)},
        {"$inc": {"likesCount": 1}}
    )

    return jsonify({"mensagem": "Like registrado com sucesso"}), 201

@servico.route('/likes/<string:imovel_id>/<string:usuario_id>', methods=['DELETE'])
def excluir_like(imovel_id, usuario_id):
    # Buscar e remover o like
    resultado = db.likes.delete_one({"imovelId": imovel_id, "usuarioId": usuario_id})

    if resultado.deleted_count == 0:
        return jsonify({"erro": "Like não encontrado"}), 404
    
    # Decrementar o contador de likes no imóvel
    db.imoveis.update_one(
        {"_id": ObjectId(imovel_id)},
        {"$inc": {"likesCount": -1}}
    )

    return jsonify({"mensagem": "Like removido com sucesso"}), 200

if __name__ == "__main__":
    servico.run(host="0.0.0.0", debug=True)