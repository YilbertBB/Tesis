import 'package:untitled1/models/Item_Carrito.dart';

import 'Producto.dart';
import 'User.dart';

class Carrito {
  int id;
  User cliente;
  List<ItemCarrito> productos;
 

  Carrito(
    this.id,
    this.cliente,
    this.productos,
    
  );

  factory Carrito.fromJson(Map json) {
    return Carrito(
      json['id'],
      User.fromJson(json['cliente']),
        (json['productos'] as List<dynamic>)
          .map((item) => ItemCarrito.fromJson(item))
          .toList(),
     
    );
  }
}

// import 'ItemCarrito.dart';
// import 'User.dart';

// class Carrito {
//   int id;
//   User cliente;
//   List<ItemCarrito> productos;

//   Carrito(
//     this.id,
//     this.cliente,
//     this.productos,
//   );

//   factory Carrito.fromJson(Map<String, dynamic> json) {
//     return Carrito(
//       json['id'],
//       User.fromJson(json['cliente']),
//       (json['productos'] as List<dynamic>)
//           .map((item) => ItemCarrito.fromJson(item))
//           .toList(),
//     );
//   }
// }


