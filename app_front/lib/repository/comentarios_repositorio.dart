import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lh_imoveis/model/comentarios.dart';
import 'package:lh_imoveis/repository/base_repositorio.dart';

class ComentariosRepositorio extends BaseRepositorio with ChangeNotifier {
  int _pagina = 1;
  bool _carregando = false;
  bool _temMais = true;

  late final List<Comentarios> _comentarios = [];

  List<Comentarios> get comentarios => _comentarios;
  bool get carregando => _carregando;
  bool get temMais => _temMais;

  Future<void> getComentarios({String? id, bool? refresh}) async {
    if (refresh != null && refresh) {
      _pagina = 1;
      _comentarios.clear();
      _carregando = false;
      _temMais = true;
    }
    try {
      final String api;

      if (id != null) {
        api =
            '${BASE_API}comentarios?imovelId=$id&_page=$_pagina&_limit=4&_sort=data&_order=desc';
      } else {
        api = '${BASE_API}comentarios?_page=$_pagina&_limit=3';
      }

      Uri uri = Uri.parse(api);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final dados = json.decode(response.body) as List;

        if (dados.isEmpty) {
          _temMais = false;
        } else {
          _comentarios
              .addAll(dados.map((item) => Comentarios.fromJson(item)).toList());

          notifyListeners();

          _pagina++;
        }
      } else {
        throw Exception('Erro ao carregar dados da API');
      }
    } catch (e) {
      print("Erro na requisição de Comentários: $e");
    } finally {
      _carregando = false;

      notifyListeners();
    }
  }

  Future<void> carregarMaisComentarios({String? id}) async {
    if (_carregando || !_temMais) return;

    _carregando = true;
    notifyListeners();

    await getComentarios(id: id);
  }

  Future<void> adicionarComentario(
      {required Comentarios novoComentario}) async {
    try {
      final String api = '${BASE_API}comentarios';

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

  Future<void> apagarComentario(String comentarioId) async {
    try {
      final String api = '${BASE_API}comentarios/$comentarioId';

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
