import 'package:app_front/model/comentarios.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ComentariosRepositorio with ChangeNotifier {
  int _pagina = 1;
  bool _carregando = false;
  bool _temMais = true;

  late final List<Comentarios> _comentarios = [];

  List<Comentarios> get comentarios => _comentarios;
  bool get carregando => _carregando;
  bool get temMais => _temMais;

  Future<void> getComentarios({String? id}) async {
    try {
      const apiUrl = 'http://192.168.0.129:8080/';

      final String api;

      if(id != null){
        api = '${apiUrl}comentarios?imovelId=$id&_page=$_pagina&_limit=3';
      }
      else{
        api = '${apiUrl}comentarios?_page=$_pagina&_limit=3';
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
}
