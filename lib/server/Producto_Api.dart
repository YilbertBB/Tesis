import 'dart:convert';

import 'package:http/http.dart' as http;

import '../components/Constants.dart';
import '../models/Categoria.dart';
import '../models/Producto.dart';
import '../models/User.dart';

var productoEndpoint = Uri.parse('$baseUrl/producto');

// Mostrar Todos los Productos
Future<List<Producto>> geListOfProducto(User user) async {
  var uri = Uri.parse('$productoEndpoint/getListOfProducto/');

  var res = await http.get(uri, headers: {
    'Authorization': 'Token ${user.token}',
  });

  if (res.statusCode == 200) {
    List<Producto> productos = (json.decode(res.body) as List)
        .map((data) => Producto.fromJson(data))
        .toList();

    for (var producto in productos) {
      producto.nombre = utf8.decode(producto.nombre.codeUnits);
      producto.descripcion = utf8.decode(producto.descripcion.codeUnits);
    }

    return productos;
  } else {
    throw Exception('Fallo al cargar');
  }
}

// Mostrar Todos los Productos
Future<List<Producto>> geListOfProductoRecomendados(User user) async {
  var uri = Uri.parse('$productoEndpoint/getListOfProductoRecomendados/');

  var res = await http.get(uri, headers: {
    'Authorization': 'Token ${user.token}',
  });

  if (res.statusCode == 200) {
    List<Producto> productos = (json.decode(res.body) as List)
        .map((data) => Producto.fromJson(data))
        .toList();

    for (var producto in productos) {
      producto.nombre = utf8.decode(producto.nombre.codeUnits);
      producto.descripcion = utf8.decode(producto.descripcion.codeUnits);
    }

    return productos;
  } else {
    throw Exception('Fallo al cargar');
  }
}

// Mostrar Todos los Productos por Categorias
Future<List<Producto>> geListOfProducto_x_Categoria(
    User user, Categoria categoria) async {
  var uri = Uri.parse(
      '$productoEndpoint/geListOfProducto_x_Categoria/${categoria.id}/');

  var res = await http.get(uri, headers: {
    'Authorization': 'Token ${user.token}',
  });

  if (res.statusCode == 200) {
    List<Producto> productos = (json.decode(res.body) as List)
        .map((data) => Producto.fromJson(data))
        .toList();

    for (var producto in productos) {
      producto.nombre = utf8.decode(producto.nombre.codeUnits);
      producto.descripcion = utf8.decode(producto.descripcion.codeUnits);
    }

    return productos;
  } else {
    throw Exception('Fallo al cargar');
  }
}

// Buscar un Producto
Future<List<Producto>> buscarProducto(User user, String productonombre) async {
  var uri = Uri.parse('$productoEndpoint/buscarProducto/$productonombre/');

  var res = await http.get(uri, headers: {
    'Authorization': 'Token ${user.token}',
  });

  if (res.statusCode == 200) {
    List<Producto> productos = (json.decode(res.body) as List)
        .map((data) => Producto.fromJson(data))
        .toList();

    for (var producto in productos) {
      producto.nombre = utf8.decode(producto.nombre.codeUnits);
      producto.descripcion = utf8.decode(producto.descripcion.codeUnits);
    }

    return productos;
  } else {
    throw Exception('Fallo al cargar');
  }
}
