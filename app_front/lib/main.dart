import 'package:app_front/view/Pesquisa.dart';
import 'package:app_front/view/detalhes_imoveis.dart';
import 'package:app_front/view/pagina_inicial.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _opcaoSelecionada = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(      
      routes: {
        PaginaInicial.rountName: (context) => const PaginaInicial(),
        Pesquisa.rountName: (context) => const Pesquisa(),        
        DetalhesImoveis.rountName: (context) => const DetalhesImoveis(),        
      },
      
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100.0,
          flexibleSpace: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
            child: Stack(
              children: [            
                Positioned.fill(
                  child: Image.network(
                    'https://i.ibb.co/MkmKMPT/banner-m.webp',
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20), 
                    Center(
                      child: Image.network(
                        'https://i.ibb.co/H7wKLLZ/logo.webp',
                        width: 130,
                      ),
                    ),
                  ],
                ),            
              ],
            ),
          ),
        ),

        body: IndexedStack(
          index: _opcaoSelecionada,
          children: const <Widget> [
            PaginaInicial(),
            Pesquisa(),
            DetalhesImoveis(),
          ],
        ), 

        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.blue,
                width: 0.2,
              ),
            ),
          ),
          child: BottomNavigationBar(
            onTap: (opcao) {
              setState(() {
                _opcaoSelecionada = opcao;
              });
            },
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: const TextStyle(fontSize: 13),
            unselectedLabelStyle: const TextStyle(fontSize: 13),
            backgroundColor: Colors.grey[200],
            fixedColor: Colors.blue[800],
            unselectedItemColor: Colors.grey[600],
            currentIndex: _opcaoSelecionada,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Página Inicial',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Pesquisar'),
            ],
          ),
        ),
      ),

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
