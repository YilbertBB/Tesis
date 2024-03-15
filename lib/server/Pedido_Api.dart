import 'dart:convert';
import 'package:http/http.dart' as http;

import '../components/Constants.dart';
import '../models/Pedido.dart';
import '../models/User.dart';

var productoEndpoint = Uri.parse('$baseUrl/producto');

// Mostrar Todos los Productos
Future<List<Pedido>> getPedido(User user) async {
  var uri = Uri.parse('$productoEndpoint/getPedido/');

  var res = await http.get(uri, headers: {
    'Authorization': 'Token ${user.token}',
  });

  if (res.statusCode == 200) {
    List<Pedido> productos = (json.decode(res.body) as List)
        .map((data) => Pedido.fromJson(data))
        .toList();
    return productos;
  } else {
    throw Exception('Fallo al cargar');
  }
}
