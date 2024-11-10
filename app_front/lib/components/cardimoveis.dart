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
  var dadosBackend;

  Future<List<Imovel>> _getImoveis() async {
    var api =
        'https://api.json-generator.com/templates/yDqMZNG19PT6/data?access_token=i0e5kvqe4bphiqpos2fqgddsk9ivs2nqiltt4ytd';
    Uri uri = Uri.parse(api);

    var response = await http.get(uri);

    var dados = json.decode(response.body) as List;

    // Convertendo cada item da lista em um objeto Todo
    List<Imovel> imoveis = dados.map((item) => Imovel.fromJson(item)).toList();

    return imoveis;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, IconData> iconMap = {
      'shower': Icons.shower_outlined,
      'bed': Icons.bed_outlined,
      'garage': Icons.directions_car_outlined,
      // Adicione outros ícones conforme necessário
    };

    return

        // GestureDetector(
        //   child:
        FutureBuilder(
      future: _getImoveis(),
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
          return const Center(child: Text('Erro ao carregar dados'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhum imóvel encontrado'));
        }

        return GestureDetector(
          onTap: () {
            print(dadosBackend.id);
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.90,
            height: 220,
            child: ListView.builder(
              itemCount: snapshot.data.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                dadosBackend = snapshot.data[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                                    dadosBackend.imagemDestaque,
                                    width: double.infinity,
                                    height: 135,
                                    fit: BoxFit.cover),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 10,
                                child: Text(
                                  dadosBackend.tipo,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        textBaseline: TextBaseline.alphabetic,
                                        children: [
                                          Text(
                                            dadosBackend.comodidades[0].qtd
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 3)),
                                          Icon(iconMap[dadosBackend
                                              .comodidades[0].tipo]),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 5)),
                                          Text(
                                            dadosBackend.comodidades[1].qtd
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 3)),
                                          Icon(iconMap[dadosBackend
                                              .comodidades[1].tipo]),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 5)),
                                          Text(
                                            dadosBackend.comodidades[2].qtd
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 3)),
                                          Icon(iconMap[dadosBackend
                                              .comodidades[2].tipo]),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 5)),
                                        ],
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(top: 10)),
                                      Text(
                                        dadosBackend.titulo,
                                        style: const TextStyle(fontSize: 15),
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
                );
              },
            ),
          ),
        );
      },
    );
    // );
  }
}
