import 'package:app_front/view/Pesquisa.dart';
import 'package:app_front/view/detalhes_imoveis.dart';
import 'package:app_front/view/pagina_inicial.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/imoveis.dart';
import 'repository/comentarios_repositorio.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: PaginaInicial.rountName,
      onGenerateRoute: (settings) {
        if (settings.name == DetalhesImoveis.rountName) {
          final imovel = settings.arguments
              as Imovel; // Converta o argumento corretamente.

          if (imovel == null) {
            throw Exception("Erro: Argumento 'imovel' está nulo.");
          }

          return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (_) => ComentariosRepositorio(),
              child: DetalhesImoveis(imovel: imovel),
            ),
          );
        }

        // Rotas estáticas
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

        // Define the default brightness and colors.
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.light,
        ),

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          // ···
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
