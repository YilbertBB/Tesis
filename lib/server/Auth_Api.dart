import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

import '../components/Constants.dart';
import '../models/User.dart';

// Inicio de Login
Future<dynamic> userAuth(String email, String password) async {
  Map dataU = {
    "email": email,
    "password": password,
  };
  var url = Uri.parse('$baseUrl/user/auth/login/');

  var res = await http.post(url, body: dataU);

  if (res.statusCode == 200) {
    Map json = jsonDecode(res.body);

    String token = json['key'];
    var box = await Hive.openBox(tokenBox);
    box.put('token', token);
    User? user = await getUser(token);
    return user;
  } else {
    Map json = jsonDecode(res.body);
    if (json.containsKey('email')) {
      return 'El correo electrónico ingresado no es válido';
    }
    if (json.containsKey('password')) {
      return 'Los campos no pueden estar vacíos';
    }
    if (json.containsKey('password2')) {
      return 'Los campos no pueden estar vacíos';
    }
    if (json.containsKey('non_field_errors')) {
      return 'Ocurrió un error al iniciar sesión, verifique sus datos';
    }
  }
}
// Fin de Login


// Inicio de Register
Future<dynamic> registerUser(
  String email,
  String password1,
  String password2,
  String firstName,
  String lastName,
  String direccion,
  String telefono,
) async {
  Map<String, dynamic> data = {
    'email': email,
    'password1': password1,
    'password2': password2,
    'first_name': firstName,
    'last_name': lastName,
    'direccion': direccion,
    'telefono': telefono,
  };
  var url = Uri.parse('$baseUrl/user/auth/registration/');
  var res = await http.post(url, body: data);
  if (res.statusCode == 200 || res.statusCode == 201) {
    Map json = jsonDecode(res.body);
    if (json.containsKey('key')) {
      String token = json['key'];
      var box = await Hive.openBox(tokenBox);
      box.put('token', token);
      var a = await getUser(token);
      if (a != null) {
        User user = a;
        return user;
      } else {
        return null;
      }
    }
  } else if (res.statusCode == 400) {
    Map json = jsonDecode(res.body);
    if (json.containsKey('email')) {
      return 'El correo electrónico ingresado no es válido.';
    }
    if (json.containsKey('password1')) {
      return 'Esta contraseña es muy corta. Debe contener al menos 8 caracteres.';
    }
    if (json.containsKey('non_field_errors')) {
      return 'Las contraseñas no son iguales o es similar al email.';
    }
  } else {
    return null;
  }
}
// Fin de Register



Future<User?> getUser(String token) async {
  var url = Uri.parse('$baseUrl/user/auth/user/');
  var res = await http.get(url, headers: {
    'Authorization': 'Token $token',
  });

  if (res.statusCode == 200) {
    var json = jsonDecode(res.body);

    User user = User.fromJson(json);
    user.token = token;
    return user;
  } else {
    return null;
  }
}

Future<dynamic> actualizarUser(
  String email,
  String firstName,
  String lastName,
  String direccion,
  String telefono,
) async {
  Map<String, dynamic> data = {
    'email': email,
    'first_name': firstName,
    'last_name': lastName,
    'direccion': direccion,
    'telefono': telefono,
  };
  var url = Uri.parse('$baseUrl/user/auth/user/');
  var res = await http.put(url, body: data);
  if (res.statusCode == 200 || res.statusCode == 201) {
    Map json = jsonDecode(res.body);
    if (json.containsKey('key')) {
      String token = json['key'];
      var box = await Hive.openBox(tokenBox);
      box.put('token', token);
      var a = await getUser(token);
      if (a != null) {
        User user = a;
        return user;
      } else {
        return null;
      }
    }
  } else if (res.statusCode == 400) {
    Map json = jsonDecode(res.body);
    if (json.containsKey('email')) {
      return 'El correo electrónico ingresado no es válido.';
    }
    if (json.containsKey('password1')) {
      return 'Esta contraseña es muy corta. Debe contener al menos 8 caracteres.';
    }
    if (json.containsKey('non_field_errors')) {
      return 'Las contraseñas no son iguales o es similar al email.';
    }
  } else {
    return null;
  }
}

Future<User?> logOut(String token) async {
  var url = Uri.parse('$baseUrl/user/auth/logout/');
  var res = await http.post(url, headers: {
    'Authorization': 'Token $token',
  });

  if (res.statusCode == 200 || res.statusCode == 201) {
    return null;
  }
  return null;
}
