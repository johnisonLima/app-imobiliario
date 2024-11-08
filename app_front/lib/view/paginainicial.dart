import 'package:flutter/material.dart';

class PaginaInicial extends StatelessWidget {
  final String title;

  const PaginaInicial({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
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
          
          SizedBox(
            width: 280,
            child: Card(
              child: Column(        
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                        child: Image.network(
                          'https://picsum.photos/280/135/',
                          width: double.infinity,
                          height: 135,
                          fit: BoxFit.cover
                        ),
                      ),
                      const Positioned(
                        bottom: 10,
                        left: 10, 
                        child: Text(
                          'Texto Sobre a Imagem',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 5.0,
                                color: Colors.black45,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                      ),            
                    ],
                  ),
                  
            
                  
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [                    
                              Text('Icones'), 
                              Text('Candeias Premiun Residencial'),
                              Text('Outros'),              
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                  
            
            
                ],
              ),
            ),
          ),
        ],
      ),     
    );
  }
}