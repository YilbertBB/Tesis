// oficial

import 'package:flutter/material.dart';
import '../../components/Constants.dart';
import '../../components/Size_Config.dart';
import '../../models/Producto.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.press,
    required this.producto,
  }) : super(key: key);

  final Producto producto;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    double? defaultsize = SizeConfig.defaultSize;

    return Container(
      margin: EdgeInsets.only(
        left: defaultsize!,
        top: defaultsize / 2,
        bottom: defaultsize * 2.5,
      ),
      child: GestureDetector(
        onTap: press,
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Hero(
                tag: producto.imagenUrl,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(producto.imagenUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  alignment: Alignment.topRight,
                  child: Container(
                    color: Colors.transparent,
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.shopping_cart_rounded,
                        // : Icons.shopping_cart_outlined,
                        color: kprimaryColor,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(defaultsize / 2),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(producto.nombre.toUpperCase(),
                      style: Theme.of(context).textTheme.labelLarge),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Disponibles:  ${producto.cantidadDisponible}',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        "\$${producto.precio}",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: kprimaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:untitled1/server/Carrito_Api.dart';
// import '../../components/Constants.dart';
// import '../../components/Size_Config.dart';
// import '../../models/Producto.dart';
// import '../../models/User.dart';
// import '../../models/User_Cubit.dart';

// class ProductCard extends StatelessWidget {
//   const ProductCard({
//     Key? key,
//     required this.press,
//     required this.producto,
//   }) : super(key: key);

//   final Producto producto;
//   final VoidCallback press;

//   @override
//   Widget build(BuildContext context) {
//     double? defaultsize = SizeConfig.defaultSize;
//     User user = context.read<UserCubit>().state;

//     return FutureBuilder(
//       future: getListCarrito(user),
//       builder: (context, snapshot) {
//         return snapshot.hasData
//             ? Container(
//                 margin: EdgeInsets.only(
//                   left: defaultsize!,
//                   top: defaultsize / 2,
//                   bottom: defaultsize * 2.5,
//                 ),
//                 child: GestureDetector(
//                   onTap: press,
//                   child: Column(
//                     children: <Widget>[
//                       ClipRRect(
//                         borderRadius: const BorderRadius.only(
//                             topLeft: Radius.circular(10),
//                             topRight: Radius.circular(10)),
//                         child: Hero(
//                           tag: producto.imagenUrl,
//                           child: Container(
//                             width: double.infinity,
//                             height: 200,
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                 image: NetworkImage(producto.imagenUrl),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             alignment: Alignment.topRight,
//                             child: Container(
//                               color: Colors.transparent,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(5.0),
//                                 child: Icon(
//                                   snapshot.data!.contains(producto)
//                                       ? Icons.shopping_cart_rounded
//                                       : Icons.shopping_cart_outlined,
//                                   color: kprimaryColor,
//                                   size: 25,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: double.infinity,
//                         padding: EdgeInsets.all(defaultsize / 2),
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: const BorderRadius.only(
//                                 bottomLeft: Radius.circular(10),
//                                 bottomRight: Radius.circular(10)),
//                             boxShadow: [
//                               BoxShadow(
//                                   offset: const Offset(0, 10),
//                                   blurRadius: 50,
//                                   color: kprimaryColor.withOpacity(0.23))
//                             ]),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Text(producto.nombre.toUpperCase(),
//                                 style: Theme.of(context).textTheme.labelLarge),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Disponibles:  ${producto.cantidadDisponible}',
//                                   style: Theme.of(context).textTheme.labelLarge,
//                                 ),
//                                 Text(
//                                   "\$${producto.precio}",
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .labelLarge!
//                                       .copyWith(color: kprimaryColor),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             : const Text('error');
//       },
//     );
//   }
// }
