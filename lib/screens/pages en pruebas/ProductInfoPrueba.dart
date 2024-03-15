// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:untitled1/components/Constants.dart';

// import '../../models/Producto.dart';

// class ProductInfoPrueba extends StatelessWidget {
//   const ProductInfoPrueba({super.key, required this.producto});
//   final Producto producto;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xfff3f6fd),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Icon(
//                       Ionicons.chevron_back,
//                       size: 30,
//                     ),
//                   ),
//                   const Text(
//                     'Product',
//                     style: TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black54,
//                     ),
//                   ),
//                   Neumorphic(
//                     style: NeumorphicStyle(
//                       shape: NeumorphicShape.concave,
//                       boxShape: NeumorphicBoxShape.roundRect(
//                         BorderRadius.circular(12),
//                       ),
//                       color: const Color(0xfff3f6fd),
//                       intensity: 1,
//                     ),
//                     child: const Padding(
//                       padding: EdgeInsets.all(10),
//                       child: Icon(
//                         Icons.add_shopping_cart_sharp,
//                         color: kprimaryColor,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
