import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';

import 'components/Constants.dart';
import 'models/User.dart';
import 'models/User_Cubit.dart';
import 'screens/pages/Principal.dart';
import 'screens/sessions/Login.dart';
import 'server/Auth_Api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(User()),
      child: MaterialApp(
        title: 'ARShop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kprimaryColor,
          hintColor: kprimaryColor.withOpacity(0.4),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: "Intel",
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: HexColor('#8AD2AE')),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Color.fromARGB(255, 255, 255, 255),
            errorStyle: TextStyle(height: 0),
            border: defaultInputBorder,
            enabledBorder: defaultInputBorder,
            focusedBorder: defaultInputBorder,
            errorBorder: defaultInputBorder,
          ),
        ),
        home: FutureBuilder<Box>(
          future: Hive.openBox(tokenBox),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var box = snapshot.data;
              var token = box!.get('token');
              if (token != null) {
                return FutureBuilder<User?>(
                  future: getUser(token),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data != null) {
                        User user = snapshot.data!;
                        user.token = token;
                        context.read<UserCubit>().emit(user);
                        // context.read<UserCubit>();
                        return const Principal();
                      } else {
                        return const Login();
                      }
                    } else {
                      return const Login();
                    }
                  },
                );
              } else {
                return const Login();
              }
            } else if (snapshot.hasError) {
              return const Login();
            } else {
              return const Login();
            }
          },
        ),
      ),
    );
  }
}

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(
    color: Color(0xFFDEE3F2),
    width: 1,
  ),
);
