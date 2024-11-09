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
    return GestureDetector(      
      child: FutureBuilder(
        future: _getImoveis(),
        builder:(BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar dados'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum imóvel encontrado'));
          }

          return Expanded(
            child: SizedBox(
              width: 280,
              height: 220,
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  dadosBackend = snapshot.data[index];
                  
                  return Card(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                              child: Image.network('https://picsum.photos/280/135/',
                                  width: double.infinity,
                                  height: 135,
                                  fit: BoxFit.cover),
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      // textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Text(
                                          '3',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Padding(padding: EdgeInsets.only(left: 3)),
                                        Icon(Icons.bed_outlined),
                                        Padding(padding: EdgeInsets.only(left: 5)),
                                        Text(
                                          '3',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Padding(padding: EdgeInsets.only(left: 3)),
                                        Icon(Icons.shower_outlined),
                                        Padding(padding: EdgeInsets.only(left: 5)),
                                        Text(
                                          '5',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Padding(padding: EdgeInsets.only(left: 3)),
                                        Icon(Icons.directions_car_outlined),
                                        Padding(padding: EdgeInsets.only(left: 5)),
                                      ],
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 10)),
                                    Text(
                                      'Candeias Premiun Residencial',
                                      style: TextStyle(fontSize: 15.5),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }              
              ),
            ),
          );
        },
      ),
    );    
  }
}
