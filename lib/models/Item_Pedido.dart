
import 'Producto.dart';

class ItemPedido {
  int id;
  Producto producto;
  int cantidad;

  ItemPedido(
    this.id,
    this.producto,
    this.cantidad,
  );

  factory ItemPedido.fromJson(Map<String, dynamic> json) {
    return ItemPedido(
      json['id'],
      Producto.fromJson(json['producto']),
      json['cantidad'],
    );
  }
}
