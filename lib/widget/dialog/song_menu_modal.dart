import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/viewmodels/menu_viewmodel.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/song_widget.dart/song_list_item.dart';

class SongMenuModal extends StatelessWidget {
  Song songInfo;
  String? headerTitle;
  String? headerSubtitle;
  String? headerImage;
  List<MenuViewmodel> menuList;
  AudioSrcType audioSrc;
  Function(int?)? onclick;

  var appController = Get.find<AppController>();
  SongMenuModal({
    required this.songInfo,
    required this.menuList,
    this.headerTitle,
    this.headerSubtitle,
    this.headerImage,
    this.audioSrc = AudioSrcType.NETWORK,
    this.onclick,
  });

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
                          switch (menuList[index].type) {
                            case MenuViewmodel.MENU_TYPE_LIKE_SONG:
                              appController.likeSong([songInfo.id!]);
                              onclick?.call(null);
                              break;
                            case MenuViewmodel.MENU_TYPE_UNLIKE_SONG:
                              appController.unlikeSong([songInfo.id!]);
                              onclick?.call(null);
                              break;
                            case MenuViewmodel.MENU_TYPE_DOWNLOAD_SONG:
                              appController.donwloadSingleSongs([songInfo]);
                              onclick?.call(null);
                              break;
                            case MenuViewmodel.MENU_TYPE_REMOVE_DOWNLOAD_SONG:
                              appController.removeDownloadedSongs([songInfo]);
                              onclick?.call(
                                  MenuViewmodel.MENU_TYPE_REMOVE_DOWNLOAD_SONG);
                              break;
                            case MenuViewmodel.MENU_TYPE_GO_TO_ALBUM:
                              print("album ${songInfo.album.toString()}");
                              if (songInfo.album != null) {
                                UIHelper.moveToScreen(
                                    "/album/${songInfo.album as String}");
                              } else {
                                UIHelper.showToast(
                                    context, "Unable to find album");
                              }
                              break;
                            case MenuViewmodel.MENU_TYPE_GO_TO_ARTIST:
                              UIHelper.moveToArtistScreen(
                                  songInfo.artists ?? [],
                                  songInfo.artistsName ?? []);
                              break;
                            case MenuViewmodel.MENU_TYPE_PLAY_SONG:
                              appController.startPlayingAudioFile([songInfo],
                                  src: audioSrc);
                              break;
                            case MenuViewmodel.MENU_TYPE_ADD_TO_QUEUE:
                              appController.addtoQueue(songInfo, src: audioSrc);
                              break;
                            default:
                          }
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
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
