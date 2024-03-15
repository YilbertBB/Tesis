import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/Constants.dart';
import '../../models/Producto.dart';
import '../../models/User.dart';
import '../../server/Producto_Api.dart';

class HeaderWithSearchBox extends StatefulWidget {
  const HeaderWithSearchBox({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;
  @override
  State<HeaderWithSearchBox> createState() => _HeaderWithSearchBoxState();
}

class _HeaderWithSearchBoxState extends State<HeaderWithSearchBox> {
  final TextEditingController _controller = TextEditingController();

  List<Producto> productosResult = [];

  void searchProuct(String producto) async {
    if (producto.isNotEmpty) {
      productosResult = await buscarProducto(widget.user, _controller.text);
      setState(() {
        productosResult.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Producto no encontrado o nombre incorrecto'),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0 * 2.5),
      height: 200,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20.0, bottom: 0),
            height: 180,
            decoration: const BoxDecoration(
              color: kprimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    'Bienvenido a ARShop!',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gugi',
                        ),
                  ),
                ),
                const Spacer(),
                Center(
                  child: ClipOval(
                      child: Image.asset(
                    "assets/icons/ic_launcher.png",
                  )),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 10),
                      blurRadius: 50,
                      color: kprimaryColor.withOpacity(0.23))
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onChanged: (value) {
                        searchProuct(value);
                      },
                      decoration: InputDecoration(
                        hintText: "Buscar",
                        hintStyle: TextStyle(
                          color: kprimaryColor.withOpacity(0.5),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: SvgPicture.asset("assets/icons/search.svg"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
