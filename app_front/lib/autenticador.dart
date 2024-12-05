import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lh_imoveis/model/usuarios.dart';

class Autenticador {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<Usuario> login() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    print('gUser: $gUser');

    if (gUser == null) {
      throw Exception("Login cancelado pelo usuário");
    }

    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    // Credenciais para Firebase
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // Login no Firebase
    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    final User user = userCredential.user!;
    return Usuario(nome: user.displayName!, email: user.email!);
  }

  static Future<Usuario?> recuperarUsuario() async {
    final User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      return Usuario(nome: currentUser.displayName!, email: currentUser.email!);
    }
    return null;
  }

  static Future<void> logout() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }
}
