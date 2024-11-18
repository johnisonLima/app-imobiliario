// import 'package:app_front/components/cardimoveis.dart';
import 'package:app_front/components/card_imoveis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repository/imoveis_repositorio.dart';

class PaginaInicial extends StatelessWidget {
  final String title;

  const PaginaInicial({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        toolbarHeight: 150.0,
        flexibleSpace: Stack(
          children: [
            // Imagem de fundo
            Positioned.fill(
              child: Image.network(
                'https://picsum.photos/400/150/',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 60,
                ),
                child: const Column(
                  children: [
                    Text(
                      'Explore casas na\n Laís Heitz Imóveis',
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Dê uma olhada profunda e navegue por casas à venda, fotos originais do bairro, avaliações de moradores e insights locais para encontrar o que é certo para você.',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Imóveis para Venda',
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 88, 88, 88),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40, top: 10),
                    child: SizedBox(
                      width: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.width * 0.92
                          : MediaQuery.of(context).size.width * 0.95,
                      height: 220,
                      child: ChangeNotifierProvider(
                        create: (_) => ImoveisRepositorio(),
                        child: const CardImoveis(operacao: 'Venda'),                                                                       
                      ), 
                    ),
                  ),
                  
                  const Text(
                    'Imóveis para Aluguel',
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      color: Color.fromARGB(255, 88, 88, 88),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40, top: 10),
                    child: SizedBox(
                      width: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.width * 0.92
                          : MediaQuery.of(context).size.width * 0.95,
                      height: 220,
                      child: ChangeNotifierProvider(
                        create: (_) => ImoveisRepositorio(),
                        child: const CardImoveis(operacao: 'Aluguel'),                                                                       
                      ), 
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
