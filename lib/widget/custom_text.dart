import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomText extends StatelessWidget {
  String text;
  double fontSize;
  FontWeight? fontWeight;
  Color? color;
  TextAlign? alignment;
  int maxLine;
  TextOverflow? overflow;
  CustomText(this.text,
      {this.fontSize = 16,
      this.fontWeight,
      this.color,
      this.alignment,
      this.maxLine = 10,
      this.overflow});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
      textAlign: alignment,
      maxLines: maxLine,
      overflow: overflow,
    );
  }
}
