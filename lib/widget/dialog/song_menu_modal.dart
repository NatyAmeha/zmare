import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:zema/controller/app_controller.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/viewmodels/menu_viewmodel.dart';
import 'package:zema/widget/album_widget/album_like_unlike_btn.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/song_widget.dart/song_list_item.dart';

class SongMenuModal extends StatelessWidget {
  Song song;
  bool? songLikeState;
  bool? albumLikeState;
  bool? songdownloadState;
  bool showProgress;
  List<int> activeMenusIndx;
  List<MenuViewmodel> menuList;

  var songController = Get.find<AppController>();
  SongMenuModal({
    required this.song,
    required this.menuList,
    this.showProgress = true,
    required this.activeMenusIndx,
  });

  @override
  Widget build(BuildContext context) {
    return showProgress
        ? SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SongListItem(index: 1, song, showMore: false),
                const Divider(thickness: 1),
                ListView.builder(
                  itemCount: menuList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (activeMenusIndx.contains(index) == true) {
                      return ListTile(
                          onTap: () {
                            Get.back();
                            menuList[index]
                                .actions
                                ?.elementAt(menuList[index].selectedOption)
                                .call();
                          },
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          leading: Icon(menuList[index]
                              .icon[menuList[index].selectedOption]),
                          title: CustomText(menuList[index]
                              .text[menuList[index].selectedOption]),
                          subtitle: menuList[index].subtitle != null
                              ? CustomText(menuList[index]
                                  .subtitle![menuList[index].selectedOption])
                              : null);
                    } else {
                      return const SizedBox(height: 0);
                    }
                  },
                ),
              ],
            ),
          )
        : Container(
            height: 200,
            child: const Center(child: CircularProgressIndicator()),
          );
  }
}
