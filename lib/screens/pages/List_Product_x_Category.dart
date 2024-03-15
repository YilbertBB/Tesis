import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../components/Constants.dart';
import '../../components/Size_Config.dart';
import '../../models/Categoria.dart';
import '../../models/User.dart';
import '../../server/Producto_Api.dart';
import '../components/RecommandProduct.dart';

class List_Products_x_Categoria extends StatelessWidget {
  const List_Products_x_Categoria(
      {super.key, required this.categoria, required this.user});
  final Categoria categoria;
  final User user;

  @override
  Widget build(BuildContext context) {
    double? defaultsize = SizeConfig.defaultSize;
    return Scaffold(
      appBar: AppBar(
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
            ),
          ),
        ),
        title: Text(categoria.nombre,
            style: TextStyle(fontFamily: 'Gugi', fontSize: defaultsize! * 2)),
        centerTitle: true,
        backgroundColor: kprimaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            categoria.nombre.toLowerCase() == 'Todos'.toLowerCase()
                ? FutureBuilder(
                    future: geListOfProducto(user),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? RecommandProduct(
                              productos: snapshot.data!,
                              user: user,
                            )
                          : Center(
                              child: Image.asset('assets/ripple.gif'),
                            );
                    },
                  )
                : FutureBuilder(
                    future: geListOfProducto_x_Categoria(user, categoria),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? RecommandProduct(
                              productos: snapshot.data!,
                              user: user,
                            )
                          : Center(
                              child: Image.asset('assets/ripple.gif'),
                            );
                    },
                  )
          ],
        ),
      ),
    );
  }
}
