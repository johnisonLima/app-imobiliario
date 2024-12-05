import 'package:flutter/material.dart';
import 'package:lh_imoveis/model/usuarios.dart';

class UsuarioManager with ChangeNotifier {
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
}

late UsuarioManager estadoUsuario;
