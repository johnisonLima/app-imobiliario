import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lh_imoveis/repository/likes_repositorio.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:lh_imoveis/model/imoveis.dart';
import 'package:lh_imoveis/repository/comentarios_repositorio.dart';
import 'package:lh_imoveis/view/pesquisar_imoveis.dart';
import 'package:lh_imoveis/view/detalhes_imoveis.dart';
import 'package:lh_imoveis/view/pagina_inicial.dart';
import 'package:lh_imoveis/repository/usuarios_repositorio.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized(); 
 await Firebase.initializeApp();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => LikesRepositorio()),
      ChangeNotifierProvider(create: (_) => UsuarioManager()),
    ],
    child: const App(),
    // ChangeNotifierProvider(
    //   create: (_) => UsuarioManager(),      
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    estadoUsuario = context.watch<UsuarioManager>();

    return MaterialApp(
      initialRoute: PaginaInicial.rountName,
      onGenerateRoute: (settings) {
        if (settings.name == DetalhesImoveis.rountName) {
          final imovel = settings.arguments as Imovel;

          return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (_) => ComentariosRepositorio(),
              child: DetalhesImoveis(imovel: imovel),
            ),
          );
        }

        return MaterialPageRoute(
          builder: (context) {
            switch (settings.name) {
              case PaginaInicial.rountName:
                return const PaginaInicial();
              case Pesquisa.rountName:
                return const Pesquisa();
              default:
                throw Exception('Rota desconhecida: ${settings.name}');
            }
          },
        );
      },
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          iconTheme: IconThemeData(
            size: 30,
            color: Colors.white,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.light,
        ),
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: GoogleFonts.oswald(
            fontSize: 30,
            fontStyle: FontStyle.italic,
          ),
          bodyMedium: GoogleFonts.merriweather(),
          displaySmall: GoogleFonts.pacifico(),
        ),
      ),
    );
  }
}
