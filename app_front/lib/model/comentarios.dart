import 'package:lh_imoveis/model/usuarios.dart';

class Comentarios {
  final String? id;
  final String imovelId;
  final String texto;
  final String? data;
  final int nota;
  final Usuario usuario;

  Comentarios(
      {this.id,
      required this.imovelId,
      required this.texto,
      this.data,
      required this.nota,
      required this.usuario});

  factory Comentarios.fromJson(Map<String, dynamic> json) {
    return Comentarios(
      id: json['_id'],
      imovelId: json['imovelId'],
      texto: json['texto'],
      data: json['data'],
      nota: json['nota'],
      usuario: Usuario.fromJson(json['usuario']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'imovelId': imovelId,
        'texto': texto,
        'data': data,
        'nota': nota,
        'usuario': usuario.toJson(),
      };
}
