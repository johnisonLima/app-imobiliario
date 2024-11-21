import 'package:app_front/components/icones_imovel.dart';
import 'package:app_front/model/imoveis.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DetalhesImoveis extends StatefulWidget {
  static const rountName = '/DetalhesImoveis';

  const DetalhesImoveis({super.key});

  @override
  State<DetalhesImoveis> createState() => _DetalhesImoveisState();
}

class _DetalhesImoveisState extends State<DetalhesImoveis> {
  late PageController _controladorSlides;
  late int _slideSelecionado;
  late ScrollController _scrollController;
  bool _mostrarBotoes = false;
  late int alturaBotoes = 100;

  @override
  void initState() {
    super.initState();
    _iniciarSlides();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _iniciarSlides() {
    _slideSelecionado = 0;
    _controladorSlides = PageController(initialPage: _slideSelecionado);
  }

  void _onScroll() {
    if (_scrollController.offset > alturaBotoes && !_mostrarBotoes) {
      setState(() {
        _mostrarBotoes = true;
      });
    } else if (_scrollController.offset <= alturaBotoes && _mostrarBotoes) {
      setState(() {
        _mostrarBotoes = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double alturaImagem = 500;
    final args = ModalRoute.of(context)?.settings.arguments;
    var msg;

    if (args is! Imovel) {
      return Scaffold(
        appBar: AppBar(title: const Text('Erro')),
        body: const Center(
          child: Text('Argumentos inválidos ou ausentes.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? alturaImagem
                        : alturaImagem / 1.8,
                    child: Stack(children: [
                      PageView.builder(
                        itemCount: args.imagens.length,
                        controller: _controladorSlides,
                        onPageChanged: (slide) {
                          setState(() {
                            _slideSelecionado = slide;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Stack(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                args.imagens[index].url,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? alturaImagem
                                    : alturaImagem / 1.8,
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    args.titulo,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
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
                                  Text(
                                    args.endereco.bairro,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 5.0,
                                          color: Colors.black45,
                                          offset: Offset(2, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(54, 158, 158, 158),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: const Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ]);
                        },
                      ),
                    ]),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          args.tipo,
                          style: GoogleFonts.robotoFlex(
                            fontSize: 17,
                            fontWeight: FontWeight.w100,
                            color: Colors.grey[800],
                          ),
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.8,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.share_outlined,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          args.operacao,
                          style: GoogleFonts.robotoFlex(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    height: 1,
                    color: Colors.grey[600],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          paraMoeda(args.valor),
                          style: GoogleFonts.robotoFlex(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    height: 1,
                    color: Colors.grey[600],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 10),
                    child: Row(
                      children: args.comodidades.map<Widget>((comodidade) {
                        return Row(
                          children: [
                            Text(
                              comodidade.qtd.toString(),
                              style: GoogleFonts.robotoFlex(
                                fontSize: 18,
                              ),
                            ),
                            Icon(
                              IconesImovel.iconMap[comodidade.tipo],
                              size: 19,
                              semanticLabel: comodidade.tipo,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 8),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    height: 1,
                    color: Colors.grey[600],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 10, right: 10, bottom: 50),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        args.sobre,
                        style: GoogleFonts.robotoFlex(
                          fontSize: 15,
                          fontWeight: FontWeight.w100,
                          color: Colors.grey[500],
                        ),
                        textAlign: TextAlign.justify,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_mostrarBotoes)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      const phone = '5577999285012';
                      const whats =
                          'https://api.whatsapp.com/send/?phone=$phone';
                      msg = 'Olá, estou interessado no imóvel ${args.titulo}. Gostaria de obter mais informações sobre ele.';

                      final Uri url = Uri.parse('$whats&text=${Uri.encodeComponent(msg)}');

                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        throw 'Não foi possível abrir o WhatsApp.';
                      }
                    },
                    icon: const Icon(Icons.whatsa),
                    label: const Text('Whatsapp'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final Uri emailUri = Uri(
                        scheme: 'mailto',
                        path: 'johnisonbsi@outlook.com',
                        queryParameters: {
                          'subject': 'Interesse no imóvel: ${args.titulo}',
                          'body': 'Olá,\n\nEstou interessado no imóvel ${args.titulo}. Gostaria de obter mais informações sobre ele.',
                        },
                      );

                      if (await canLaunchUrl(emailUri)) {
                        await launchUrl(emailUri);
                      } else {
                        throw 'Não foi possível abrir o cliente de e-mail.';
                      }
                    },
                    icon: const Icon(Icons.email),
                    label: const Text('Email'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

String paraMoeda(double valor) {
  final formatador = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );
  return formatador.format(valor);
}
