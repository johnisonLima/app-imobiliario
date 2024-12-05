class BaseRepositorio {
  final String BASE_API;
  static const String IP = 'seu_ip_aqui';

  BaseRepositorio() : BASE_API = 'http://$IP:8080/';
}
