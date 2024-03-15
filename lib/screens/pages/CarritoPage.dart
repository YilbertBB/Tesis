// // / oficial

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:untitled1/components/Constants.dart';
// import 'package:untitled1/models/Item_Carrito.dart';
// import '../../components/Size_Config.dart';
// import '../../models/Carrito.dart';
// import '../../models/User.dart';
// import '../../models/User_Cubit.dart';
// import '../../server/Carrito_Api.dart';
// import '../components/CartTileCarrito.dart';
// import 'AnimacionCarrito/CustomBiometricsPage.dart';
// import 'AnimacionCarrito/gravity.dart';
// import 'ProductInfo.dart';

// class CarritoPage extends StatefulWidget {
//   const CarritoPage({super.key, required this.carritos});
//   final Carrito carritos;
//   @override
//   State<CarritoPage> createState() => _CarritoPageState();
// }

// List<Carrito> selectedProduct = [];
// bool selectAll = false;
// final gravityController = GravityController();

// class _CarritoPageState extends State<CarritoPage> {
//   @override
//   Widget build(BuildContext context) {
//     User user = context.read<UserCubit>().state;

//     double? defaultsize = SizeConfig.defaultSize;
//     return Scaffold(
//       backgroundColor: kcontentColor,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: kcontentColor,
//         title: const Text(
//           'Carrito',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//         centerTitle: true,
//         leadingWidth: 60,
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 5),
//           child: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             style: IconButton.styleFrom(
//               backgroundColor: Colors.white,
//             ),
//             icon: const Icon(
//               Ionicons.chevron_back,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ),
//       body: widget.carritos.productos.isNotEmpty
//           ? ListView.builder(
//               itemCount: 1,
//               itemBuilder: (context, index) {
//                 return SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       CheckboxListTile(
//                         checkboxShape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                         value: selectAll,
//                         title: const Text(
//                           'Seleccionar todo',
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             color: Color(
//                               0xFF475269,
//                             ),
//                           ),
//                         ),
//                         activeColor: kprimaryColor,
//                         controlAffinity: ListTileControlAffinity.leading,
//                         onChanged: (value) {
//                           setState(() {
//                             selectAll = value!;
//                             for (var element in widget.carritos.productos) {
//                               element.isSelected = value;
//                             }
//                           });
//                         },
//                       ),
//                       SizedBox(
//                         height: defaultsize! * 30,
//                         width: double.infinity,
//                         child: ListView.separated(
//                           padding: const EdgeInsets.all(20),
//                           itemBuilder: (context, index) => CheckboxListTile(
//                             // dense: false,

//                             checkboxShape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(6)),
//                             contentPadding: const EdgeInsets.only(left: -1),
//                             controlAffinity: ListTileControlAffinity.leading,
//                             value: widget.carritos.productos[index].isSelected,
//                             activeColor: kprimaryColor,

//                             onChanged: (value) {
//                               setState(() {
//                                 widget.carritos.productos[index].isSelected =
//                                     value!;

//                                 final check = widget.carritos.productos
//                                     .every((element) => element.isSelected);
//                                 selectAll = check;
//                               });
//                             },
//                             title: CartTile(
//                               press: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => ProductInfo(
//                                       producto: widget
//                                           .carritos.productos[index].producto,
//                                       user: widget.carritos.cliente,
//                                     ),
//                                   ),
//                                 );
//                               },
//                               item: widget.carritos.productos[index],
//                               onRemove: () {
//                                 if (widget.carritos.productos[index]
//                                         .cantidadProd !=
//                                     1) {
//                                   setState(() {
//                                     widget.carritos.productos[index]
//                                         .cantidadProd--;
//                                   });
//                                 }
//                               },
//                               onAdd: () {
//                                 if (widget.carritos.productos[index]
//                                         .cantidadProd <
//                                     widget.carritos.productos[index].producto
//                                         .cantidadDisponible) {
//                                   setState(() {
//                                     widget.carritos.productos[index]
//                                         .cantidadProd++;
//                                   });
//                                 } else {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text(
//                                           'No hay más productos disponibles hasta el momento'),
//                                     ),
//                                   );
//                                 }
//                               },
//                               onDelete: () async {
//                                 var a = await deleteCarrito(
//                                   user,
//                                   widget.carritos.productos[index].producto,
//                                   widget.carritos.productos[index].id,
//                                 );
//                                 if (a == true) {
//                                   setState(() {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       const SnackBar(
//                                         content: Text(
//                                           'Producto eliminado del carrito satisfactoriamente',
//                                         ),
//                                       ),
//                                     );
//                                   });
//                                 } else {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text(
//                                         'Error al eliminar producto del carrito',
//                                       ),
//                                     ),
//                                   );
//                                 }
//                               },
//                             ),
//                           ),
//                           separatorBuilder: (context, index) =>
//                               const SizedBox(height: 20),
//                           itemCount: widget.carritos.productos.length,
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.symmetric(
//                             vertical: 10, horizontal: 15),
//                         padding: const EdgeInsets.all(15),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: [
//                             BoxShadow(
//                               color: const Color(0xFF475269).withOpacity(0.3),
//                               spreadRadius: 1,
//                               blurRadius: 5,
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   'Productos a Comprar:',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                                 Text(
//                                   widget.carritos.productos
//                                           .where(
//                                               (element) => element.isSelected)
//                                           .isEmpty
//                                       ? '0'
//                                       : '\$${widget.carritos.productos.where((element) => element.isSelected).map<double>((e) => e.cantidadProd.toDouble()).reduce((value1, value2) => value1 + value2)}',
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 10),
//                             const Divider(),
//                             const SizedBox(height: 10),
//                             const Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Subtotal',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                                 // Text(
//                                 //   widget.carritos.productos
//                                 //           .where(
//                                 //               (element) => element.isSelected)
//                                 //           .isEmpty
//                                 //       ? '0'
//                                 //       : '\$${calcSubtotal(widget.carritos.where((element) => element.isSelected).toList(), widget.carritos.where((element) => element.isSelected).toList()[index])}',
//                                 //   style: const TextStyle(
//                                 //     fontSize: 16,
//                                 //     fontWeight: FontWeight.bold,
//                                 //   ),
//                                 // ),
//                               ],
//                             ),
//                             Visibility(
//                               visible: widget.carritos.productos
//                                       .where((element) => element.isSelected)
//                                       .isNotEmpty
//                                   ? true
//                                   : false,
//                               child: const Column(
//                                 children: [
//                                   SizedBox(height: 10),
//                                   Divider(),
//                                   SizedBox(height: 10),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         'Envio',
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.grey),
//                                       ),
//                                       Text(
//                                         '100',
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.grey),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             // Visibility(
//                             //   visible: widget.carritos.productos
//                             //           .where((element) => element.isSelected)
//                             //           .isNotEmpty
//                             //       ? mostrarDescuento(
//                             //           widget.carritos.productos
//                             //               .where(
//                             //                   (element) => element.isSelected)
//                             //               .toList(),
//                             //           widget.carritos
//                             //               .where(
//                             //                   (element) => element.isSelected)
//                             //               .toList()[index])
//                             //       : false,
//                             //   child: const Column(
//                             //     children: [
//                             //       SizedBox(height: 10),
//                             //       Divider(),
//                             //       SizedBox(height: 10),
//                             //       Row(
//                             //         mainAxisAlignment:
//                             //             MainAxisAlignment.spaceBetween,
//                             //         children: [
//                             //           Text(
//                             //             'Descuento',
//                             //             style: TextStyle(
//                             //                 fontSize: 18,
//                             //                 fontWeight: FontWeight.bold,
//                             //                 color: Colors.grey),
//                             //           ),
//                             //           Text(
//                             //             '200',
//                             //             style: TextStyle(
//                             //                 fontSize: 18,
//                             //                 fontWeight: FontWeight.bold,
//                             //                 color: Colors.grey),
//                             //           ),
//                             //         ],
//                             //       ),
//                             //     ],
//                             //   ),
//                             // ),
//                             const SizedBox(height: 10),
//                             const Divider(),
//                             const SizedBox(height: 10),
//                             const Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Total',
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 // Text(
//                                 //   widget.carritos
//                                 //           .where(
//                                 //               (element) => element.isSelected)
//                                 //           .isEmpty
//                                 //       ? '0'
//                                 //       : '\$${calcTotal(widget.carritos.where((element) => element.isSelected).toList(), widget.carritos.where((element) => element.isSelected).toList()[index])}',
//                                 //   style: const TextStyle(
//                                 //     color: kprimaryColor,
//                                 //     fontSize: 18,
//                                 //     fontWeight: FontWeight.bold,
//                                 //   ),
//                                 // ),
//                               ],
//                             ),
//                             const SizedBox(height: 20),
//                           ],
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             margin: const EdgeInsets.only(left: 15, top: 20),
//                             alignment: Alignment.centerLeft,
//                             child: const Text(
//                               'Completar detalles del Pedido',
//                               style: TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(
//                                   0xFF475269,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             margin: const EdgeInsets.symmetric(
//                                 vertical: 10, horizontal: 15),
//                             padding: const EdgeInsets.all(15),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color:
//                                       const Color(0xFF475269).withOpacity(0.3),
//                                   spreadRadius: 1,
//                                   blurRadius: 5,
//                                 ),
//                               ],
//                             ),
//                             child: Column(
//                               children: [
//                                 const Text(
//                                   'Nombre del Propietario',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: kTextColor,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 TextField(
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(30),
//                                       borderSide: BorderSide.none,
//                                     ),
//                                     contentPadding: const EdgeInsets.symmetric(
//                                       vertical: 5,
//                                       horizontal: 15,
//                                     ),
//                                     filled: true,
//                                     fillColor: kcontentColor,
//                                     hintText:
//                                         "${widget.carritos.cliente.first_name} ${widget.carritos.cliente.last_name}",
//                                     hintStyle: const TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 const Text(
//                                   'Direccion de envio',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: kTextColor,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 TextField(
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(30),
//                                       borderSide: BorderSide.none,
//                                     ),
//                                     contentPadding: const EdgeInsets.symmetric(
//                                       vertical: 5,
//                                       horizontal: 15,
//                                     ),
//                                     filled: true,
//                                     fillColor: kcontentColor,
//                                     hintText: widget.carritos.cliente.direccion,
//                                     hintStyle: const TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 const Text(
//                                   'Número de Teléfono',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: kTextColor,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 TextField(
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(30),
//                                       borderSide: BorderSide.none,
//                                     ),
//                                     contentPadding: const EdgeInsets.symmetric(
//                                       vertical: 5,
//                                       horizontal: 15,
//                                     ),
//                                     filled: true,
//                                     fillColor: kcontentColor,
//                                     hintText: widget.carritos.cliente.telefono,
//                                     hintStyle: const TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//                           Container(
//                             margin:
//                                 EdgeInsets.all(SizeConfig.defaultSize! * 1.5),
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 padding: EdgeInsets.all(
//                                     SizeConfig.defaultSize! * 1.5),
//                                 backgroundColor: kprimaryColor,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(50),
//                                 ),
//                               ),
//                               child: Text(
//                                 'Comprar',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: SizeConfig.defaultSize! * 1.6,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               onPressed: () {
//                                 const transitionDuration =
//                                     Duration(milliseconds: 400);

//                                 Navigator.of(context).push(
//                                   PageRouteBuilder(
//                                     transitionDuration: transitionDuration,
//                                     reverseTransitionDuration:
//                                         transitionDuration,
//                                     pageBuilder: (_, animation, ___) {
//                                       return FadeTransition(
//                                         opacity: animation,
//                                         // child: const BiometricsPage(), Uses Lottie
//                                         child: const CustomBiometricsPage(),
//                                       );
//                                     },
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 );
//               },
//             )
//           : SizedBox(
//               width: double.infinity,
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.info,
//                       size: 120,
//                       color: Colors.grey[300],
//                     ),
//                     const Text(
//                       'Su carrito de compras está vacio, para poder agregar productos al mismo simplemente selecciona el icono de Carrito, en el producto que desee.',
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }

// mostrarDescuento(Carrito carritos, ItemCarrito itemcarrito) {
//   double subtotal = calcSubtotal(carritos, itemcarrito);
//   if (subtotal >= 1000) {
//     return true;
//   } else {
//     return false;
//   }
// }

// double calcSubtotal(Carrito carritos, ItemCarrito itemcarrito) {
//   return carritos.productos.length > 1
//       ? carritos.productos
//           .map<double>((e) => e.cantidadProd * e.producto.precio)
//           .reduce((value1, value2) => value1 + value2)
//       : itemcarrito.producto.precio * itemcarrito.cantidadProd;
// }

// double calcTotal(Carrito carritos, ItemCarrito itemcarrito) {
//   double total = 0;
//   double subtotal = calcSubtotal(carritos, itemcarrito);
//   double envio = 100;
//   double descuento = 200;

//   if (subtotal >= 1000) {
//     total = (subtotal + envio) - descuento;
//     return total;
//   } else {
//     total = subtotal + envio;
//     return total;
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:untitled1/components/Constants.dart';
import 'package:untitled1/models/Item_Carrito.dart';
import '../../components/Size_Config.dart';
import '../../models/User.dart';
import '../../models/User_Cubit.dart';
import '../../server/Carrito_Api.dart';
import '../components/CartTileCarrito.dart';
import 'AnimacionCarrito/CustomBiometricsPage.dart';
import 'ProductInfo.dart';

class CarritoPage extends StatefulWidget {
  const CarritoPage({super.key});
  @override
  State<CarritoPage> createState() => _CarritoPageState();
}

bool selectAll = false;

class _CarritoPageState extends State<CarritoPage> {
  @override
  Widget build(BuildContext context) {
    User user = context.read<UserCubit>().state;

    double? defaultsize = SizeConfig.defaultSize;
    return Scaffold(
        backgroundColor: kcontentColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kcontentColor,
          title: const Text(
            'Carrito',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          leadingWidth: 60,
          leading: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              icon: const Icon(
                Ionicons.chevron_back,
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: FutureBuilder(
          future: getListCarrito(user, 100),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            CheckboxListTile(
                              checkboxShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              value: selectAll,
                              title: const Text(
                                'Seleccionar todo',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(
                                    0xFF475269,
                                  ),
                                ),
                              ),
                              activeColor: kprimaryColor,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (value) {
                                setState(() {
                                  selectAll = value!;
                                  for (var element
                                      in snapshot.data!) {
                                    element.isSelected = value;
                                  }
                                });
                              },
                            ),
                            SizedBox(
                              height: defaultsize! * 30,
                              width: double.infinity,
                              child: ListView.separated(
                                padding: const EdgeInsets.all(20),
                                itemBuilder: (context, index) =>
                                    CheckboxListTile(
                                  // dense: false,

                                  checkboxShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  contentPadding:
                                      const EdgeInsets.only(left: -1),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  value: snapshot
                                      .data!.productos[index].isSelected,
                                  activeColor: kprimaryColor,

                                  onChanged: (value) {
                                    setState(() {
                                      snapshot.data!.productos[index]
                                          .isSelected = value!;

                                      final check = snapshot.data!.productos
                                          .every(
                                              (element) => element.isSelected);
                                      selectAll = check;
                                    });
                                  },
                                  title: CartTile(
                                    press: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductInfo(
                                            producto: snapshot.data!
                                                .productos[index].producto,
                                            user: snapshot.data!.cliente,
                                          ),
                                        ),
                                      );
                                    },
                                    item: snapshot.data!.productos[index],
                                    onRemove: () {
                                      if (snapshot.data!.productos[index]
                                              .cantidadProd !=
                                          1) {
                                        setState(() {
                                          snapshot.data!.productos[index]
                                              .cantidadProd--;
                                        });
                                      }
                                    },
                                    onAdd: () {
                                      if (snapshot.data!.productos[index]
                                              .cantidadProd <
                                          snapshot.data!.productos[index]
                                              .producto.cantidadDisponible) {
                                        setState(() {
                                          snapshot.data!.productos[index]
                                              .cantidadProd++;
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'No hay más productos disponibles hasta el momento'),
                                          ),
                                        );
                                      }
                                    },
                                    onDelete: () async {
                                      var a = await deleteCarrito(
                                        user,
                                        snapshot
                                            .data!.productos[index].producto,
                                        snapshot.data!.productos[index].id,
                                      );
                                      if (a == true) {
                                        setState(() {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Producto eliminado del carrito satisfactoriamente',
                                              ),
                                            ),
                                          );
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Error al eliminar producto del carrito',
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 20),
                                itemCount: snapshot.data!.productos.length,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF475269)
                                        .withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Productos a Comprar:',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.productos
                                                .where((element) =>
                                                    element.isSelected)
                                                .isEmpty
                                            ? '0'
                                            : '\$${snapshot.data!.productos.where((element) => element.isSelected).map<double>((e) => e.cantidadProd.toDouble()).reduce((value1, value2) => value1 + value2)}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  const Divider(),
                                  const SizedBox(height: 10),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Subtotal',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      // Text(
                                      //   snapshot.data!.productos
                                      //           .where((element) =>
                                      //               element.isSelected)
                                      //           .isEmpty
                                      //       ? '0'
                                      //       : '\$${calcSubtotal(snapshot.data!.where((element) => element.isSelected).toList(), snapshot.data!.where((element) => element.isSelected).toList()[index])}',
                                      //   style: const TextStyle(
                                      //     fontSize: 16,
                                      //     fontWeight: FontWeight.bold,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  Visibility(
                                    visible: snapshot.data!.productos
                                            .where(
                                                (element) => element.isSelected)
                                            .isNotEmpty
                                        ? true
                                        : false,
                                    child: const Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Divider(),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Envio',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                            Text(
                                              '100',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: snapshot.data!.productos
                                            .where(
                                                (element) => element.isSelected)
                                            .isNotEmpty
                                        ? mostrarDescuento(
                                            snapshot.data!.productos
                                                .where((element) =>
                                                    element.isSelected)
                                                .toList(),
                                            snapshot.data!.productos
                                                .where((element) =>
                                                    element.isSelected)
                                                .toList()[index])
                                        : false,
                                    child: const Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Divider(),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Descuento',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                            Text(
                                              '200',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Divider(),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Total',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data!.productos
                                                .where((element) =>
                                                    element.isSelected)
                                                .isEmpty
                                            ? '0'
                                            : '\$${calcTotal(snapshot.data!.productos.where((element) => element.isSelected).toList(), snapshot.data!.productos.where((element) => element.isSelected).toList()[index])}',
                                        style: const TextStyle(
                                          color: kprimaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 15, top: 20),
                                  alignment: Alignment.centerLeft,
                                  child: const Text(
                                    'Completar detalles del Pedido',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Color(
                                        0xFF475269,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF475269)
                                            .withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Nombre del Propietario',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: kTextColor,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 5,
                                            horizontal: 15,
                                          ),
                                          filled: true,
                                          fillColor: kcontentColor,
                                          hintText:
                                              "${snapshot.data!.cliente.first_name} ${snapshot.data!.cliente.last_name}",
                                          hintStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'Direccion de envio',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: kTextColor,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 5,
                                            horizontal: 15,
                                          ),
                                          filled: true,
                                          fillColor: kcontentColor,
                                          hintText:
                                              snapshot.data!.cliente.direccion,
                                          hintStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'Número de Teléfono',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: kTextColor,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide.none,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 5,
                                            horizontal: 15,
                                          ),
                                          filled: true,
                                          fillColor: kcontentColor,
                                          hintText:
                                              snapshot.data!.cliente.telefono,
                                          hintStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  margin: EdgeInsets.all(
                                      SizeConfig.defaultSize! * 1.5),
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(
                                          SizeConfig.defaultSize! * 1.5),
                                      backgroundColor: kprimaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                    child: Text(
                                      'Comprar',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              SizeConfig.defaultSize! * 1.6,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      const transitionDuration =
                                          Duration(milliseconds: 400);

                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                          transitionDuration:
                                              transitionDuration,
                                          reverseTransitionDuration:
                                              transitionDuration,
                                          pageBuilder: (_, animation, ___) {
                                            return FadeTransition(
                                              opacity: animation,
                                              // child: const BiometricsPage(), Uses Lottie
                                              child:
                                                  const CustomBiometricsPage(),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  )
                : SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info,
                            size: 120,
                            color: Colors.grey[300],
                          ),
                          const Text(
                            'Su carrito de compras está vacio, para poder agregar productos al mismo simplemente selecciona el icono de Carrito, en el producto que desee.',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ));
  }
}

mostrarDescuento(List<ItemCarrito> productos, ItemCarrito producto) {
  double subtotal = calcSubtotal(productos, producto);
  if (subtotal >= 1000) {
    return true;
  } else {
    return false;
  }
}

double calcSubtotal(List<ItemCarrito> productos, ItemCarrito producto) {
  return productos.length > 1
      ? productos
          .map<double>((e) => e.cantidadProd * e.producto.precio)
          .reduce((value1, value2) => value1 + value2)
      : producto.producto.precio * producto.cantidadProd;
}

double calcTotal(List<ItemCarrito> productos, ItemCarrito producto) {
  double total = 0;
  double subtotal = calcSubtotal(productos, producto);
  double envio = 100;
  double descuento = 200;

  if (subtotal >= 1000) {
    total = (subtotal + envio) - descuento;
    return total;
  } else {
    total = subtotal + envio;
    return total;
  }
}
