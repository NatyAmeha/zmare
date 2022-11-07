import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class IconOptionList extends StatelessWidget {
  List<Widget> widgets;
  List<Function> actions;
  int selectedWidgetIndex;
  bool isLoading;
  bool showAllOptions;
  IconOptionList(
      {required this.widgets,
      required this.actions,
      this.selectedWidgetIndex = 0,
      this.showAllOptions = false,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: 10,
        child: CircularProgressIndicator(),
      );
    } else {
      return InkWell(
          onTap: () {
            actions[selectedWidgetIndex].call();
          },
          child: widgets[selectedWidgetIndex]);
    }
  }
}
