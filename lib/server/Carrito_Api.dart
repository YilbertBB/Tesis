import 'dart:convert';

import 'package:http/http.dart' as http;

import '../components/Constants.dart';
import '../models/Carrito.dart';
import '../models/Producto.dart';
import '../models/User.dart';

var productoEndpoint = Uri.parse('$baseUrl/producto');

// Agregar un Producto al Carrito
Future<bool> createCarrito(User user, Producto producto) async {
  var uri = Uri.parse('$productoEndpoint/createCarrito/');
  Map data = {
    'cliente': '${user.id}',
    'producto': '${producto.id}',
  };
  var res = await http.post(uri, body: data, headers: {
    'Authorization': 'Token ${user.token}',
  });
  if (res.statusCode == 200 || res.statusCode == 201) {
    return true;
  } else {
    return false;
  }
}

// Mostrar Todos los Productos del Carrito
Future<Producto> getListCarrito(User user, int idC) async {
  var uri = Uri.parse('$productoEndpoint/getListCarrito/$idC/');

  var res = await http.get(uri, headers: {
    'Authorization': 'Token ${user.token}',
  });
  if (res.statusCode == 200) {
    Producto carrito =
        (json.decode(res.body)).map((data) => Producto.fromJson(data)).toList();
    return carrito;
  } else {
    throw Exception('Fallo al cargar');
  }
}

// Eliminar un Producto del Carrito
Future<bool> deleteCarrito(User user, Producto producto, int id) async {
  var uri = Uri.parse('$productoEndpoint/deleteCarrito/$id/');
  var res = await http.delete(uri, headers: {
    'Authorization': 'Token ${user.token}',
  });
  if (res.statusCode == 200 || res.statusCode == 204) {
    return true;
  } else {
    return false;
  }
}

// Buscar Producto en Carrito
Future<List<Carrito>> buscarProductoCarrito(User user) async {
  var uri = Uri.parse('$productoEndpoint/buscarProductoCarrito/');

  var res = await http.get(uri, headers: {
    'Authorization': 'Token ${user.token}',
  });

  if (res.statusCode == 200) {
    List<Carrito> productos = (json.decode(res.body) as List)
        .map((data) => Carrito.fromJson(data))
        .toList();
    return productos;
  } else {
    throw Exception('Fallo al cargar');
  }
}
