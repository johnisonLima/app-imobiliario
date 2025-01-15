// ignore_for_file: unnecessary_brace_in_string_interps
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lh_imoveis/model/comentarios.dart';
import 'package:lh_imoveis/repository/base_repositorio.dart';

class ComentariosRepositorio extends BaseRepositorio with ChangeNotifier {
  String? _ultimoId; // Armazena o último ID retornado
  bool _carregando = false;
  bool _temMais = true;

  final List<Comentarios> _comentarios = [];
  List<Comentarios> get comentarios => _comentarios;
  bool get carregando => _carregando;
  bool get temMais => _temMais;

  Future<void> getComentarios({String? imovelId, bool refresh = false}) async {
    if (refresh) {
      _ultimoId = null; // Reinicia o ID para carregar desde o início
      _comentarios.clear();
      _carregando = false;
      _temMais = true;
    }

    if (_carregando || !_temMais) return;

    _carregando = true;
    notifyListeners();

    try {
      // Monta a URL da API com base no último ID e no tamanho da página
      int tamanhoPagina = 4; // Quantidade de comentários por página
      String baseUrl = '${BASE_API}:5002/comentarios';
      String api;

      if (_ultimoId == null) {
        // Primeira página
        api = imovelId != null
            ? '$baseUrl/0/$tamanhoPagina?imovelId=$imovelId'
            : '$baseUrl/0/$tamanhoPagina';
      } else {
        // Páginas subsequentes
        api = imovelId != null
            ? '$baseUrl/$_ultimoId/$tamanhoPagina?imovelId=$imovelId'
            : '$baseUrl/$_ultimoId/$tamanhoPagina';
      }

      final Uri uri = Uri.parse(api);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final dados = json.decode(response.body) as List;

        if (dados.isEmpty) {
          _temMais = false; // Não há mais comentários
        } else {
          // Atualiza a lista de comentários
          _comentarios.addAll(
            dados.map((item) => Comentarios.fromJson(item)).toList(),
          );

          // Atualiza o último ID com o ID do último comentário retornado
          _ultimoId = _comentarios.last.id;
        }
      } else {
        throw Exception('Erro ao carregar dados da API');
      }
    } catch (e) {
      print("Erro na requisição de comentários: $e");
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }

  Future<void> carregarMaisComentarios({String? imovelId}) async {
    if (_carregando || !_temMais) return;
    await getComentarios(imovelId: imovelId);
  }

  Future<void> adicionarComentario({required Comentarios novoComentario}) async {
    try {
      final String api = '${BASE_API}:5002/comentarios';
      Uri uri = Uri.parse(api);

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(novoComentario),
      );

      if (response.statusCode == 201) {
        final comentarioCriado =
            Comentarios.fromJson(json.decode(response.body));
        _comentarios.insert(0, comentarioCriado);
        notifyListeners();
      } else {
        throw Exception('Erro ao adicionar comentário');
      }
    } catch (e) {
      print("Erro ao adicionar comentário: $e");
    }
  }

  Future<void> removerComentario(String comentarioId) async {
    try {
      final String api = '${BASE_API}:5002/comentarios/$comentarioId';
      Uri uri = Uri.parse(api);

      final response = await http.delete(uri);

      if (response.statusCode == 200) {
        _comentarios.removeWhere((comentario) => comentario.id == comentarioId);
        notifyListeners();
      } else {
        throw Exception('Erro ao apagar comentário');
      }
    } catch (e) {
      print("Erro ao apagar comentário: $e");
    }
  }
 
}