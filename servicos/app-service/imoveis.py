from flask import Flask, jsonify # type: ignore
from flask import request # type: ignore
from bson.objectid import ObjectId # type: ignore
from db_config import db

servico = Flask("imoveis")

DESCRICAO = "Serviço de Listagem e Cadastro de Imóveis"
VERSAO = "1.0"

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

@servico.route('/buscar_imoveis/<string:ultimo_id>/<int:tamanho_da_pagina>', methods=['GET'])
def buscar_imoveis(ultimo_id, tamanho_da_pagina):
    filtros = []

    # Obter parâmetros de busca do frontend
    tipo = request.args.get('tipo')
    operacao = request.args.get('operacao')
    bairro = request.args.get('bairro')
    cidade = request.args.get('cidade')
    estado = request.args.get('estado')
    min_valor = request.args.get('min_valor')
    max_valor = request.args.get('max_valor')
    min_area = request.args.get('min_area')
    max_area = request.args.get('max_area')
    comodidades = request.args.getlist('comodidades')  # Lista de comodidades

    # Adicionar filtros ao operador $or
    if tipo:
        filtros.append({'tipo': tipo})
    if operacao:
        filtros.append({'operacao': operacao})
    if bairro:
        filtros.append({'endereco.bairro': bairro})
    if cidade:
        filtros.append({'endereco.cidade': cidade})
    if estado:
        filtros.append({'endereco.estado': estado})
    if min_valor or max_valor:
        valor_filter = {}
        if min_valor:
            valor_filter['$gte'] = float(min_valor)
        if max_valor:
            valor_filter['$lte'] = float(max_valor)
        filtros.append({'valor': valor_filter})
    if min_area or max_area:
        area_filter = {}
        if min_area:
            area_filter['$gte'] = float(min_area)
        if max_area:
            area_filter['$lte'] = float(max_area)
        filtros.append({'areaTotal': area_filter})
    if comodidades:
        filtros.append({'comodidades.tipo': {'$all': comodidades}})

    # Construir o filtro final com $or
    consulta = {'$or': filtros} if filtros else {}

    # Paginação: Filtrar por último ID
    if ultimo_id != "0":
        consulta["_id"] = {"$gt": ObjectId(ultimo_id)}

    # Executar a busca no banco de dados com paginação
    imoveis_cursor = db.imoveis.find(consulta).limit(tamanho_da_pagina)
    imoveis = list(imoveis_cursor)

    # Converter ObjectId para string antes de enviar a resposta
    for imovel in imoveis:
        imovel['_id'] = str(imovel['_id'])

    return jsonify(imoveis), 200


if __name__ == "__main__":
    servico.run(host="0.0.0.0", debug=True)