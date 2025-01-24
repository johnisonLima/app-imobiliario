import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lh_imoveis/model/imoveis.dart';
import 'package:lh_imoveis/repository/base_repositorio.dart';

class ImoveisRepositorio extends BaseRepositorio with ChangeNotifier {
  String? _ultimoId; 
  bool _carregando = false;
  bool _temMais = true;

  final List<dynamic> _imoveis = [];
  List<dynamic> get imoveis => _imoveis;
  bool get carregando => _carregando;
  bool get temMaisImoveis => _temMais;

  Future<void> getImoveis({String? operacao, bool? refresh = false}) async {
    _reload(refresh);

    if (_carregando || !_temMais) return;

    _carregando = true;
    notifyListeners();

    try {
      int tamanhoPagina = 3;
      String baseImageUrl = '${BASE_API}:5005';
      String baseUrl = '${BASE_API}:5001/imoveis';
      String api;

      if (_ultimoId == null) {
        api = operacao != null
            ? '$baseUrl/0/$tamanhoPagina?operacao=$operacao'
            : '$baseUrl/0/$tamanhoPagina';
      } else {
        api = operacao != null
            ? '$baseUrl/$_ultimoId/$tamanhoPagina?operacao=$operacao'
            : '$baseUrl/$_ultimoId/$tamanhoPagina';
      }

      final Uri uri = Uri.parse(api);
      final response = await http.get(uri);
      print("ultimoId: $_ultimoId");

      if (response.statusCode == 200) {
        final dados = json.decode(response.body) as List;

        if (dados.isEmpty) {
          _temMais = false; 
        } else {
          _imoveis.addAll(dados.map((item) {
            String caminhoDestaque = item['imagemDestaque'] ?? '';
            item['imagemDestaque'] = caminhoDestaque.isNotEmpty
                ? '$baseImageUrl$caminhoDestaque'
                : null;
            
            if (item['imagens'] != null && item['imagens'] is List) {
              item['imagens'] = (item['imagens'] as List).map((img) {
                if (img['url'] != null && !(img['url'] as String).startsWith('http')) {
                  img['url'] = '$baseImageUrl${img['url']}';
                }
                return img;
              }).toList();
            }

            return Imovel.fromJson(item);
          }).toList());

          _ultimoId = _imoveis.last.id;
        }
      } else {
        throw Exception('Erro ao carregar dados da API');
      }
    } catch (e) {
      print("Erro na requisição de imóveis: $e");
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }

  Future<void> buscarImoveis({
    String? tipo,
    String? operacao,
    String? bairro,
    String? cidade,
    String? estado,
    double? minValor,
    double? maxValor,
    double? minArea,
    double? maxArea,
    List<String>? comodidades,
    bool? refresh = false,
    bool novaBusca = false,
  }) async {
    _reload(refresh);

    if (_carregando || !_temMais) return;

    _carregando = true;
    notifyListeners();

    try {
      int tamanhoPagina = 3;
      String baseImageUrl = '${BASE_API}:5005';
      String baseUrl = '${BASE_API}:5001/buscar_imoveis';
      String api;

      Map<String, String> params = {};

      if (tipo != null) params['tipo'] = tipo;
      if (operacao != null) params['operacao'] = operacao;
      if (bairro != null) params['bairro'] = bairro;
      if (cidade != null) params['cidade'] = cidade;
      if (estado != null) params['estado'] = estado;
      if (minValor != null) params['min_valor'] = minValor.toString();
      if (maxValor != null) params['max_valor'] = maxValor.toString();
      if (minArea != null) params['min_area'] = minArea.toString();
      if (maxArea != null) params['max_area'] = maxArea.toString();
      if (comodidades != null && comodidades.isNotEmpty) {
        params['comodidades'] = comodidades.join(',');
      }

      if (_ultimoId == null) {
        api = '$baseUrl/0/$tamanhoPagina';
      } else {
        api = '$baseUrl/$_ultimoId/$tamanhoPagina';
      }

      if (params.isNotEmpty) {
        api += '?${Uri(queryParameters: params).query}';
      }

      final Uri uri = Uri.parse(api);
      final response = await http.get(uri);
      print("ultimoId: $_ultimoId");

      if (response.statusCode == 200) {
        final dados = json.decode(response.body) as List;

        if (dados.isEmpty) {
          _temMais = false; 
        } else {
          _imoveis.addAll(dados.map((item) {
            String caminhoDestaque = item['imagemDestaque'] ?? '';
            item['imagemDestaque'] = caminhoDestaque.isNotEmpty
                ? '$baseImageUrl$caminhoDestaque'
                : null;

            if (item['imagens'] != null && item['imagens'] is List) {
              item['imagens'] = (item['imagens'] as List).map((img) {
                if (img['url'] != null && !(img['url'] as String).startsWith('http')) {
                  img['url'] = '$baseImageUrl${img['url']}';
                }
                return img;
              }).toList();
            }

            return Imovel.fromJson(item);
          }).toList());

          _ultimoId = _imoveis.last.id;
        }
      } else {
        throw Exception('Erro ao carregar dados da API');
      }
    } catch (e) {
      print("Erro na requisição de imóveis: $e");
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }

  Future<void> carregarMaisImoveis({String? operacao}) async {
    if (_carregando || !_temMais) return;
    await getImoveis(operacao: operacao);
  }

  Future<void> carregarMaisImoveisBusca({
    String? tipo,
    String? operacao,
    String? bairro,
    String? cidade,
    String? estado,
    double? minValor,
    double? maxValor,
    double? minArea,
    double? maxArea,
    List<String>? comodidades,
    bool? refresh = false,
  }) async {
    if (_carregando || !_temMais) return;
    await buscarImoveis(
      tipo: tipo,
      operacao: operacao,
      bairro: bairro,
      cidade: cidade,
      estado: estado,
      minValor: minValor,
      maxValor: maxValor,
      minArea: minArea,
      maxArea: maxArea,
      comodidades: comodidades,
    );
  }

  _reload(bool? refresh) {
    if (refresh != null && refresh) {
      _ultimoId = null; 
      _imoveis.clear();
      _carregando = false;
      _temMais = true;
    }
  }
}
