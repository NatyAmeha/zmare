import 'package:flutter/cupertino.dart';

class MenuViewmodel {
  String text;
  String? subtitle;
  IconData icon;
  Function(int)? onClick;

  MenuViewmodel({
    required this.text,
    required this.icon,
    this.subtitle,
    this.onClick,
  });
}
