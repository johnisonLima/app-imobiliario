class Like {
  final String? id;
  final String imovelId;
  final String usuarioId;
  final String? data;

  Like({
    this.id,
    required this.imovelId,
    required this.usuarioId,
    this.data,
  });

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      id: json['_id'],
      imovelId: json['imovelId'],
      usuarioId: json['usuarioId'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'imovelId': imovelId,
    'usuarioId': usuarioId,
    'data': data,
  };
}
