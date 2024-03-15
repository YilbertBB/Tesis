// Oficial

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../components/Constants.dart';
import '../../components/Size_Config.dart';
import '../../models/Producto.dart';
import '../../models/User.dart';
import '../../server/Carrito_Api.dart';
import '../components/ProductDesciption.dart';
import 'AnimacionCarrito/CustomBiometricsPage.dart';
import 'Pago.dart';


class ProductInfo extends StatelessWidget {
  const ProductInfo({super.key, required this.producto, required this.user});

  final Producto producto;
  final User user;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ImageAndIcons(producto: producto, user: user),
            TitleAndPrice(
              categoria: producto.categoria.nombre,
              precio: producto.precio,
              nombre: producto.nombre,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: size.width / 2,
                  height: 84,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kprimaryColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ),
                    child: const Text(
                      "Comprar",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Pago(
                              producto: producto, cantProd: producto.cantidad),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: size.width / 2,
                    height: 84,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Description(producto: producto),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                          ),
                        ),
                      ),
                      child: const Text(
                        "Descripción",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

class TitleAndPrice extends StatelessWidget {
  const TitleAndPrice({
    Key? key,
    required this.nombre,
    required this.categoria,
    required this.precio,
  }) : super(key: key);

  final String nombre, categoria;
  final double precio;

  @override
  Widget build(BuildContext context) {
    double? defaultsize = SizeConfig.defaultSize;
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: defaultsize!),
        child: Row(
          children: [
            SizedBox(
              width: defaultsize * 33,
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "$nombre\n",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: const Color(0xff3ca046),
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: categoria,
                    style: const TextStyle(
                        fontSize: 20,
                        color: kprimaryColor,
                        fontWeight: FontWeight.w300),
                  ),
                ]),
              ),
            ),
            const Spacer(),
            precio.toString().length != 5
                ? SizedBox(
                    width: defaultsize * 5,
                    child: Text(
                      "\$$precio",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: kprimaryColor),
                    ),
                  )
                : Text(
                    "\$$precio",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: kprimaryColor),
                  )
          ],
        ),
      ),
    );
  }
}

class ImageAndIcons extends StatefulWidget {
  ImageAndIcons({super.key, required this.producto, required this.user});

  Producto producto;
  User user;

  @override
  State<ImageAndIcons> createState() => _ImageAndIconsState();
}

class _ImageAndIconsState extends State<ImageAndIcons> {
  @override
  Widget build(BuildContext context) {
    double? defaultsize = SizeConfig.defaultSize;
    return Padding(
      padding: EdgeInsets.only(bottom: defaultsize! * 3),
      child: SizedBox(
        height: SizeConfig.screenHeigth! * 0.8,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: defaultsize * 1),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: defaultsize * 0.5),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: IconButton.styleFrom(
                              backgroundColor: Colors.white),
                          icon: const Icon(
                            Ionicons.chevron_back,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: defaultsize * 3),
                    Tooltip(
                      message: 'Visualizar 3D',
                      child: IconCardI(
                        icon: const Icon(Icons.camera),
                        press: () {},
                      ),
                    ),
                    SizedBox(height: defaultsize * 3),
                    Tooltip(
                      message: 'Agregar al Carrito',
                      child: IconCardI(
                        icon: const Icon(Icons.add_shopping_cart_sharp),
                        press: () {
                          // if (widget.producto.perteneceCarrito != true) {
                          setState(() async {
                            bool a = await createCarrito(
                              widget.user,
                              widget.producto,
                            );
                            if (a == true) {
                              const transitionDuration =
                                  Duration(milliseconds: 400);

                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  transitionDuration: transitionDuration,
                                  reverseTransitionDuration: transitionDuration,
                                  pageBuilder: (_, animation, ___) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: const CustomBiometricsPage(),
                                    );
                                  },
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Ocurrio un error al añadir el producto al carrito'),
                                ),
                              );
                            }
                          });
                          // } else {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(
                          //       content:
                          //           Text('El producto ya está en el carrito'),
                          //     ),
                          //   );
                          // }
                        },
                      ),
                    ),
                    SizedBox(height: defaultsize * 3),
                    Tooltip(
                      message: 'Generar Codigo QR',
                      child: IconCardI(
                        icon: const Icon(Icons.qr_code),
                        press: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                children: [
                                  SizedBox(
                                    height: defaultsize * 20,
                                    width: defaultsize * 20,
                                    child: Center(
                                      child: QrImageView(
                                        version: QrVersions.auto,
                                        data:
                                            'Categoria: ${widget.producto.categoria.nombre} \n\n Nombre: ${widget.producto.nombre} \n\n Precio: ${widget.producto.precio} \n\n Descripcion: ${widget.producto.descripcion}',
                                        eyeStyle: const QrEyeStyle(
                                            color: kprimaryColor,
                                            eyeShape: QrEyeShape.square),
                                        embeddedImage: const AssetImage(
                                            'assets/icons/ic_launcher.png'),
                                        embeddedImageStyle:
                                            const QrEmbeddedImageStyle(
                                                size: Size(60, 60)),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: defaultsize * 3,
                    ),
                    FloatingActionButton(
                      backgroundColor: kprimaryColor,
                      child: const Icon(Icons.add),
                      onPressed: () {
                        if (widget.producto.cantidad <
                            widget.producto.cantidadDisponible) {
                          setState(() {
                            widget.producto.cantidad++;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'No hay más productos disponibles hasta el momento'),
                            ),
                          );
                        }
                      },
                    ),
                    Text(
                      widget.producto.cantidad.toString(),
                      style: TextStyle(fontSize: defaultsize * 3),
                    ),
                    FloatingActionButton(
                      backgroundColor: kprimaryColor,
                      child: const Icon(Icons.remove),
                      onPressed: () {
                        if (widget.producto.cantidad != 1) {
                          setState(() {
                            widget.producto.cantidad--;
                          });
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
            Hero(
              tag: widget.producto.imagenUrl,
              child: ImageVent(
                image: widget.producto.imagenUrl,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageVent extends StatelessWidget {
  const ImageVent({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: size.height * 0.8,
        width: size.width * 0.75,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(63),
            topLeft: Radius.circular(63),
          ),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 10),
                blurRadius: 60,
                color: kprimaryColor.withOpacity(0.29)),
          ],
          image: DecorationImage(
            alignment: Alignment.centerLeft,
            fit: BoxFit.cover,
            image: NetworkImage(image),
          ),
        ),
      ),
    );
  }
}

class IconCard extends StatelessWidget {
  const IconCard({
    Key? key,
    required this.icon,
  }) : super(key: key);

  final String icon;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
      padding: const EdgeInsets.all(20 / 2),
      height: 62,
      width: 62,
      decoration: BoxDecoration(
          color: const Color(0xfff9f8fd),
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 15),
              blurRadius: 22,
              color: kprimaryColor.withOpacity(0.22),
            ),
            const BoxShadow(
                offset: Offset(-15, -15), blurRadius: 20, color: Colors.white)
          ]),
      child: SvgPicture.asset(icon),
    );
  }
}

class IconCardI extends StatelessWidget {
  const IconCardI({
    Key? key,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final Icon icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      width: 62,
      decoration: BoxDecoration(
          color: const Color(0xfff9f8fd),
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 15),
              blurRadius: 22,
              color: kprimaryColor.withOpacity(0.22),
            ),
            const BoxShadow(
                offset: Offset(-15, -15), blurRadius: 20, color: Colors.white)
          ]),
      child: Center(
        child: IconButton(
          icon: icon,
          color: kprimaryColor,
          iconSize: 50,
          onPressed: press,
          enableFeedback: false,
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:ionicons/ionicons.dart';

// import '../../components/Constants.dart';
// import '../../components/Size_Config.dart';
// import '../../models/Producto.dart';
// import '../../models/User.dart';
// import '../../server/Carrito_Api.dart';
// import '../components/ProductDesciption.dart';
// import 'AnimacionCarrito/CustomBiometricsPage.dart';
// import 'Pago.dart';

// // int cantProductos = 1;

// class ProductInfo extends StatelessWidget {
//   const ProductInfo({super.key, required this.producto, required this.user});

//   final Producto producto;
//   final User user;
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             ImageAndIcons(producto: producto, user: user),
//             TitleAndPrice(
//               categoria: producto.categoria.nombre,
//               precio: producto.precio,
//               nombre: producto.nombre,
//             ),
//             const SizedBox(height: 20),
//             Row(
//               children: [
//                 SizedBox(
//                   width: size.width / 2,
//                   height: 84,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: kprimaryColor,
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.only(
//                           topRight: Radius.circular(20),
//                         ),
//                       ),
//                     ),
//                     child: const Text(
//                       "Comprar",
//                       style: TextStyle(color: Colors.white, fontSize: 16),
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => Pago(
//                               producto: producto, cantProd: producto.cantidad),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Expanded(
//                   child: SizedBox(
//                     width: size.width / 2,
//                     height: 84,
//                     child: TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 Description(producto: producto),
//                           ),
//                         );
//                       },
//                       style: TextButton.styleFrom(
//                         shape: const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(20),
//                           ),
//                         ),
//                       ),
//                       child: const Text(
//                         "Descripción",
//                         style: TextStyle(color: Colors.black, fontSize: 16),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TitleAndPrice extends StatelessWidget {
//   const TitleAndPrice({
//     Key? key,
//     required this.nombre,
//     required this.categoria,
//     required this.precio,
//   }) : super(key: key);

//   final String nombre, categoria;
//   final double precio;

//   @override
//   Widget build(BuildContext context) {
//     double? defaultsize = SizeConfig.defaultSize;
//     return SizedBox(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: defaultsize!),
//         child: Row(
//           children: [
//             SizedBox(
//               width: defaultsize * 33,
//               child: RichText(
//                 text: TextSpan(children: [
//                   TextSpan(
//                     text: "$nombre\n",
//                     style: Theme.of(context).textTheme.headlineMedium!.copyWith(
//                         color: const Color(0xff3ca046),
//                         fontWeight: FontWeight.bold),
//                   ),
//                   TextSpan(
//                     text: categoria,
//                     style: const TextStyle(
//                         fontSize: 20,
//                         color: kprimaryColor,
//                         fontWeight: FontWeight.w300),
//                   ),
//                 ]),
//               ),
//             ),
//             const Spacer(),
//             precio.toString().length != 5
//                 ? SizedBox(
//                     width: defaultsize * 5,
//                     child: Text(
//                       "\$$precio",
//                       style: Theme.of(context)
//                           .textTheme
//                           .headlineSmall!
//                           .copyWith(color: kprimaryColor),
//                     ),
//                   )
//                 : Text(
//                     "\$$precio",
//                     style: Theme.of(context)
//                         .textTheme
//                         .headlineSmall!
//                         .copyWith(color: kprimaryColor),
//                   )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ImageAndIcons extends StatefulWidget {
//   ImageAndIcons({super.key, required this.producto, required this.user});

//   Producto producto;
//   User user;

//   @override
//   State<ImageAndIcons> createState() => _ImageAndIconsState();
// }

// class _ImageAndIconsState extends State<ImageAndIcons> {
//   @override
//   Widget build(BuildContext context) {
//     double? defaultsize = SizeConfig.defaultSize;
//     return Padding(
//       padding: EdgeInsets.only(bottom: defaultsize! * 3),
//       child: SizedBox(
//         height: SizeConfig.screenHeigth! * 0.8,
//         child: Row(
//           children: <Widget>[
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(vertical: defaultsize * 1),
//                 child: Column(
//                   children: <Widget>[
//                     Align(
//                       alignment: Alignment.topLeft,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 5),
//                         child: IconButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           style: IconButton.styleFrom(
//                             backgroundColor: Colors.white,
//                           ),
//                           icon: const Icon(
//                             Ionicons.chevron_back,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: defaultsize * 3,
//                     ),
//                     Tooltip(
//                       message: 'Visualizar 3D',
//                       child: IconCardI(
//                         icon: const Icon(Icons.camera),
//                         press: () {},
//                       ),
//                     ),
//                     SizedBox(
//                       height: defaultsize * 3,
//                     ),
//                     FutureBuilder(
//                       future: getListCarrito(widget.user),
//                       builder: (context, snapshot) => Tooltip(
//                         message: 'Agregar al Carrito',
//                         child: IconCardI(
//                           icon: const Icon(Icons.add_shopping_cart_sharp),
//                           press: () {
//                             if (snapshot.data!.contains(widget.producto) !=
//                                 true) {
//                               setState(() async {
//                                 bool a = await createCarrito(
//                                   widget.user,
//                                   widget.producto,
//                                 );
//                                 if (a == true) {
//                                   const transitionDuration =
//                                       Duration(milliseconds: 400);

//                                   Navigator.of(context).push(
//                                     PageRouteBuilder(
//                                       transitionDuration: transitionDuration,
//                                       reverseTransitionDuration:
//                                           transitionDuration,
//                                       pageBuilder: (_, animation, ___) {
//                                         return FadeTransition(
//                                           opacity: animation,
//                                           // child: const BiometricsPage(), Uses Lottie
//                                           child: const CustomBiometricsPage(),
//                                         );
//                                       },
//                                     ),
//                                   );
//                                   // print(widget.producto.perteneceCarrito);

//                                   // ScaffoldMessenger.of(context).showSnackBar(
//                                   //   const SnackBar(
//                                   //     content: Text(
//                                   //         'Producto añadido satisfactoriamente al carrito'),
//                                   //   ),
//                                   // );
//                                 } else {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text(
//                                           'Ocurrio un error al añadir el producto al carrito'),
//                                     ),
//                                   );
//                                 }
//                               });
//                             } else {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content:
//                                       Text('El producto ya está en el carrito'),
//                                 ),
//                               );
//                             }
//                           },
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: defaultsize * 3,
//                     ),
//                     Tooltip(
//                       message: 'Generar Codigo QR',
//                       child: IconCardI(
//                         icon: const Icon(Icons.qr_code),
//                         press: () {},
//                       ),
//                     ),
//                     SizedBox(
//                       height: defaultsize * 3,
//                     ),
//                     FloatingActionButton(
//                       backgroundColor: kprimaryColor,
//                       child: const Icon(Icons.add),
//                       onPressed: () {
//                         if (widget.producto.cantidad <
//                             widget.producto.cantidadDisponible) {
//                           setState(() {
//                             widget.producto.cantidad++;
//                           });
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content: Text(
//                                   'No hay más productos disponibles hasta el momento'),
//                             ),
//                           );
//                         }
//                       },
//                     ),
//                     Text(
//                       widget.producto.cantidad.toString(),
//                       style: TextStyle(fontSize: defaultsize * 3),
//                     ),
//                     FloatingActionButton(
//                       backgroundColor: kprimaryColor,
//                       child: const Icon(Icons.remove),
//                       onPressed: () {
//                         if (widget.producto.cantidad != 1) {
//                           setState(() {
//                             widget.producto.cantidad--;
//                           });
//                         }
//                       },
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             Hero(
//               tag: widget.producto.imagenUrl,
//               child: ImageVent(
//                 image: widget.producto.imagenUrl,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ImageVent extends StatelessWidget {
//   const ImageVent({
//     Key? key,
//     required this.image,
//   }) : super(key: key);

//   final String image;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return GestureDetector(
//       onTap: () {},
//       child: Container(
//         height: size.height * 0.8,
//         width: size.width * 0.75,
//         decoration: BoxDecoration(
//           borderRadius: const BorderRadius.only(
//             bottomLeft: Radius.circular(63),
//             topLeft: Radius.circular(63),
//           ),
//           boxShadow: [
//             BoxShadow(
//                 offset: const Offset(0, 10),
//                 blurRadius: 60,
//                 color: kprimaryColor.withOpacity(0.29)),
//           ],
//           image: DecorationImage(
//             alignment: Alignment.centerLeft,
//             fit: BoxFit.cover,
//             image: NetworkImage(image),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class IconCard extends StatelessWidget {
//   const IconCard({
//     Key? key,
//     required this.icon,
//   }) : super(key: key);

//   final String icon;
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
//       padding: const EdgeInsets.all(20 / 2),
//       height: 62,
//       width: 62,
//       decoration: BoxDecoration(
//           color: const Color(0xfff9f8fd),
//           borderRadius: BorderRadius.circular(6),
//           boxShadow: [
//             BoxShadow(
//               offset: const Offset(0, 15),
//               blurRadius: 22,
//               color: kprimaryColor.withOpacity(0.22),
//             ),
//             const BoxShadow(
//                 offset: Offset(-15, -15), blurRadius: 20, color: Colors.white)
//           ]),
//       child: SvgPicture.asset(icon),
//     );
//   }
// }

// class IconCardI extends StatelessWidget {
//   const IconCardI({
//     Key? key,
//     required this.icon,
//     required this.press,
//   }) : super(key: key);

//   final Icon icon;
//   final VoidCallback press;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 62,
//       width: 62,
//       decoration: BoxDecoration(
//           color: const Color(0xfff9f8fd),
//           borderRadius: BorderRadius.circular(6),
//           boxShadow: [
//             BoxShadow(
//               offset: const Offset(0, 15),
//               blurRadius: 22,
//               color: kprimaryColor.withOpacity(0.22),
//             ),
//             const BoxShadow(
//                 offset: Offset(-15, -15), blurRadius: 20, color: Colors.white)
//           ]),
//       child: Center(
//         child: IconButton(
//           icon: icon,
//           color: kprimaryColor,
//           iconSize: 50,
//           onPressed: press,
//           enableFeedback: false,
//         ),
//       ),
//     );
//   }
// }
