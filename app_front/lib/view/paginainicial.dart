import 'package:app_front/components/cardimoveis.dart';
import 'package:flutter/material.dart';

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
              child: Image.network('https://picsum.photos/400/150/', 
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
        
            const Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
    
              child: CardImoveis(),               
            ),
          ],
        ),
      ),
    );
  }
}