class Usuario {
  final String? uid;
  final String nome;
  final String email;
  final String? criadoEm	;

  Usuario({
    required this.uid,
    required this.nome, 
    required this.email,
    this.criadoEm	,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      uid: json['uid'],
      nome: json['nome'],
      email: json['email'],
      criadoEm	: json['criadoEm	'],
    );
  }

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'nome': nome,
    'email': email,
    'criadoEm': criadoEm	,
  };
}