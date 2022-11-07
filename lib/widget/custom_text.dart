import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomText extends StatelessWidget {
  String text;
  double? fontSize;
  FontWeight? fontWeight;
  Color? color;
  TextAlign? alignment;
  int maxLine;
  TextOverflow? overflow;
  TextStyle? textStyle;
  CustomText(
    this.text, {
    this.fontSize,
    this.fontWeight,
    this.color,
    this.alignment,
    this.maxLine = 10,
    this.overflow,
    this.textStyle,
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle?.copyWith(color: color, fontSize: fontSize),
      textAlign: alignment,
      maxLines: maxLine,
      overflow: overflow,
    );
  }
}
