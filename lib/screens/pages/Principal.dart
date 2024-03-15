import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/Constants.dart';
import '../../components/Size_Config.dart';
import '../../models/User.dart';
import '../../models/User_Cubit.dart';
import '../components/Body.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  @override
  Widget build(BuildContext context) {
    User user = context.read<UserCubit>().state;
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kprimaryColor,
      body: MyBody(user: user),
    );
  }
}
