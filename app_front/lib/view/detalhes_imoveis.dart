import 'package:app_front/model/imoveis.dart';
import 'package:flutter/material.dart';

class DetalhesImoveis extends StatefulWidget {
  static const rountName = '/DetalhesImoveis';

  const DetalhesImoveis({super.key});

  @override
  State<DetalhesImoveis> createState() => _DetalhesImoveisState();
}

class _DetalhesImoveisState extends State<DetalhesImoveis> {
  late PageController _controladorSlides;
  late int _slideSelecionado;

  @override
  void initState() {
    super.initState();
    _iniciarSlides();
  }

  void _iniciarSlides() {
    _slideSelecionado = 0;
    _controladorSlides = PageController(initialPage: _slideSelecionado);
  }

  @override
  Widget build(BuildContext context) {
    const double alturaImagem = 500;
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is! Imovel) {
      return Scaffold(
        appBar: AppBar(title: const Text('Erro')),
        body: const Center(
          child: Text('Argumentos inválidos ou ausentes.'),
        ),
      );
    }
    
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).orientation == Orientation.portrait
                  ? alturaImagem : alturaImagem / 1.8,
                child: Stack(
                  children: [
                    PageView.builder(
                      itemCount: args.imagens.length,
                      controller: _controladorSlides,
                      onPageChanged: (slide) {
                        setState(() {
                          _slideSelecionado = slide;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                args.imagens[index].url,
                                fit: BoxFit.cover, 
                                width: double.infinity,
                                height: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? alturaImagem : alturaImagem / 1.8,
                              ),
                            ),
              
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(args.titulo, 
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
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
                                  Text(args.tipo,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 5.0,
                                          color: Colors.black45,
                                          offset: Offset(2, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          
                            Positioned(
                              top: 10,
                              right: 10,
                              child:  Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(                                    
                                  color: const Color.fromARGB(54, 158, 158, 158),
                                  borderRadius: BorderRadius.circular(40),                                  
                                ),
                                child: const Icon(
                                  Icons.favorite_border, color: Colors.white,
                                ),
                              ),
                            ),
                          ]
                        );
                      },
                    ),
                  ]
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 18, left: 10, right: 10, bottom: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'R\$: ${args.valor}', 
                      style: const TextStyle(fontSize: 25),
                    ),

                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          color: Colors.grey, 
                          width: 0.8,        
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.share_outlined, color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
