import 'package:flutter/material.dart';

import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/imoveis.dart';

class CardImoveis extends StatefulWidget {
  const CardImoveis({super.key});

  @override
  State<CardImoveis> createState() => _CardImoveisState();
}

class _CardImoveisState extends State<CardImoveis> {
  Future<List<Imovel>> _getImoveis({String? chave, String? valor}) async {
    var api =
        'https://api.json-generator.com/templates/yDqMZNG19PT6/data?access_token=i0e5kvqe4bphiqpos2fqgddsk9ivs2nqiltt4ytd';
    Uri uri = Uri.parse(api);

    var response = await http.get(uri);

    var dados = json.decode(response.body) as List;
    List<Imovel> imoveis;

    if (chave == null && valor == null) {
      imoveis = dados.map((item) => Imovel.fromJson(item)).toList();
    } else {
      imoveis = dados
          .where((item) => item[chave] == valor)
          .map((item) => Imovel.fromJson(item))
          .toList();
    }

    return imoveis;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, IconData> iconMap = {
      'shower': Icons.shower_outlined,
      'bed': Icons.bed_outlined,
      'garage': Icons.directions_car_outlined,
    };

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0, top: 8.0),
          child: FutureBuilder(
            future: _getImoveis(chave: 'operacao', valor: 'Venda'),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  width: 360,
                  height: 220,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(child: Text('Erro ao carregar dados!'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('Nenhum imóvel encontrado!'));
              }

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
                  SizedBox(
                    width: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? MediaQuery.of(context).size.width * 0.92
                        : MediaQuery.of(context).size.width * 0.95,
                    height: 220,
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              print(snapshot.data[index].id);
                              print(snapshot.data[index].operacao);
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
                                            snapshot.data[index].imagemDestaque,
                                            width: double.infinity,
                                            height: 135,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 10,
                                          left: 10,
                                          child: Text(
                                            snapshot.data[index].tipo,
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
                                                      snapshot.data[index]
                                                          .comodidades[0].qtd
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
                                                      iconMap[snapshot
                                                          .data[index]
                                                          .comodidades[0]
                                                          .tipo],
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5),
                                                    ),
                                                    Text(
                                                      snapshot.data[index]
                                                          .comodidades[1].qtd
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
                                                      iconMap[snapshot
                                                          .data[index]
                                                          .comodidades[1]
                                                          .tipo],
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5),
                                                    ),
                                                    Text(
                                                      snapshot.data[index]
                                                          .comodidades[2].qtd
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
                                                    Icon(iconMap[snapshot
                                                        .data[index]
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
                                                  snapshot.data[index].titulo,
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
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0, top: 8.0),
          child: FutureBuilder(
            future: _getImoveis(chave: 'operacao', valor: 'Aluguel'),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  width: 360,
                  height: 220,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(child: Text('Erro ao carregar dados!'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('Nenhum imóvel encontrado!'));
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: const Text(
                      'Imóveis para Aluguel',
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        color: Color.fromARGB(255, 88, 88, 88),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? MediaQuery.of(context).size.width * 0.92
                        : MediaQuery.of(context).size.width * 0.95,
                    height: 220,
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              print(snapshot.data[index].id);
                              print(snapshot.data[index].operacao);
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
                                            snapshot.data[index].imagemDestaque,
                                            width: double.infinity,
                                            height: 135,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 10,
                                          left: 10,
                                          child: Text(
                                            snapshot.data[index].tipo,
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
                                                      snapshot.data[index]
                                                          .comodidades[0].qtd
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
                                                      iconMap[snapshot
                                                          .data[index]
                                                          .comodidades[0]
                                                          .tipo],
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5),
                                                    ),
                                                    Text(
                                                      snapshot.data[index]
                                                          .comodidades[1].qtd
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
                                                      iconMap[snapshot
                                                          .data[index]
                                                          .comodidades[1]
                                                          .tipo],
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5),
                                                    ),
                                                    Text(
                                                      snapshot.data[index]
                                                          .comodidades[2].qtd
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
                                                    Icon(iconMap[snapshot
                                                        .data[index]
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
                                                  snapshot.data[index].titulo,
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
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
