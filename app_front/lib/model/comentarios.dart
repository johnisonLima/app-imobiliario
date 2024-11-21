class Comentarios {
  final String id;
  final int imovelId;
  final String texto;
  final String data;
  final int nota;
  final Usuario usuario;

  Comentarios({
    required this.id,
    required this.imovelId,
    required this.texto,
    required this.data,
    required this.nota,
    required this.usuario
  });

  factory Comentarios.fromJson(Map<String, dynamic> json) {
    return Comentarios(
      id: json['id'],
      imovelId: json['imovelId'],
      texto: json['texto'],
      data: json['data'],
      nota: json['nota'],
      usuario: Usuario.fromJson(json['usuario']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'imovelId': imovelId,
    'texto': texto,
    'data': data,
    'nota': nota,
    'usuario': usuario.toJson(),
  };
}

class Usuario {
  final String id;
  final String nome;
  final String email;

  Usuario({required this.id, required this.nome, required this.email});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nome': nome,
    'email': email,
  };
}
