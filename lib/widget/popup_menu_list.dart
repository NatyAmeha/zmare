import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PopupMenu extends StatelessWidget {
  Map<String, Function?> menuList;
  List<IconData>? iconList;
  List<int> inActiveMenuIndexes;
  List<String> inActiveMenus;
  IconData? indicator;
  Color? indicatorColor;
  PopupMenu(
      {required this.menuList,
      this.iconList,
      this.indicator,
      this.inActiveMenus = const [],
      this.indicatorColor,
      this.inActiveMenuIndexes = const []});

  @override
  Widget build(BuildContext context) {
    menuList.removeWhere((key, value) => inActiveMenus.contains(key));
    return PopupMenuButton(
      icon: Icon(
        indicator ?? Icons.more_vert,
        color: indicatorColor,
        size: 30,
      ),
      itemBuilder: (context) => List.generate(
        menuList.length,
        (index) => PopupMenuItem(
          // enabled: !inActiveMenuIndexes.contains(index),
          onTap: () {
            menuList.values.toList()[index]?.call();
          },
          child: Row(
            children: [
              if (iconList?.isNotEmpty == true)
                Icon(
                  iconList![index],
                  color: Colors.grey,
                ),
              const SizedBox(width: 16),
              Text(menuList.keys.toList()[index])
            ],
          ),
        ),
      ),
    );
  }
}
