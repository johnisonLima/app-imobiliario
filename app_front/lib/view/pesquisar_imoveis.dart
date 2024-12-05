import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:app_front/components/icones_imovel.dart';
import 'package:app_front/view/detalhes_imoveis.dart';
import 'package:app_front/repository/imoveis_repositorio.dart';


class Pesquisa extends StatefulWidget {
  static const rountName = '/Pesquisa';
  
  const Pesquisa({super.key});   

  @override
  State<Pesquisa> createState() => _PesquisaState();
}

class _PesquisaState extends State<Pesquisa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (_) => ImoveisRepositorio(),
        child: const ImoveisFeed(),
      ),
    );
  }
}

class ImoveisFeed extends StatefulWidget {
  const ImoveisFeed({super.key});

  @override
  State<ImoveisFeed> createState() => _ImoveisFeedState();
}

class _ImoveisFeedState extends State<ImoveisFeed> {
  late TextEditingController _controladorBusca;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    
    final imoveisRepo = Provider.of<ImoveisRepositorio>(context, listen: false);
    imoveisRepo.getImoveis();
    
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _controladorBusca = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _controladorBusca.dispose();
  }   

  void _onScroll() {
    final imoveisRepo = Provider.of<ImoveisRepositorio>(context, listen: false);

    final position = _scrollController.position.pixels;
    final maxScroll = _scrollController.position.maxScrollExtent;

    if (position == maxScroll) {
      if(_controladorBusca.text.isEmpty) {
          if(imoveisRepo.temMaisImoveis) {
            imoveisRepo.carregarMaisImoveis();
          }
        }
        else {
          imoveisRepo.carregarMaisImoveis(query: _controladorBusca.text);
        }
    }
  }

  @override
  Widget build(BuildContext context) {      
    return Column(
      children: [
        _pesquisarImoveis(context, _controladorBusca),
        Expanded(child: _exibirImoveis(context, _scrollController)),
      ],
    );
  }
}

Widget _pesquisarImoveis(BuildContext context, TextEditingController controladorBusca) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: TextField(
      controller: controladorBusca,
      decoration: InputDecoration(
        hintText: 'Encontre seu novo apartamento, casa, terrenos e muito mais',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
        icon: const Icon(Icons.send),
        color: Colors.blue,
        onPressed: () {
          String conteudo = controladorBusca.text.trim();

          Provider.of<ImoveisRepositorio>(context, listen: false)
            .getImoveis(query: conteudo, refresh: true);
          
          FocusScope.of(context).unfocus();
        },
      ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
  );
}

Widget _exibirImoveis(BuildContext context, ScrollController scrollController) {
  return RefreshIndicator(
    onRefresh: () async {
      final imoveisRepo =
          Provider.of<ImoveisRepositorio>(context, listen: false);

      await imoveisRepo.getImoveis(refresh: true);
    },
    child: Consumer<ImoveisRepositorio>(
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
          itemBuilder: (context, index) {
            if (index == repositorio.imoveis.length) {
              return Center(
                child: repositorio.carregando
                    ? const CircularProgressIndicator()
                    : const SizedBox.shrink(),
              );
            }

            final imovel = repositorio.imoveis[index];

            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DetalhesImoveis.rountName,
                  arguments: imovel,
                );
              },
              child: SizedBox(
                height: 280,
                child: Card(
                  margin: const EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          imovel.imagemDestaque,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      imovel.titulo,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: imovel.comodidades
                                          .map<Widget>((comodidade) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: Row(
                                            children: [
                                              Text(
                                                comodidade.qtd.toString(),
                                                style: GoogleFonts.robotoFlex(
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Icon(
                                                IconesImovel
                                                    .iconMap[comodidade.tipo],
                                                size: 18,
                                                semanticLabel: comodidade.tipo,
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    paraMoeda(imovel.valor),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    imovel.tipo,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color.fromARGB(255, 184, 182, 182),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ),
  );
}

String paraMoeda(double valor) {
  final formatador = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );
  return formatador.format(valor);
}

