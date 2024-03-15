import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../components/Constants.dart';
import '../../components/Size_Config.dart';
import '../../components/Theme_Helper.dart';

class Contactos_y_Ayuda extends StatelessWidget {
  Contactos_y_Ayuda({super.key});

  final bool _pinned = true;

  final bool _snap = false;

  final bool _floating = false;
  final TextEditingController comentarioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double? defaultsize = SizeConfig.defaultSize;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0,
            backgroundColor: kprimaryColor,
            title: const Text(
              'Ayuda y Contacto',
              style: TextStyle(fontWeight: FontWeight.bold),
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
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 150.0,
            flexibleSpace: Padding(
              padding: EdgeInsets.only(top: defaultsize! * 2),
              child: FlexibleSpaceBar(
                  background: Image.asset('assets/icons/ic_launcher.png')),
            ),
          ),
          SliverFillRemaining(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Contáctenos',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Email:  ',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              'xetid@gmail.com',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Telèfono:  ',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              '55555555',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Dirección:  ',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              'Santiago de Cuba, Cubass',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: defaultsize * 1),
                  const Divider(
                    height: 2,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Text(
                            'Guia',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                          ),
                          const Text(
                            '¡Bienvenido a nuestra app de muebles con realidad aumentada! \n\n\n¡Estamos encantados de que estés explorando nuestra increíble colección de muebles utilizando la emocionante tecnología de Realidad Aumentada! \nQueremos que tu experiencia sea lo más placentera y sencilla posible, por eso hemos preparado esta guía para ayudarte a sacar el máximo provecho de nuestra app. \n\nPaso 1: Explora nuestra colección \nNavega a través de nuestra amplia gama de muebles, desde sofás y mesas hasta lámparas y decoraciones para el hogar. Encuentra el producto que te llame la atención y te gustaría ver en tu propio espacio. \n\nPaso 2: Visualiza los muebles en tu hogar \nUna vez que hayas seleccionado un mueble que te interese, haz clic en el botón "Visualizar 3D". Esto abrirá la función de realidad aumentada, donde podrás visualizar el mueble en tu entorno real. ¡Puedes probar diferentes ubicaciones y ver cómo se adapta a tu espacio! \n\nPaso 3: Encuentra tu ajuste perfecto \nUna vez que estés satisfecho con cómo se ve el mueble en tu entorno, echa un vistazo a las opciones de compra. \n\nPaso 4: ¡Comparte tu experiencia! \n¡Nos encantaría ver cómo utilizas nuestra app para transformar tu hogar! Siéntete libre de compartir tus experiencias en las redes sociales. Nos encantaría ver cómo has integrado nuestros muebles en tu espacio. \n\n¿Necesitas ayuda adicional? \nSi en algún momento necesitas asistencia adicional, un equipo de soporte altamente capacitado está aquí para ayudarte. No dudes en contactarnos a través de la sección de soporte dentro de la app. Estamos aquí para garantizar que tu experiencia con la realidad aumentada sea perfecta. \n\nGracias por elegir nuestra app para elegir tus muebles. ¡Esperamos que disfrutes explorando nuestra colección y creando el hogar de tus sueños con la realidad aumentada! \n\n\n¡Diviértete explorando!',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: defaultsize * 1),
                  const Divider(
                    height: 2,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'Comenta',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration:
                                ThemeHelper().inputBoxDecorationShaddow(),
                            child: TextFormField(
                              controller: comentarioController,
                              decoration: ThemeHelper().textInputDecoration(
                                  "Danos tu opinion", "Escribir"),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            decoration:
                                ThemeHelper().buttonBoxDecoration(context),
                            child: ElevatedButton(
                              style: ThemeHelper().buttonStyle(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                child: Text(
                                  "Enviar".toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
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
