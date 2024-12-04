class BaseRepositorio {
  final String BASE_API;
  static const String IP = '192.168.0.129';

  BaseRepositorio() : BASE_API = 'http://$IP:8080/';
}
