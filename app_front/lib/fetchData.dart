import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Teste extends StatefulWidget {
  const Teste({super.key});

  @override
  State<Teste> createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  Future<void> fetchData() async {
    var api = 'http://192.168.0.129:8080/imoveis';
    Uri uri = Uri.parse(api);

    print(uri);

    try {
      var response = await http.get(uri);
      
        print(response);

      if (response.statusCode == 200) {
        // Dados carregados com sucesso
        print('Dados carregados ${response.body}');
      } else {
        // Código de status não OK
        print('Erro ao carregar os dados: ${response.statusCode}');
      }
    } catch (e) {
      // Captura de exceções de rede
      print('Erro de rede ao carregar dados: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchData();
    return Container();
  }
}
