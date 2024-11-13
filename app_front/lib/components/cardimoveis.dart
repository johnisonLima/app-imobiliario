import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repository/imoveis_repositorio.dart';

class CardImoveis extends StatefulWidget {
  const CardImoveis({super.key});

  @override
  State<CardImoveis> createState() => _CardImoveisState();
}

class _CardImoveisState extends State<CardImoveis> {
  late ImoveisRepositorio imoveisRepo;
  late ScrollController _scrollInfinito;
  // final loading = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    imoveisRepo = ImoveisRepositorio();
    _scrollInfinito = ScrollController();
    // loadImoveis();

    Provider.of<ImoveisRepositorio>(context, listen: false).getImoveis();

    _scrollInfinito.addListener(() {
      if (_scrollInfinito.position.pixels ==
          _scrollInfinito.position.maxScrollExtent) {
        final repositorio =
            Provider.of<ImoveisRepositorio>(context, listen: false);
        repositorio.carregarMaisImoveis();
      }
    });
  }

    @override
    void dispose() {
      _scrollInfinito.dispose();
      super.dispose();
    }

  // loadImoveis() async {
  //   loading.value = true;
  //   // await imoveisRepo.getImoveis();
  //   loading.value = true;
  // }

  @override
  Widget build(BuildContext context) {
    Map<String, IconData> iconMap = {
      'banheiro': Icons.shower_outlined,
      'quarto': Icons.bed_outlined,
      'garagem': Icons.directions_car_outlined,
      'portaria blindada': Icons.verified_user_outlined,
      'climatizada': Icons.thermostat_auto_outlined,
      'vigilancia': Icons.camera_outdoor_outlined,
      'refeitorio': Icons.restaurant_outlined,
      'wifi': Icons.wifi_outlined,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 18),
          child: const Text(
            'Imóveis para Venda',
            style: TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic,
              color: Color.fromARGB(255, 88, 88, 88),
            ),
            textAlign: TextAlign.start,
          ),
        ),
        Consumer<ImoveisRepositorio>(
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

            return Padding(
              padding: const EdgeInsets.only(bottom: 15.0, top: 8.0),
              child: Consumer<ImoveisRepositorio>(
                builder: (context, repositorio, child) {
                  return SizedBox(
                    width: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? MediaQuery.of(context).size.width * 0.92
                        : MediaQuery.of(context).size.width * 0.95,
                    height: 220,
                    child: ListView.builder(
                      controller: _scrollInfinito,
                      itemCount: repositorio.temMaisImoveis
                          ? repositorio.imoveis.length + 1
                          : repositorio.imoveis.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final imovel = repositorio.imoveis[index];

                        if (index < repositorio.imoveis.length) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              print(imovel.id);
                              print(imovel.operacao);
                            },
                            child: Card(
                              child: SizedBox(
                                width: 290,
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: [
                                                    Text(
                                                      imovel.comodidades[0].qtd
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 3),
                                                    ),
                                                    Icon(
                                                      iconMap[repositorio
                                                          .imoveis[index]
                                                          .comodidades[0]
                                                          .tipo],
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5),
                                                    ),
                                                    Text(
                                                      imovel.comodidades[1].qtd
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 3),
                                                    ),
                                                    Icon(
                                                      iconMap[repositorio
                                                          .imoveis[index]
                                                          .comodidades[1]
                                                          .tipo],
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5),
                                                    ),
                                                    Text(
                                                      imovel.comodidades[2].qtd
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 3),
                                                    ),
                                                    Icon(iconMap[repositorio
                                                        .imoveis[index]
                                                        .comodidades[2]
                                                        .tipo]),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5),
                                                    ),
                                                  ],
                                                ),
                                                const Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
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
                      
                        }
                        else {
                          // Exibe um indicador de carregamento no final da lista
                          return const Center(child: CircularProgressIndicator());
                        }

                        
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
