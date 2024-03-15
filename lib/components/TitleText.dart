import 'package:flutter/material.dart';
import 'package:untitled1/components/Size_Config.dart';

class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    double? defaultsize = SizeConfig.defaultSize;
    return Text(
      title,
      style: TextStyle(
        fontSize: defaultsize! * 1.6,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
