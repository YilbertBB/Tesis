import 'package:flutter/material.dart';

import '../../components/Constants.dart';
import '../../components/Size_Config.dart';

class TitleWithCustomUnderLine extends StatelessWidget {
  const TitleWithCustomUnderLine({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    double? defaultsize = SizeConfig.defaultSize;
    return SizedBox(
      height: 30,
      child: Stack(children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: defaultsize! / 4),
          child: Text(
            text,
            style: TextStyle(
              fontSize: defaultsize * 2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          bottom: 2,
          left: 0,
          right: 0,
          child: Container(
            margin: EdgeInsets.only(right: defaultsize / 4),
            height: 7,
            color: kprimaryColor.withOpacity(0.2),
          ),
        )
      ]),
    );
  }
}
