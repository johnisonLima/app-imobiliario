import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:app_front/model/imoveis.dart';
import 'package:app_front/repository/base_repositorio.dart';

class ImoveisRepositorio extends BaseRepositorio with ChangeNotifier {
  int _pagina = 1;
  bool _carregando = false;
  bool _temMais = true;

  late final List<Imovel> _imoveis = [];

  List<Imovel> get imoveis => _imoveis;
  bool get carregando => _carregando;
  bool get temMaisImoveis => _temMais;

  Future<void> getImoveis({String? operacao, bool? refresh, String? query=''}) async {
    if(refresh != null && refresh) {
      _pagina = 1;
      _imoveis.clear();
      _carregando = false;
      _temMais = true;
    }
    try {    
      final String api;

      if(query == ''){
        if (operacao != null) {
          api = '${BASE_API}imoveis?operacao=$operacao&_page=$_pagina&_limit=3';
        } else {
          api = '${BASE_API}imoveis?_page=$_pagina&_limit=3';
        }

        Uri uri = Uri.parse(api);

        final response = await http.get(uri);       

        if (response.statusCode == 200) {
          final dados = json.decode(response.body) as List;

          if (dados.isEmpty) {
            _temMais = false;
          } else {
            _imoveis.addAll(dados.map((item) => Imovel.fromJson(item)).toList());
            _pagina++;
          }
        } else {
          throw Exception('Erro ao carregar dados da API');
        }
      }
      else {
        final String api1 = '${BASE_API}imoveis?tipo_like=^$query&_page=$_pagina&_limit=3';
        final String api2 = '${BASE_API}imoveis?endereco.bairro_like=^$query&_page=$_pagina&_limit=3';
        final String api3 = '${BASE_API}imoveis?operacao=$query&_page=$_pagina&_limit=3';
        final String api4 = '${BASE_API}imoveis?sobre_like=^$query&_page=$_pagina&_limit=3';

        final Set<String> idsProcessados = {}; 

        try {
          final responses = await Future.wait([
            http.get(Uri.parse(api1)),
            http.get(Uri.parse(api2)),
            http.get(Uri.parse(api3)),
            http.get(Uri.parse(api4)),
          ]);    

          final List<Imovel> imoveisPaginaAtual = [];

          for (final response in responses) {
            if (response.statusCode == 200) {
              final List dados = json.decode(response.body) as List;
              if (dados.isNotEmpty) {
                for (var item in dados) {
                  final imovel = Imovel.fromJson(item);

                  if (!idsProcessados.contains(imovel.id)) {
                    idsProcessados.add(imovel.id);
                    imoveisPaginaAtual.add(imovel); 
                  }
                }
              }
            } else {
              throw Exception('Erro ao carregar dados da API: ${response.statusCode}');
            }
          }

          if (imoveisPaginaAtual.isEmpty) {
            _temMais = false; 
          } else {
            _imoveis.addAll(imoveisPaginaAtual); 
            _pagina++; 
          }
        } catch (e) {
          print('Erro nas requisições simultâneas: $e');
        } finally {
          notifyListeners(); 
        }
      }
    } catch (e) {
      print("Erro na requisição de imóveis: $e");
    } finally {
      _carregando = false;

      notifyListeners();
    }
  }

  Future<void> carregarMaisImoveis({String? operacao, String? query=''}) async {
    if (_carregando || !_temMais) return;

    _carregando = true;
    notifyListeners();

    await getImoveis(operacao: operacao, query: query);
  }
}


  /*
  npm install json-server@0.17.3
  npm install --save json-server@0.17.3
  
  "scripts": {
    "server-start": "json-server --host 192.168.0.129 --port 8080 db/db.json"
  }
  npm run server-start
  */
