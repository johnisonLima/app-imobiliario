import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import 'package:app_front/components/card_comentarios.dart';
import 'package:app_front/components/icones_imovel.dart';
import 'package:app_front/model/imoveis.dart';
import 'package:app_front/repository/comentarios_repositorio.dart';

import '../model/comentarios.dart';

class DetalhesImoveis extends StatefulWidget {
  static const rountName = '/DetalhesImoveis';
  final Imovel imovel;

  const DetalhesImoveis({super.key, required this.imovel});

  @override
  State<DetalhesImoveis> createState() => _DetalhesImoveisState();
}

class _DetalhesImoveisState extends State<DetalhesImoveis> {
  late PageController _controladorSlides;
  late int _slideSelecionado;
  late ScrollController _scrollController;
  bool _mostrarContato = false;
  late int alturaBotoes = 100;
  late TextEditingController _controladorNovoComentario;

  @override
  void initState() {
    super.initState();
    _iniciarSlides();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _controladorNovoComentario = TextEditingController();
    
    // _controladorNovoComentario.addListener(_onCommentChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    // _controladorNovoComentario.removeListener(_onCommentChanged);
    _controladorNovoComentario.dispose();
  }

  // void _onCommentChanged() {
  //   print('Comment changed: ${_controladorNovoComentario.text}');
  // }

  void _iniciarSlides() {
    _slideSelecionado = 0;
    _controladorSlides = PageController(initialPage: _slideSelecionado);
  }

  void _onScroll() {
    if (_scrollController.offset > alturaBotoes && !_mostrarContato) {
      setState(() {
        _mostrarContato = true;
      });
    } else if (_scrollController.offset <= alturaBotoes && _mostrarContato) {
      setState(() {
        _mostrarContato = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width *
        (MediaQuery.of(context).orientation == Orientation.portrait
            ? 0.92
            : 0.95);
    const double alturaImagem = 500;
    var mensagem = '';

    if (widget.imovel is! Imovel) {
      _erroArgumentos();
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
                        itemCount: widget.imovel.imagens.length,
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
                                widget.imovel.imagens[index].url,
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
                                    widget.imovel.titulo,
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
                                    widget.imovel.endereco.bairro,
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
                          widget.imovel.tipo,
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
                          widget.imovel.operacao,
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
                          paraMoeda(widget.imovel.valor),
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
                      children:
                          widget.imovel.comodidades.map<Widget>((comodidade) {
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
                        top: 20, left: 10, right: 10, bottom: 20),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        widget.imovel.sobre,
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
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 70.0, left: 10, right: 10),
                    child: Column(
                      children: [
                        const Text(
                          'Comentários',
                          style: TextStyle(fontSize: 20),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                        ),
                        const Divider(
                          color: Colors.grey,
                          height: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ChangeNotifierProvider(
                            create: (_) => ComentariosRepositorio(),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: _textFildCometario(
                                    _controladorNovoComentario,
                                    _enviarComentario,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: SizedBox(
                                    width: largura,
                                    height: 200,
                                    child: CardComentarios(
                                        imovelId: widget.imovel.id),
                                         
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_mostrarContato) _exibirContato(widget.imovel.titulo, mensagem),
        ],
      ),
    );
  }

  void _enviarComentario() async {
    String conteudo = _controladorNovoComentario.text.trim();

    final comentario = Comentarios(
      imovelId: 1,
      texto: conteudo,
      data: DateTime.now().toIso8601String(),
      nota: 5,
      usuario: Usuario(
        id: "1",
        nome: "usuarioNome",
        email: "usuarioEmail",
      ),
    );

    try {
      final comentariosRepo =
          Provider.of<ComentariosRepositorio>(context, listen: false);

      await comentariosRepo.adicionarComentario(novoComentario: comentario);

      _controladorNovoComentario.clear();

      // await comentariosRepo.getComentarios(id: widget.imovel.id);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Comentário enviado com sucesso')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao enviar comentário')),
      );
      print('Erro ao enviar comentário: $e');
    }
  }
}

Widget _exibirContato(String tituloImovel, String msg) {
  return Positioned(
    bottom: 16,
    left: 16,
    right: 16,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            const phone = '5577999285012';
            const whats = 'https://api.whatsapp.com/send/?phone=$phone';
            msg =
                'Olá, estou interessado no imóvel $tituloImovel. Gostaria de obter mais informações sobre ele.';

            final Uri url =
                Uri.parse('$whats&text=${Uri.encodeComponent(msg)}');

            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            } else {
              throw 'Não foi possível abrir o WhatsApp.';
            }
          },
          icon: const Icon(Icons.phone),
          label: const Text('Whatsapp'),
        ),
        ElevatedButton.icon(
          onPressed: () async {
            final Uri emailUri = Uri(
              scheme: 'mailto',
              path: 'johnisonbsi@outlook.com',
              queryParameters: {
                'subject': 'Interesse no imóvel: $tituloImovel',
                'body':
                    'Olá,\n\nEstou interessado no imóvel $tituloImovel. Gostaria de obter mais informações sobre ele.',
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
  );
}

Widget _textFildCometario(controladorNovoComentario, enviarComentario) {
  return TextField(
    maxLines: 5,
    minLines: 1,
    maxLength: 250,
    controller: controladorNovoComentario,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.blue,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      hintText: 'Escreva seu comentário aqui...',
      hintStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 14.0,
      ),
      labelText: 'Adicionar comentário',
      labelStyle: const TextStyle(
        color: Colors.blueGrey,
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 16.0,
      ),
      suffixIcon: IconButton(
        icon: const Icon(Icons.send),
        color: Colors.blue,
        onPressed: () {
          enviarComentario();
          controladorNovoComentario.clear();
        },
      ),
    ),
    style: const TextStyle(
      fontSize: 16.0,
      color: Colors.black,
    ),
    textInputAction: TextInputAction.newline,
  );
}

Widget _erroArgumentos() {
  return Scaffold(
    appBar: AppBar(title: const Text('Erro')),
    body: const Center(
      child: Text('Argumentos inválidos ou ausentes.'),
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
