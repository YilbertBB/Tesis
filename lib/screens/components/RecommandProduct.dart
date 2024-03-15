import 'package:flutter/material.dart';
import 'package:untitled1/screens/pages%20en%20pruebas/ProductInfoPrueba.dart';
import '../../components/Size_Config.dart';
import '../../models/Producto.dart';
import '../../models/User.dart';
import '../pages/ProductInfo.dart';
import 'ProductCard.dart';

class RecommandProduct extends StatelessWidget {
  const RecommandProduct({
    super.key,
    required this.productos,
    required this.user,
  });

  final List<Producto> productos;
  final User user;

  @override
  Widget build(BuildContext context) {
    double? defaultsize = SizeConfig.defaultSize;
    return Padding(
      padding: EdgeInsets.all(defaultsize! * 2),
      child: GridView.builder(
        itemCount: productos.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              SizeConfig.orientation == Orientation.portrait ? 2 : 4,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 0.693,
        ),
        itemBuilder: (context, index) => ProductCard(
          producto: productos[index],
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    // ProductInfoPrueba(
                    //   producto: productos[index],
                    // ),
                    ProductInfo(
                  producto: productos[index],
                  user: user,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
