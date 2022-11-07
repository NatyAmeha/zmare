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
      padding: const EdgeInsets.all(16),
      // indicatorSize: TabBarIndicatorSize.label,
      indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Theme.of(context).colorScheme.primary),
      unselectedLabelColor: Colors.grey,
      isScrollable: true,
      // labelColor: Theme.of(context).colorScheme.primary,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}
