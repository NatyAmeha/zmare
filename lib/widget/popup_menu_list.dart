import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PopupMenu extends StatelessWidget {
  Map<String, Function?> menuList;
  List<IconData>? iconList;
  List<int> inActiveMenuIndexes;
  IconData? indicator;
  PopupMenu(
      {required this.menuList,
      this.iconList,
      this.indicator,
      this.inActiveMenuIndexes = const []});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: Icon(indicator ?? Icons.more_vert),
      itemBuilder: (context) => List.generate(
        menuList.length,
        (index) => PopupMenuItem(
          enabled: !inActiveMenuIndexes.contains(index),
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
