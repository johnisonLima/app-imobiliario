class Imovel {
  final String id;
  final String tipo;
  final String sobre;
  final double valor;
  final String titulo;
  final Cliente cliente;
  final Endereco endereco;
  final String operacao;
  final double areaTotal;
  final List<Comodidade> comodidades;
  final String dataLancamento;
  final String imagemDestaque;
  final String dataEncerramento;

  Imovel({
    required this.id,
    required this.tipo,
    required this.sobre,
    required this.valor,
    required this.titulo,
    required this.cliente,
    required this.endereco,
    required this.operacao,
    required this.areaTotal,
    required this.comodidades,
    required this.dataLancamento,
    required this.imagemDestaque,
    required this.dataEncerramento,
  });

  factory Imovel.fromJson(Map<String, dynamic> json) {
    return Imovel(
      id: json['id'],
      tipo: json['tipo'],
      sobre: json['sobre'],
      valor: json['valor'].toDouble(),
      titulo: json['titulo'],
      cliente: Cliente.fromJson(json['cliente']),
      endereco: Endereco.fromJson(json['endereco']),
      operacao: json['operacao'],
      areaTotal: json['areaTotal'].toDouble(),
      comodidades: (json['comodidades'] as List)
          .map((c) => Comodidade.fromJson(c))
          .toList(),
      dataLancamento: json['dataLancamento'],
      imagemDestaque: json['imagemDestaque'],
      dataEncerramento: json['dataEncerramamento'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'tipo': tipo,
    'sobre': sobre,
    'valor': valor,
    'titulo': titulo,
    'cliente': cliente.toJson(),
    'endereco': endereco.toJson(),
    'operacao': operacao,
    'areaTotal': areaTotal,
    'comodidades': comodidades.map((c) => c.toJson()).toList(),
    'dataLancamento': dataLancamento,
    'imagemDestaque': imagemDestaque,
    'dataEncerramento': dataEncerramento,
  };
}

class Cliente {
  final String nome;
  final String email;
  final String telefone;
  final String sobrenome;

  Cliente({
    required this.nome,
    required this.email,
    required this.telefone,
    required this.sobrenome,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      nome: json['nome'],
      email: json['email'],
      telefone: json['telefone'],
      sobrenome: json['Sobrenome'],
    );
  }

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'email': email,
    'telefone': telefone,
    'Sobrenome': sobrenome,
  };
}

class Endereco {
  final String bairro;
  final String cidade;
  final String estado;
  final Location location;
  final String logradouro;

  Endereco({
    required this.bairro,
    required this.cidade,
    required this.estado,
    required this.location,
    required this.logradouro,
  });

  factory Endereco.fromJson(Map<String, dynamic> json) {
    return Endereco(
      bairro: json['bairro'],
      cidade: json['cidade'],
      estado: json['estado'],
      location: Location.fromJson(json['location']),
      logradouro: json['logradouro'],
    );
  }

  Map<String, dynamic> toJson() => {
    'bairro': bairro,
    'cidade': cidade,
    'estado': estado,
    'location': location.toJson(),
    'logradouro': logradouro,
  };
}

class Location {
  final double lat;
  final double long;

  Location({
    required this.lat,
    required this.long,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json['lat'].toDouble(),
      long: json['long'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    'lat': lat,
    'long': long,
  };
}

class Comodidade {
  final int qtd;
  final String tipo;

  Comodidade({
    required this.qtd,
    required this.tipo,
  });

  factory Comodidade.fromJson(Map<String, dynamic> json) {
    return Comodidade(
      qtd: json['qtd'],
      tipo: json['tipo'],
    );
  }

  Map<String, dynamic> toJson() => {
    'qtd': qtd,
    'tipo': tipo,
  };
}