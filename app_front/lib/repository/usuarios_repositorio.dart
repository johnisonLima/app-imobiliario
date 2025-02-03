// ignore_for_file: unnecessary_brace_in_string_interps
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:lh_imoveis/model/usuarios.dart';
import 'package:lh_imoveis/repository/base_repositorio.dart';

class UsuarioManager extends BaseRepositorio with ChangeNotifier {
  Usuario? _usuario;
  Usuario? get usuario => _usuario;

  bool get estaLogado => _usuario != null;

  void login(Usuario usuario) {
    _usuario = usuario;
    notifyListeners();
  }

  void logoff() {
    _usuario = null;
    notifyListeners();
  }

  Future<void> registrarUsuario(User user) async {
    final url = Uri.parse("${BASE_API}:5004/usuarios");

    // Corpo da requisição
    final body = {
      "uid": user.uid,
      "email": user.email,
      "nome": user.displayName,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 201) {
        // print("Usuário registrado com sucesso!");
      } else if (response.statusCode == 200) {
        // print("Usuário já registrado.");
      } else {
        print("Erro: ${response.body}");
      }
    } catch (e) {
      print("Erro ao registrar usuário: $e");
    }
  }
}

late UsuarioManager estadoUsuario;
