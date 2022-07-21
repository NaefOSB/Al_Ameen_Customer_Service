import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color color;
  final String fontFamily;
  final FontWeight fontWeight;
  final Alignment alignment;

  CustomText(
      {this.title = '',
      this.fontSize = 16.0,
      this.color = Colors.black,
      this.fontFamily = 'ElMessiri',
      this.fontWeight,
      this.alignment = Alignment.centerRight});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        title,
        style: TextStyle(
            color: color,
            fontSize: fontSize,
            fontFamily: fontFamily,
            fontWeight: fontWeight),
      ),
    );
  }
}
