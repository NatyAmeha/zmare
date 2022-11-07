import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PlayerControlIcon extends StatelessWidget {
  double size;
  IconData icon;
  Function? onclick;
  PlayerControlIcon({this.size = 25, required this.icon, this.onclick});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: InkWell(
        onTap: () {
          onclick?.call();
        },
        child: Icon(
          icon,
          size: size,
        ),
      ),
    );
  }
}
