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
    // npm install json-server@0.17.3
    // npm install --save json-server@0.17.3
    /*
    "scripts": {
      "server-start": "json-server --host 192.168.0.129 --port 8080 db/db.json"
    }
    */
    // npm run server-start

    var api = 'http://192.168.0.129:8080/imoveis';
    Uri uri = Uri.parse(api);

    var response = await http.get(uri);

    var dados = json.decode(response.body) as List;
    List<Imovel> imoveis;

    try {
      // Mapeando os dados para a lista de objetos Imovel
      if (chave == null && valor == null) {
        imoveis = dados.map((item) => Imovel.fromJson(item)).toList();
      } else {
        imoveis = dados
            .where((item) => item[chave] == valor)
            .map((item) => Imovel.fromJson(item))
            .toList();
      }
    } catch (e) {
      print("Erro ao mapear os imóveis: $e");
      return [];
    }


    return imoveis;
  }

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
                        final imovel = snapshot.data[index];
 
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
                        final imovel = snapshot.data[index];

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
