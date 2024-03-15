import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';

import '../../components/Constants.dart';
import '../../components/RiveUtils.dart';
import '../../components/Size_Config.dart';
import '../../models/Producto.dart';
import '../../models/User.dart';
import '../../server/Categoria_Api.dart';
import '../../server/Producto_Api.dart';
import '../pages/ProductInfo.dart';
import 'ListCategorys.dart';
import 'MyAppbar.dart';
import 'ProductCard.dart';
import 'RecommandProduct.dart';
import 'TitleWithCustomUnderLine.dart';

class MyBody extends StatefulWidget {
  const MyBody({super.key, required this.user});
  final User user;

  @override
  State<MyBody> createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> with SingleTickerProviderStateMixin {
  bool isSideMenuClosed = true;
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scalAnimation;
  late SMIBool isSideBarClosed;

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
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double? defaultsize = SizeConfig.defaultSize;
    return RefreshIndicator(
      color: kprimaryColor,
      onRefresh: () async {
        geListOfCategoria(widget.user);
        geListOfProductoRecomendados(widget.user);
      },
      child: Stack(children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
          width: 288,
          left: isSideMenuClosed ? -288 : 0,
          height: SizeConfig.screenHeigth,
          child: const MyAppBar(),
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(animation.value - 30 * animation.value * pi / 180),
          child: Transform.translate(
            offset: Offset(animation.value * 265, 0),
            child: Transform.scale(
              scale: scalAnimation.value,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 20.0 * 2.5),
                          height: 200,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20.0, bottom: 0),
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
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
                                            hintText:
                                                'Encuentra cualquier cosa en casa...',
                                            hintStyle: TextStyle(
                                              color: kprimaryColor
                                                  .withOpacity(0.5),
                                            ),
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                          ),
                                          onChanged: (value) {
                                            searchProuct(value);
                                          },
                                        ),
                                      ),
                                      SvgPicture.asset(
                                          "assets/icons/search.svg")
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        !_isSearching
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(defaultsize!),
                                    child: const TitleWithCustomUnderLine(
                                        text: 'Categorias'),
                                  ),
                                  FutureBuilder(
                                    future: geListOfCategoria(widget.user),
                                    builder: (context, snapshot) =>
                                        snapshot.hasData
                                            ? ListCategorias(
                                                categorias: snapshot.data!,
                                                user: widget.user,
                                              )
                                            : Center(
                                                child: Image.asset(
                                                    'assets/ripple.gif')),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(defaultsize * 2),
                                    child: const TitleWithCustomUnderLine(
                                        text: 'Recomendados'),
                                  ),
                                  FutureBuilder(
                                    future: geListOfProductoRecomendados(
                                        widget.user),
                                    builder: (context, snapshot) {
                                      return snapshot.hasData
                                          ? RecommandProduct(
                                              productos: snapshot.data!,
                                              user: widget.user,
                                            )
                                          : Center(
                                              child: Image.asset(
                                                  'assets/ripple.gif'),
                                            );
                                    },
                                  ),
                                ],
                              )
                            : Padding(
                                padding: EdgeInsets.all(defaultsize! * 2),
                                child: GridView.builder(
                                  itemCount: productosResult.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: SizeConfig.orientation ==
                                            Orientation.portrait
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
                ),
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
          left: isSideMenuClosed ? 0 : 220,
          top: 16,
          child: MenuBtn(
            riveOnInit: (artboard) {
              StateMachineController controller = RiveUtils.getRiveController(
                  artboard,
                  stateMachineName: "State Machine");
              isSideBarClosed = controller.findSMI("isOpen") as SMIBool;
              isSideBarClosed.value = true;
            },
            press: () {
              isSideBarClosed.value = !isSideBarClosed.value;
              if (isSideMenuClosed) {
                _animationController.forward();
              } else {
                _animationController.reverse();
              }
              setState(() {
                isSideMenuClosed = isSideBarClosed.value;
              });
            },
          ),
        ),
      ]),
    );
  }
}

class MenuBtn extends StatefulWidget {
  const MenuBtn({
    Key? key,
    required this.press,
    required this.riveOnInit,
  }) : super(key: key);

  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;

  @override
  State<MenuBtn> createState() => _MenuBtnState();
}

class _MenuBtnState extends State<MenuBtn> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: widget.press,
        child: Container(
          margin: const EdgeInsets.only(
            left: 16,
          ),
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, offset: Offset(0, 3), blurRadius: 8)
              ]),
          child: RiveAnimation.asset(
            "assets/RiveAssets/menu_button.riv",
            onInit: widget.riveOnInit,
          ),
        ),
      ),
    );
  }
}
