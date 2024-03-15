import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:untitled1/models/Item_Carrito.dart';

import '../../components/Constants.dart';
import '../../models/Carrito.dart';

class CartTile extends StatelessWidget {
  const CartTile({
    super.key,
    required this.onRemove,
    required this.onAdd,
    required this.item,
    required this.onDelete,
    required this.press,
    // required this.pressSelect,
  });
  final ItemCarrito item;
  final Function() onRemove;
  final Function() onAdd;
  final Function() onDelete;
  final Function() press;
  // final Function() pressSelect;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: press,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                // IconButton(
                //   onPressed: pressSelect,
                //   icon: item.isSelected
                //       ? const Icon(
                //           Icons.check_circle,
                //           color: kprimaryColor,
                //         )
                //       : const Icon(
                //           Icons.check_circle_outline,
                //           color: Colors.grey,
                //         ),
                // ),
                Container(
                  height: 85,
                  width: 85,
                  decoration: BoxDecoration(
                    color: kcontentColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Image.network(
                    item.producto.imagenUrl,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.producto.nombre,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item.producto.categoria.nombre,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Cantidad: ${item.producto.cantidadDisponible}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '\$${item.producto.precio}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: onDelete,
                icon: const Icon(
                  Ionicons.trash_outline,
                  color: Colors.red,
                  size: 20,
                ),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: kcontentColor,
                  border: Border.all(
                    width: 2,
                    color: Colors.grey.shade200,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: onRemove,
                      iconSize: 18,
                      icon: const Icon(
                        Ionicons.remove_outline,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      item.cantidadProd.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      onPressed: onAdd,
                      iconSize: 18,
                      icon: const Icon(
                        Ionicons.add_outline,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Oficial 

// import 'package:flutter/material.dart';
// import 'package:ionicons/ionicons.dart';

// import '../../components/Constants.dart';
// import '../../models/Carrito.dart';

// class CartTile extends StatelessWidget {
//   const CartTile({
//     super.key,
//     required this.onRemove,
//     required this.onAdd,
//     required this.item,
//     required this.onDelete,
//     required this.press,
//     required this.pressSelect,
//   });
//   final Carrito item;
//   final Function() onRemove;
//   final Function() onAdd;
//   final Function() onDelete;
//   final Function() press;
//   final Function() pressSelect;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         GestureDetector(
//           onTap: press,
//           child: Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             padding: const EdgeInsets.all(10),
//             child: Row(
//               children: [
              
//                 IconButton(
//                   onPressed: pressSelect,
//                   icon: item.isSelected
//                       ? const Icon(
//                           Icons.check_circle,
//                           color: kprimaryColor,
//                         )
//                       : const Icon(
//                           Icons.check_circle_outline,
//                           color: Colors.grey,
//                         ),
//                 ),
//                 Container(
//                   height: 85,
//                   width: 85,
//                   decoration: BoxDecoration(
//                     color: kcontentColor,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   padding: const EdgeInsets.all(10),
//                   child: Image.network(
//                     item.producto.imagenUrl,
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       item.producto.nombre,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       item.producto.categoria.nombre,
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey.shade400,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       "Cantidad: ${item.producto.cantidadDisponible}",
//                       style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       '\$${item.producto.precio}',
//                       style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Positioned(
//           top: 5,
//           right: 5,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               IconButton(
//                 onPressed: onDelete,
//                 icon: const Icon(
//                   Ionicons.trash_outline,
//                   color: Colors.red,
//                   size: 20,
//                 ),
//               ),
//               Container(
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: kcontentColor,
//                   border: Border.all(
//                     width: 2,
//                     color: Colors.grey.shade200,
//                   ),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   children: [
//                     IconButton(
//                       onPressed: onRemove,
//                       iconSize: 18,
//                       icon: const Icon(
//                         Ionicons.remove_outline,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(width: 5),
//                     Text(
//                       item.cantidadProd.toString(),
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(width: 5),
//                     IconButton(
//                       onPressed: onAdd,
//                       iconSize: 18,
//                       icon: const Icon(
//                         Ionicons.add_outline,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

