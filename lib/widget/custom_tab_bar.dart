import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTabbar extends StatelessWidget implements PreferredSizeWidget {
  List<Widget> tabs;
  CustomTabbar(this.tabs);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: tabs,
      // indicatorSize: TabBarIndicatorSize.label,
      indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.blue),
      unselectedLabelColor: Colors.black,
      isScrollable: true,
      labelColor: Colors.white,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}
