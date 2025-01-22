// ignore_for_file: unnecessary_brace_in_string_interps
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lh_imoveis/repository/base_repositorio.dart';
import 'package:lh_imoveis/model/likes.dart';

class LikesRepositorio extends BaseRepositorio with ChangeNotifier {
  Future<List<Like>> getLikesImovel(String imovelId) async {
    try {
      final String api = '${BASE_API}:5003/likes/$imovelId';
      Uri uri = Uri.parse(api);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> dados = json.decode(response.body);
        return dados.map((likeJson) => Like.fromJson(likeJson)).toList();
      } else {
        throw Exception('Erro ao listar likes');
      }
    } catch (e) {
      print("Erro ao listar likes: $e");
      return [];
    }
  }

  Future<void> adicionarLike(String imovelId, String usuarioId) async {
    try {
      final String api = '${BASE_API}:5003/likes';
      Uri uri = Uri.parse(api);

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "imovelId": imovelId,
          "usuarioId": usuarioId,
        }),
      );

      if (response.statusCode == 201) {
        // print('Like registrado com sucesso');
      } else {
        throw Exception('Erro ao registrar like');
      }
    } catch (e) {
      print("Erro ao registrar like: $e");
    }
  }

  Future<void> removerLike(String imovelId, String usuarioId) async {
    try {
      final String api = '${BASE_API}:5003/likes/$imovelId/$usuarioId';
      Uri uri = Uri.parse(api);

      final response = await http.delete(uri);

      if (response.statusCode == 200) {
        // print('Like removido com sucesso');
      } else {
        throw Exception('Erro ao remover like');
      }
    } catch (e) {
      print("Erro ao remover like: $e");
    }
  }

  Future<bool> verificarLike(String imovelId, String usuarioId) async {
    final String api = '${BASE_API}:5003/likes/$imovelId/$usuarioId';
    Uri uri = Uri.parse(api);

    try {
      final response = await http.get(uri);      

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['curtiu'] ?? false; // Retorna true ou false
      } else {
        throw Exception('Erro ao verificar like');
      }
    } catch (e) {
      print('Erro ao verificar like: $e');
      return false;
    }
  }
}
