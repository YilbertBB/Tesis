class Categoria {
  int id;
  String nombre;
  String imagenUrl;

  Categoria(
    this.id,
    this.nombre,
    this.imagenUrl,
  );

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      json['id'],
      json['nombre'],
      json['imagenC'],
    );
  }
}
