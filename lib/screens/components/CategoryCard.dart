import 'package:flutter/material.dart';

import '../../components/Constants.dart';
import '../../models/Categoria.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.press,
    required this.categoria,
  }) : super(key: key);

  final VoidCallback press;
  final Categoria categoria;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 20 / 2, bottom: 20 * 2.5),
      width: size.width * 0.4,
      child: GestureDetector(
        onTap: press,
        child: Column(
          children: <Widget>[
            Image.network(
              categoria.imagenUrl,
              fit: BoxFit.cover,
            ),
            Container(
              padding: const EdgeInsets.all(20 / 2),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 10),
                        blurRadius: 50,
                        color: kprimaryColor.withOpacity(0.23))
                  ]),
              child: Center(
                child: Text(
                  categoria.nombre.toUpperCase(),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
