import 'package:flutter/material.dart';
import 'package:untitled1/components/Constants.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'components/Theme_Helper.dart';
import 'models/Producto.dart';

class Prueba extends StatefulWidget {
  const Prueba({super.key, required this.producto});
  final Producto producto;
  @override
  State<Prueba> createState() => _PruebaState();
}

TextEditingController prueba = TextEditingController();

class _PruebaState extends State<Prueba> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kprimaryColor,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            decoration: ThemeHelper().inputBoxDecorationShaddow(),
            child: TextFormField(
              controller: prueba,
              decoration: ThemeHelper().textInputDecoration("Entre su nombre"),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: ThemeHelper().buttonBoxDecoration(context),
            child: ElevatedButton(
              style: ThemeHelper().buttonStyle(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                child: Text(
                  'Generar'.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              onPressed: () {
                _showPickerOptions(context, widget.producto);
              },
            ),
          ),
        ],
      ),
    );
  }
}

void _showPickerOptions(BuildContext context, Producto producto) {
  
}
