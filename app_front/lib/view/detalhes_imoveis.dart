import 'package:flutter/material.dart';

import '../model/imovel_detalhe_args .dart';

class DetalhesImoveis extends StatefulWidget {
  static const rountName = '/DetalhesImoveis';

  const DetalhesImoveis({super.key});

  @override
  State<DetalhesImoveis> createState() => _DetalhesImoveisState();
}

class _DetalhesImoveisState extends State<DetalhesImoveis> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is! ImovelDetalhesArgs) {
      return Scaffold(
        appBar: AppBar(title: const Text('Erro')),
        body: const Center(
          child: Text('Argumentos inválidos ou ausentes.'),
        ),
      );
    }

    final id = args.id;

    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do Imóvel')),
      body: Center(
        child: Text('Buscando detalhes para o ID: $id'),
      ),
    );
  }
}
