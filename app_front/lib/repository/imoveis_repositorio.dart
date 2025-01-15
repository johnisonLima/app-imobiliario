// ignore_for_file: non_constant_identifier_names,
// unnecessary_brace_in_string_interps
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lh_imoveis/model/imoveis.dart';
import 'package:lh_imoveis/repository/base_repositorio.dart';

class ImoveisRepositorio extends BaseRepositorio with ChangeNotifier {
  String? _ultimoId; // Armazena o último ID retornado
  bool _carregando = false;
  bool _temMais = true;

  final List<dynamic> _imoveis = [];
  List<dynamic> get imoveis => _imoveis;
  bool get carregando => _carregando;
  bool get temMaisImoveis => _temMais;

  Future<void> getImoveis({String? operacao, bool? refresh = false}) async {
    if (refresh != null && refresh) {
      _ultimoId = null; // Reinicia o ID para carregar desde o início
      _imoveis.clear();
      _carregando = false;
      _temMais = true;
    }

    if (_carregando || !_temMais) return;

    _carregando = true;
    notifyListeners();

    try {
      // Monta a URL da API com base no último ID e no tamanho da página
      int tamanhoPagina = 3;
      // ignore: unnecessary_brace_in_string_interps
      String baseUrl = '${BASE_API}:5001/imoveis';
      String api;

      if (_ultimoId == null) {
        // Primeira página
        api = operacao != null
            ? '$baseUrl/0/$tamanhoPagina?operacao=$operacao'
            : '$baseUrl/0/$tamanhoPagina';
      } else {
        // Páginas subsequentes
        api = operacao != null
            ? '$baseUrl/$_ultimoId/$tamanhoPagina?operacao=$operacao'
            : '$baseUrl/$_ultimoId/$tamanhoPagina';
      }

      final Uri uri = Uri.parse(api);
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        final dados = json.decode(response.body) as List;

        if (dados.isEmpty) {
          _temMais = false; // Não há mais imóveis
        } else {
          // Atualiza a lista de imóveis
          _imoveis.addAll(dados.map((item) => Imovel.fromJson(item)).toList());

          // Atualiza o último ID com o ID do último imóvel retornado
          _ultimoId = _imoveis.last.id;
        }
      } else {
        throw Exception('Erro ao carregar dados da API');
      }
    } catch (e) {
      print("Erro na requisição de imóveis: $e");
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }

  Future<void> carregarMaisImoveis({String? operacao}) async {
    if (_carregando || !_temMais) return;
    await getImoveis(operacao: operacao);
  }
}