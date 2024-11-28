import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_front/repository/comentarios_repositorio.dart';
import 'package:app_front/usuarioManager.dart';

class CardComentarios extends StatefulWidget {
  final String imovelId;

  const CardComentarios({super.key, required this.imovelId});  

  @override
  State<CardComentarios> createState() => _CardComentariosState();
}

class _CardComentariosState extends State<CardComentarios> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final comentariosRepo = Provider.of<ComentariosRepositorio>(context, listen: false);
      comentariosRepo.getComentarios(id: widget.imovelId);
    });

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {    
    super.dispose();
    _scrollController.dispose();
  }

  void _onScroll() {
    final position = _scrollController.position.pixels;
    final maxScroll = _scrollController.position.maxScrollExtent;

    if (position >= maxScroll) {
      final comentariosRepo = Provider.of<ComentariosRepositorio>(context, listen: false);        
      
      comentariosRepo.carregarMaisComentarios(id: widget.imovelId);      
    }
  }  

  @override
  Widget build(BuildContext context) {

    return Consumer<ComentariosRepositorio>(
      builder: (context, repositorio, child) {
        if (repositorio.carregando && repositorio.comentarios.isEmpty) {
          return const SizedBox(
            width: 360,
            height: 220,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (!repositorio.carregando && repositorio.comentarios.isEmpty) {
          return const Center(
            child: Text(
              'Nenhum Comentário ainda',
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          controller: _scrollController,
          itemCount: repositorio.comentarios.length + 1,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            if (index == repositorio.comentarios.length) {
              return Center(
                child: repositorio.carregando
                    ? const CircularProgressIndicator()
                    : const SizedBox.shrink(),
              );
            }

            final comentarios = repositorio.comentarios[index];
            final DateTime dataComentario = DateTime.parse(comentarios.data);

            final estadoUsuario = context.watch<UsuarioManager>();

            bool usuarioLogadoComentou = estadoUsuario.estaLogado &&
              estadoUsuario.usuario!.email == comentarios.usuario.email;

            return Dismissible(
              key: Key(
                comentarios.id.toString(),
              ),
              direction: usuarioLogadoComentou 
                ? DismissDirection.endToStart
                : DismissDirection.none,
              background: Container(
                alignment: Alignment.centerRight,
                child: const Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: Icon(Icons.delete_outline_outlined, color: Colors.red, size: 40,),
                ),
              ),
              confirmDismiss: (direction) async {
                final bool? confirmar = await showDialog(
                  context: context,
                  builder: (BuildContext contexto) {
                    return AlertDialog(
                      title: const Text("Deseja apagar o comentário?"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(contexto).pop(false); 
                          },
                          child: const Text("Cancelar"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(contexto).pop(true);
                          },
                          child: const Text("Apagar"),
                        ),
                      ],
                    );
                  },
                );              
                return confirmar == true;
              },
              onDismissed: (direction) {              
                repositorio.apagarComentario(comentarios.id.toString());
              },
              child: Card(
                color: Colors.blue[500],
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comentarios.usuario.nome,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          formatarTempoAtras(dataComentario),
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.white60,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 5.0)),
                        Text(
                          '"${comentarios.texto}"',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

String formatarTempoAtras(DateTime data) {
  final DateTime agora = DateTime.now();
  final Duration diferenca = agora.difference(data);

  if (diferenca.inDays >= 365) {
    final anos = (diferenca.inDays / 365).floor();
    return anos == 1 ? '1 ano atrás' : '$anos anos atrás';
  } else if (diferenca.inDays >= 30) {
    final meses = (diferenca.inDays / 30).floor();
    return meses == 1 ? '1 mês atrás' : '$meses meses atrás';
  } else if (diferenca.inDays >= 1) {
    return diferenca.inDays == 1
        ? '1 dia atrás'
        : '${diferenca.inDays} dias atrás';
  } else if (diferenca.inHours >= 1) {
    return diferenca.inHours == 1
        ? '1 hora atrás'
        : '${diferenca.inHours} horas atrás';
  } else if (diferenca.inMinutes >= 1) {
    return diferenca.inMinutes == 1
        ? '1 minuto atrás'
        : '${diferenca.inMinutes} minutos atrás';
  } else {
    return 'Agora mesmo';
  }
}
