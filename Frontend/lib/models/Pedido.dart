import 'Producto.dart';
import 'User.dart';

class Pedido {
  User cliente;
  List<Producto> productos;
  String direccionEnvio;
  DateTime fechaPedido;
  bool completado;

  Pedido(
    this.cliente,
    this.productos,
    this.direccionEnvio,
    this.fechaPedido,
    this.completado,
  );

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
      User.fromJson(json['cliente']),
      (json['productos'] as List<dynamic>)
          .map((item) => Producto.fromJson(item))
          .toList(),
      json['direccion_envio'],
      DateTime.parse(json['fecha_pedido']),
      json['completado'],
    );
  }
}
