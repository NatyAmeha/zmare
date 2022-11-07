import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ShimmerContainer extends StatelessWidget {
  double width;
  double height;
  Widget? child;
  double radius;
  ShimmerContainer(
      {required this.width,
      required this.height,
      this.child,
      this.radius = 10});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(radius)),
      width: width,
      height: height,
      child: child,
    );
  }
}
