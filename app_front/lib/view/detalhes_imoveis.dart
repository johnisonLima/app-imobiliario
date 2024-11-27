import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import 'package:app_front/components/card_comentarios.dart';
import 'package:app_front/components/icones_imovel.dart';
import 'package:app_front/model/imoveis.dart';
import 'package:app_front/repository/comentarios_repositorio.dart';
import 'package:app_front/model/comentarios.dart';
import 'package:app_front/model/usuario.dart';
import 'package:app_front/usuarioManager.dart';

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
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _controladorNovoComentario.dispose();
  }

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

    final double alturaImagem = MediaQuery.of(context).size.height * 0.65;
    final double wrapImagem =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? alturaImagem
            : alturaImagem * 1.1;

    final estadoUsuario = context.watch<UsuarioManager>();
    final bool estaLogado = estadoUsuario.estaLogado;
    // final bool usuarioLogado = usuarioManager.usuario != null;

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
                    height: wrapImagem,
                    child: Stack(
                      children: [
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
                                  height: wrapImagem,
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        widget.imovel.imagens.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _slideSelecionado == index
                              ? 12
                              : 8, // Tamanho do ponto selecionado
                          height: 8,
                          decoration: BoxDecoration(
                            color: _slideSelecionado == index
                                ? Colors.blue
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
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
                                if(estaLogado)
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: _textFildCometario(
                                      _controladorNovoComentario,
                                      () => _enviarComentario(widget.imovel.id,
                                          estadoUsuario.usuario!),
                                    ),
                                  ),
                                  SizedBox(
                                    width: largura,
                                    height: 200,
                                    child: CardComentarios(
                                      imovelId: widget.imovel.id,
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
          if (_mostrarContato) _exibirContato(widget.imovel.titulo),
        ],
      ),
      
      endDrawer: Builder(
        builder: (context) => Drawer(
          child: Column(
            children: [
              estaLogado
                  ? UserAccountsDrawerHeader(
                      accountName: Text(estadoUsuario.usuario!.nome),
                      accountEmail: Text(estadoUsuario.usuario!.email),
                    )
                  : const UserAccountsDrawerHeader(
                      accountName: Text("Conecte-se"),
                      accountEmail: Text("Para ficar por dentro das novidades"),
                    ),
              estaLogado
                  ? ListTile(
                      leading: const Icon(Icons.logout_outlined),
                      title: const Text('Logout'),
                      onTap: () {
                        const snackBar = SnackBar(
                          content: Text('Você foi desconectado com sucesso!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        setState(() {
                          estadoUsuario.logoff();
                        });

                        Navigator.of(context).pop();
                      },
                    )
                  : ListTile(
                      leading: const Icon(Icons.logout_outlined),
                      title: const Text('Login'),
                      onTap: () {
                        Usuario usuario = Usuario(
                          id: 'R-pzP1f',
                          nome: 'Johnison',
                          email: 'johnisonbsi@outlook.com',
                        );

                        const snackBar = SnackBar(
                          content: Text('Você foi conectado com sucesso!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        setState(() {
                          estadoUsuario.login(usuario);
                        });

                        Navigator.of(context).pop();
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void _enviarComentario(String idImovel, Usuario usuario) async {
    String conteudo = _controladorNovoComentario.text.trim();

    final comentario = Comentarios(
      imovelId: int.parse(idImovel),
      texto: conteudo,
      data: DateTime.now().toIso8601String(),
      nota: 5,
      usuario: usuario,
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

Widget _exibirContato(String tituloImovel) {
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
            final msg =
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

String paraMoeda(double valor) {
  final formatador = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );
  return formatador.format(valor);
}
