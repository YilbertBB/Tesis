import 'package:flutter/material.dart';

import '../../models/Categoria.dart';
import '../../models/User.dart';
import '../pages/List_Product_x_Category.dart';
import 'CategoryCard.dart';

class ListCategorias extends StatelessWidget {
  const ListCategorias({
    super.key,
    required this.categorias,
    required this.user,
  });

  final List<Categoria> categorias;
  final User user;

  @override
  Widget build(BuildContext context) {
    final categoriaTodos =
        categorias.indexWhere((element) => element.nombre == 'Todos');
    if (categoriaTodos != -1) {
      final category = categorias.removeAt(categoriaTodos);
      categorias.insert(0, category);
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          categorias.length,
          (index) => CategoryCard(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => List_Products_x_Categoria(
                    user: user,
                    categoria: categorias[index],
                  ),
                ),
              );
            },
            categoria: categorias[index],
          ),
        ),
      ),
    );
  }
}
