import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:lh_imoveis/model/usuarios.dart';
import 'package:lh_imoveis/repository/usuarios_repositorio.dart';

class Autenticador {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<Usuario> login() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    if (gUser == null) {
      throw Exception("Login cancelado pelo usuário");
    }

    final GoogleSignInAuthentication gAuth = await gUser.authentication;
    FirebaseAuth.instance.setLanguageCode('pt-BR');

    // Credenciais para Firebase
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // Login no Firebase
    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    final User user = userCredential.user!;
    final usuarioManager = UsuarioManager();
    await usuarioManager.registrarUsuario(user);
    return Usuario(
      uid: user.uid, nome: user.displayName!, email: user.email!);
  }

 
  static Future<Usuario?> recuperarUsuario() async {
    final User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      return Usuario(uid: currentUser.uid, nome: currentUser.displayName!, email: currentUser.email!);
    }
    return null;
  }

  static Future<void> logout() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }
}
