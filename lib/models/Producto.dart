import 'Categoria.dart';

class Producto {
  int id;
  Categoria categoria;
  String nombre;
  String descripcion;
  double precio;
  String imagenUrl;
  String modelo3dUrl;
  int cantidadDisponible;
  bool recomendados;
  int cantidad;

  Producto(
    this.id,
    this.categoria,
    this.nombre,
    this.descripcion,
    this.precio,
    this.imagenUrl,
    this.modelo3dUrl,
    this.cantidadDisponible,
    this.recomendados,
    this.cantidad,
  );

  factory Producto.fromJson(Map json) {
    return Producto(
      json['id'],
      Categoria.fromJson(json['categoria']),
      json['nombre'],
      json['descripcion'],
      json['precio'],
      json['imagenP'],
      json['modelo_3d'],
      json['cantidad_disponible'],
      json['recomendados'],
      1,
    );
  }
}
