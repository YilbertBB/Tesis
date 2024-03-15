import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';

import '../../components/Constants.dart';
import '../../components/Size_Config.dart';
import '../../models/Producto.dart';
import '../../models/User.dart';
import '../../server/Producto_Api.dart';
import '../components/ProductCard.dart';
import '../components/RecommandProduct.dart';
import 'ProductInfo.dart';

class BuscarProducto extends StatefulWidget {
  const BuscarProducto({super.key, required this.user});
  final User user;

  @override
  State<BuscarProducto> createState() => _BuscarProductoState();
}

class _BuscarProductoState extends State<BuscarProducto> {
  final TextEditingController _controller = TextEditingController();

  bool _isSearching = false;

  List<Producto> productosResult = [];

  void searchProuct(String producto) async {
    if (producto.isNotEmpty) {
      setState(() {
        _isSearching = true;
      });
      try {
        List<Producto> results = await buscarProducto(widget.user, producto);
        setState(() {
          productosResult = results;
          if (productosResult.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Producto no encontrado'),
              ),
            );
          }
        });
      } catch (e) {
        setState(() {
          _isSearching = false;
        });
      }
    } else {
      setState(() {
        productosResult.clear();
        _isSearching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double? defaultsize = SizeConfig.defaultSize;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Buscar Producto',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Gugi',
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
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: kprimaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.screenHeigth! * 0.2,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      bottom: 36 + 20.0,
                    ),
                    height: SizeConfig.screenHeigth! * 0.2 - 27,
                    decoration: const BoxDecoration(
                      color: kprimaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Encuentra lo que buscas',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const Spacer(),
                        Image.asset("assets/icons/ic_launcher.png")
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 10),
                            blurRadius: 50,
                            color: kprimaryColor.withOpacity(0.23),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                hintText: 'Buscar',
                                hintStyle: TextStyle(
                                  color: kprimaryColor.withOpacity(0.5),
                                ),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              onChanged: (value) {
                                searchProuct(value);
                              },
                            ),
                          ),
                          SvgPicture.asset("assets/icons/search.svg")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            !_isSearching
                ? FutureBuilder(
                    future: geListOfProducto(widget.user),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? RecommandProduct(
                              productos: snapshot.data!,
                              user: widget.user,
                            )
                          : Center(
                              child: Image.asset('assets/ripple.gif'),
                            );
                    },
                  )
                : Padding(
                    padding: EdgeInsets.all(defaultsize! * 2),
                    child: GridView.builder(
                      itemCount: productosResult.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            SizeConfig.orientation == Orientation.portrait
                                ? 2
                                : 4,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.693,
                      ),
                      itemBuilder: (context, index) => ProductCard(
                        producto: productosResult[index],
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductInfo(
                                producto: productosResult[index],
                                user: widget.user,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
