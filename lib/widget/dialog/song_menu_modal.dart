import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/viewmodels/menu_viewmodel.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/song_widget.dart/song_list_item.dart';

class SongMenuModal extends StatelessWidget {
  String? headerTitle;
  String? headerSubtitle;
  String? headerImage;
  List<MenuViewmodel> menuList;
  Function? onclick;

  var songController = Get.find<AppController>();
  SongMenuModal(
      {required this.menuList,
      this.headerTitle,
      this.headerSubtitle,
      this.headerImage,
      this.onclick});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildHeader(),
          const Divider(thickness: 1),
          menuList.isNotEmpty
              ? ListView.builder(
                  itemCount: menuList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                        onTap: () {
                          UIHelper.moveBack();
                          menuList[index].onClick?.call(index);
                        },
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        leading: Icon(menuList[index].icon),
                        title: CustomText(menuList[index].text),
                        subtitle: menuList[index].subtitle != null
                            ? CustomText(menuList[index].subtitle!)
                            : null);
                  },
                )
              : const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: CircularProgressIndicator(),
                )
        ],
      ),
    );
  }

  Widget buildHeader() {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      minVerticalPadding: 0,
      leading:
          CustomImage(headerImage, height: 50, width: 50, roundImage: true),
      title: CustomText(
        headerTitle ?? "",
        fontWeight: FontWeight.bold,
        fontSize: 17,
        maxLine: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: CustomText(headerSubtitle ?? "",
            fontSize: 13, maxLine: 1, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
