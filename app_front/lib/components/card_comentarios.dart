import 'package:app_front/repository/comentarios_repositorio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardComentarios extends StatelessWidget {
  final String imovelId;

  const CardComentarios({super.key, required this.imovelId});

  @override
  Widget build(BuildContext context) {
    final comentariosRepo =
        Provider.of<ComentariosRepositorio>(context, listen: false);
    final scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        comentariosRepo.carregarMaisComentarios(id: imovelId);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      comentariosRepo.getComentarios(id: imovelId);
    });

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
        controller: scrollController,
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

          return Dismissible(
            key: Key(
              comentarios.id.toString(),
            ),
            direction: 1 % 2 != 0 // Mudar quando implementar usuario
                ? DismissDirection.endToStart
                : DismissDirection.none,
            background: Container(
              alignment: Alignment.centerRight,
              child: const Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: Icon(Icons.delete, color: Colors.red),
              ),
            ),
            confirmDismiss: (direction) async {
    // Exibe o diálogo para confirmar
    final bool? confirmar = await showDialog(
      context: context,
      builder: (BuildContext contexto) {
        return AlertDialog(
          title: const Text("Deseja apagar o comentário?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(contexto).pop(false); // Retorna "false" para cancelar
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(contexto).pop(true); // Retorna "true" para confirmar
              },
              child: const Text("Apagar"),
            ),
          ],
        );
      },
    );

    // Retorna o valor da decisão para o Dismissible
    return confirmar == true;
  },
  onDismissed: (direction) {
    // Realiza a ação de apagar o comentário
    repositorio.apagarComentario(comentarios.id.toString());
  },
            child: Card(
              color: Colors.blue[500],
              child: Padding(
                padding: const EdgeInsets.all(15.0),
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
          );
        },
      );
    });
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
