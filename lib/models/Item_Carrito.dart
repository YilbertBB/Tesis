import 'Carrito.dart';
import 'Producto.dart';

class ItemCarrito {
  int id;
  Producto producto;
  Carrito carrito;
  int cantidad;
  int cantidadProd;
  bool isSelected;

  ItemCarrito(
    this.id,
    this.producto,
    this.carrito,
    this.cantidad,
    this.cantidadProd,
    this.isSelected,
  );

  factory ItemCarrito.fromJson(Map<String, dynamic> json) {
    return ItemCarrito(
      json['id'],
      Producto.fromJson(json['producto']),
      Carrito.fromJson(json['carrito']),
      json['cantidad'],
      1,
      false,
    );
  }
}
