import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/viewmodels/menu_viewmodel.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/song_widget.dart/song_list_item.dart';

class SongMenuModal extends StatelessWidget {
  Song song;
  List<MenuViewmodel> menuList;
  SongMenuModal({required this.song, required this.menuList});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SongListItem(index: 1, song, showMore: false),
          const Divider(thickness: 1),
          ListView.builder(
            itemCount: menuList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                leading: Icon(menuList[index].icon),
                title: CustomText(menuList[index].text),
                subtitle: menuList[index].subtitle != null
                    ? CustomText(menuList[index].subtitle!)
                    : null),
          ),
        ],
      ),
    );
  }
}
