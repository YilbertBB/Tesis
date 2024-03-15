import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/Header.dart';
import '../../components/Theme_Helper.dart';
import '../../models/User.dart';
import '../../models/User_Cubit.dart';
import '../../server/Auth_Api.dart';
import '../pages/Principal.dart';
import 'Forgot_Password.dart';
import 'Register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final double _headerHeigth = 250;
  final Key _formKey = GlobalKey<FormState>();
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: _headerHeigth,
              child: HeaderWidget(_headerHeigth, true, Icons.login_rounded),
            ),
            SafeArea(
                child: Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                children: [
                  const Text(
                    'Bienvenido',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Entre su cuenta',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 30.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextField(
                          controller: emailControler,
                          decoration: ThemeHelper().textInputDecoration(
                            "Email",
                            "Entre su Email",
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 30.0),
                        TextField(
                          controller: passwordControler,
                          obscureText: !showPassword,
                          decoration: ThemeHelper().textInputDecorationPassword(
                            "Contraseña",
                            "Entre su Contraseña",
                            showPassword,
                            () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        GestureDetector(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                            alignment: Alignment.topRight,
                            child: const Text(
                              'Olvidaste la contraseña?',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const Forgot_Password_page(),
                              ),
                            );
                          },
                        ),
                        Container(
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                'Entrar'.toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            onPressed: () async {
                              try {
                                var authRes = await userAuth(
                                    emailControler.text,
                                    passwordControler.text);

                                if (authRes.runtimeType == String) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(authRes),
                                    ),
                                  );
                                } else if (authRes.runtimeType == User) {
                                  User user = authRes;
                                  context.read<UserCubit>().emit(user);
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Principal()),
                                      (Route<dynamic> route) => false);
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Error de conexion'),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                          //child: const Text( '),
                          child: Text.rich(TextSpan(children: [
                            const TextSpan(
                                text: 'No tienes cuenta? ',
                                style: TextStyle(fontSize: 15)),
                            TextSpan(
                              text: ' Crear',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                           RegistrationPage(),
                                    ),
                                  );
                                },
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            )
                          ])),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
