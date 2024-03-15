class User {
  int? id;
  String? token;
  String? username, first_name, last_name, direccion, email, telefono;
  // imagenUrl;

  User({
    this.id,
    this.first_name,
    this.last_name,
    this.direccion,
    this.email,
    this.telefono,
    this.username,
    // this.imagenUrl,
  });

  factory User.fromJson(json) {
    return User(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      email: json['email'],
      telefono: json['telefono'],
      direccion: json['direccion'],
      username: json['username'],
      // imagenUrl: json['imagenU']
    );
  }
}
