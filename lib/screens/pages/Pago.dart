import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/screens/pages/Principal.dart';

import '../../components/Constants.dart';
import '../../components/Size_Config.dart';
import '../../models/Producto.dart';
import '../../models/User.dart';
import '../../models/User_Cubit.dart';
import 'AnimacionCarrito/CustomBiometricsPage.dart';

class Pago extends StatelessWidget {
  const Pago({
    super.key,
    required this.producto,
    required this.cantProd,
  });

  final Producto producto;
  final int cantProd;

  @override
  Widget build(BuildContext context) {
    User user = context.read<UserCubit>().state;

    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 100,
        title: const Center(
          child: Text(
            'ARShop',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontFamily: 'Gugi',
            ),
          ),
        ),
        backgroundColor: kprimaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: SizeConfig.defaultSize! * 3),
              child: Text(
                'Resumen de su pedido:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.defaultSize! * 3,
                ),
              ),
            ),
            BodyP(producto: producto),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              padding: const EdgeInsets.all(15),
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
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 15,
                      ),
                      filled: true,
                      fillColor: kcontentColor,
                      hintText: "${user.first_name} ${user.last_name}",
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
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 15,
                      ),
                      filled: true,
                      fillColor: kcontentColor,
                      hintText: user.direccion,
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
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 15,
                      ),
                      filled: true,
                      fillColor: kcontentColor,
                      hintText: user.telefono,
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
              margin: EdgeInsets.all(SizeConfig.defaultSize! * 1.5),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(SizeConfig.defaultSize! * 1.5),
                  backgroundColor: kprimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(
                  'Comprar',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.defaultSize! * 1.6,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  const transitionDuration = Duration(milliseconds: 400);

                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: transitionDuration,
                      reverseTransitionDuration: transitionDuration,
                      pageBuilder: (_, animation, ___) {
                        return FadeTransition(
                          opacity: animation,
                          // child: const BiometricsPage(), Uses Lottie
                          child: const CustomBiometricsPage(),
                        );
                      },
                    ),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Principal(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BodyP extends StatefulWidget {
  const BodyP({
    super.key,
    required this.producto,
  });

  final Producto producto;

  @override
  State<BodyP> createState() => _BodyPState();
}

class _BodyPState extends State<BodyP> {
  bool mostrar = false;
  @override
  void initState() {
    if (widget.producto.precio >= 300 && widget.producto.cantidad >= 3) {
      setState(() {
        mostrar = true;
      });
    } else {
      setState(() {
        mostrar = false;
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double? defaultsize = SizeConfig.defaultSize;

    return Padding(
      padding: EdgeInsets.only(
        left: defaultsize! * 5,
        right: defaultsize * 5,
        top: defaultsize * 2,
        bottom: defaultsize * 2,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Descripción',
                  style: Theme.of(context).textTheme.bodyLarge!),
              Text('Importe', style: Theme.of(context).textTheme.bodyLarge!),
            ],
          ),
          Producto_a_Comprar(
              producto: widget.producto, cantProd: widget.producto.cantidad),
          const Divider(
            color: Colors.grey,
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal a pagar',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${calcSubtotal(widget.producto.cantidad, widget.producto.precio)}',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Precio envio',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                Text(
                  '100',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ],
            ),
          ),
          Visibility(
            visible: mostrar,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Descuento',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  Text(
                    '200',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total a pagar',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${calcTotal(widget.producto.cantidad, widget.producto.precio)}',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

double calcSubtotal(int cant, double precioProduct) {
  double total = 0;
  double importeProd = 0;
  importeProd = importe(precioProduct, cant);
  total += importeProd;
  return total;
}

double calcTotal(int cant, double precioProduct) {
  double total = 0;
  double subtotal = 0;
  double envio = 100;
  double descuento = 200;

  subtotal = calcSubtotal(cant, precioProduct);
  if (cant >= 3 && precioProduct >= 300) {
    total = (subtotal + envio) - descuento;
    return total;
  } else {
    total = subtotal + envio;
    return total;
  }
}

class Producto_a_Comprar extends StatelessWidget {
  const Producto_a_Comprar({
    super.key,
    required this.producto,
    required this.cantProd,
  });

  final Producto producto;
  final int cantProd;

  @override
  Widget build(BuildContext context) {
    double? defaultsize = SizeConfig.defaultSize;
    return Padding(
      padding: const EdgeInsets.only(),
      child: Column(
        children: [
          const Divider(
            color: Colors.grey,
            height: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                producto.nombre,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: kprimaryColor),
              ),
              Text(
                '\$${importe(producto.precio, cantProd)}',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.grey),
              ),
            ],
          ),
          SizedBox(
            height: defaultsize! * 1,
          ),
          Row(
            children: [
              Text(
                'Precio del artículo:  ',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.grey),
              ),
              Text(
                '\$${producto.precio}',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.grey),
              ),
            ],
          ),
          SizedBox(
            height: defaultsize * 0.5,
          ),
          Row(
            children: [
              Text(
                'Cantidad:  ',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.grey),
              ),
              Text(
                '$cantProd',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

double importe(double precio, int cant) {
  double importe = 0;
  importe = precio * cant;
  return importe;
}
