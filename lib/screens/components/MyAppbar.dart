import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled1/screens/pages/CarritoPage.dart';
import 'package:untitled1/screens/pages/Contactos%20y%20Ayuda.dart';
import 'package:untitled1/screens/sessions/Actualizar.dart';

import '../../components/Constants.dart';
import '../../components/Size_Config.dart';
import '../../models/User.dart';
import '../../models/User_Cubit.dart';
import '../../server/Auth_Api.dart';
import '../../server/Carrito_Api.dart';
import '../pages/Principal.dart';
import '../pages/buscarProducto.dart';
import '../sessions/Login.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  bool isEditing = false;
  final bool _showDetails = false;

  void activateTextField() {
    setState(() {
      isEditing = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    User user = context.read<UserCubit>().state;
    double? defaultsize = SizeConfig.defaultSize;
    return Drawer(
      elevation: 0,
      backgroundColor: kprimaryColor,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: HexColor("#077c54")),
            accountName: Text('${user.first_name} ${user.last_name}'),
            accountEmail: Text('${user.email}'),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white24,
              // child: user.imagenUurl != null
              //     ? ClipOval(
              //         child: Image.network(
              //           user.imagenUurl!,
              //           width: 110,
              //           height: 110,
              //           fit: BoxFit.cover,
              //         ),
              //       )
              //     : const Icon(
              //         CupertinoIcons.person,
              //         color: Colors.white,
              //         size: 50,
              //       ),
            ),
            onDetailsPressed: () {
              setState(() {
                // _showDetails = !_showDetails;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ActualizarPage(),
                  ),
                );
              });
            },
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: _showDetails ? 20.0 : 0.0,
            child: _showDetails
                ? SlideTransition(
                    position: Tween<Offset>(
                            begin: const Offset(0, 0), end: Offset.zero)
                        .animate(
                      CurvedAnimation(
                        parent: kAlwaysDismissedAnimation,
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: SizedBox(
                      height: 20,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(defaultsize! * 1),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Colors.white24,
                                ),
                                SizedBox(
                                  width: defaultsize * 1,
                                ),
                                Text(
                                  '${user.first_name} ${user.last_name}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          const Divider(
                            color: Colors.white24,
                            height: 1,
                          ),
                        ],
                      ),
                    ),
                  )
                : null,
          ),
          ListTile(
            title: const Text(
              "Inicio",
              style: TextStyle(color: Colors.white),
            ),
            leading: const Icon(
              Icons.home,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Principal(),
                ),
              );
            },
          ),
          const Divider(
            color: Colors.white24,
            height: 1,
          ),
          ListTile(
            title: const Text(
              "Buscar",
              style: TextStyle(color: Colors.white),
            ),
            leading: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BuscarProducto(user: user),
                ),
              );
            },
          ),
          const Divider(
            color: Colors.white24,
            height: 1,
          ),
          ListTile(
            title: const Text(
              "Carrito",
              style: TextStyle(color: Colors.white),
            ),
            leading: const Icon(
              Icons.shopping_cart_sharp,
              color: Colors.white,
            ),
            onTap: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CarritoPage(),
                  ),
                );
              });
            },
          ),
          const Divider(
            color: Colors.white24,
            height: 1,
          ),
          ListTile(
            title: const Text(
              "Ayuda y Contacto",
              style: TextStyle(color: Colors.white),
            ),
            leading: const Icon(
              Icons.help,
              color: Colors.white,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Contactos_y_Ayuda(),
              ),
            ),
          ),
          const Divider(
            color: Colors.white24,
            height: 1,
          ),
          ListTile(
            title: const Text(
              "Cerrar Session",
              style: TextStyle(color: Colors.white),
            ),
            leading: const Icon(
              Icons.arrow_back_sharp,
              color: Colors.white,
            ),
            onTap: () async {
              logOut(user.token!);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.name,
    required this.email,
  }) : super(key: key);

  final String name, email;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(
          CupertinoIcons.person,
          color: Colors.white,
          size: 50,
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(color: Colors.white, fontSize: 25),
      ),
      subtitle: Text(
        email,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
    );
  }
}
