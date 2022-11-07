import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/song_controller.dart';

import 'package:zmare/modals/song.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/viewmodels/menu_viewmodel.dart';
import 'package:zmare/widget/custom_chip.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/song_widget.dart/song_list.dart';

class SongListScreen extends StatelessWidget {
  static const routName = "/songs";

  Map<String, dynamic>? args;

  SongListScreen({this.args});

  var songController = Get.put(SongController());

  @override
  Widget build(BuildContext context) {
    var type = args?["type"] as SongListDatatype?;
    var showFilter = (args?["showFilter"] as bool?) ?? false;
    var songs = args?["songs"] as List<Song>?;
    getSongList(type);
    return Scaffold(
      appBar: AppBar(
        title: CustomText(getTitle(type)),
        bottom: showFilter
            ? PreferredSize(
                preferredSize: const Size.fromHeight(100),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CustomChip(label: "Songs"),
                    CustomChip(label: "Album"),
                    CustomChip(label: "Playlists"),
                    CustomChip(label: "Artists")
                  ],
                ),
              )
            : null,
      ),
      body: songs?.isNotEmpty == true
          ? SongList(
              songs!,
              isSliver: false,
              showAds: songs.length > 5,
              adIndexs: UIHelper.selectAdIndex(songs.length),
            )
          : Obx(
              () => UIHelper.displayContent(
                showWhen: songController.songList != null,
                exception: songController.exception,
                isDataLoading: songController.isDataLoading,
                content: SongList(
                  songController.songList,
                  isSliver: false,
                  adIndexs: UIHelper.selectAdIndex(songs?.length ?? 0),
                  onClick: (song, index, selectedAction) {
                    songController.appController.startPlayingAudioFile(
                      songController.songList ?? [],
                      index: index,
                    );
                  },
                ),
              ),
            ),
      persistentFooterButtons: const [SizedBox(height: 60)],
    );
  }

  String getTitle(SongListDatatype? type) {
    if (type == SongListDatatype.USER_FAVORITE_SONGS) {
      return "Favorite songs";
    } else {
      return "Songs";
    }
  }

  getSongList(SongListDatatype? type) {
    switch (type) {
      case SongListDatatype.USER_FAVORITE_SONGS:
        songController.getUserFavoriteSongs();
        break;

      default:
        break;
    }
  }
}
