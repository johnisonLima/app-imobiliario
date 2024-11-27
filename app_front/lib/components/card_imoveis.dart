import 'package:app_front/components/icones_imovel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repository/imoveis_repositorio.dart';
import '../view/detalhes_imoveis.dart';

class CardImoveis extends StatelessWidget {
  final String? operacao;

  const CardImoveis({super.key, this.operacao});

  @override
  Widget build(BuildContext context) {
    final imoveisRepo = Provider.of<ImoveisRepositorio>(context, listen: false);
    final scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        imoveisRepo.carregarMaisImoveis(operacao: operacao);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      imoveisRepo.getImoveis(operacao: operacao);
    });

    return Consumer<ImoveisRepositorio>(
      builder: (context, repositorio, child) {
        if (repositorio.carregando && repositorio.imoveis.isEmpty) {
          return const SizedBox(
            width: 360,
            height: 220,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (!repositorio.carregando && repositorio.imoveis.isEmpty) {
          return const Center(child: Text('Nenhum imóvel encontrado!'));
        }

        return ListView.builder(
          controller: scrollController,
          itemCount: repositorio.imoveis.length + 1,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            if (index == repositorio.imoveis.length) {
              return Center(
                child: repositorio.carregando
                    ? const CircularProgressIndicator()
                    : const SizedBox.shrink(),
              );
            }

            final imovel = repositorio.imoveis[index];

            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context, 
                    DetalhesImoveis.rountName,
                    arguments: imovel,
                  );
                },
                child: Card(
                  child: SizedBox(
                    width: 290,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                              child: Image.network(
                                imovel.imagemDestaque,
                                width: double.infinity,
                                height: 135,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Text(
                                imovel.tipo,
                                style: const TextStyle(
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
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Text(
                                          imovel.comodidades[0].qtd.toString(),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 3),
                                        ),
                                        Icon(
                                          IconesImovel.iconMap[repositorio
                                              .imoveis[index]
                                              .comodidades[0]
                                              .tipo],
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 5),
                                        ),
                                        Text(
                                          imovel.comodidades[1].qtd.toString(),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 3),
                                        ),
                                        Icon(
                                          IconesImovel.iconMap[repositorio
                                              .imoveis[index]
                                              .comodidades[1]
                                              .tipo],
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 5),
                                        ),
                                        Text(
                                          imovel.comodidades[2].qtd.toString(),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 3),
                                        ),
                                        Icon(IconesImovel.iconMap[repositorio
                                            .imoveis[index]
                                            .comodidades[2]
                                            .tipo]),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 5),
                                        ),
                                      ],
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 10),
                                    ),
                                    Text(
                                      imovel.titulo,
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
// 197