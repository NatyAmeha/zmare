import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/controller/playlist_controller.dart';
import 'package:zmare/controller/song_controller.dart';
import 'package:zmare/modals/playlist.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/custom_button.dart';
import 'package:zmare/widget/custom_tab_view.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/song_widget.dart/song_list.dart';

class SongListViewpagerScreen extends StatelessWidget {
  static const routeName = "/song_recommendation";
  SongListViewpagerScreen({super.key});

  var songController = Get.put(SongController());

  var playlistController = Get.find<PlaylistController>();
  var appbarTitle = "Select songs";

  var isPlaylistPUblick = true;

  @override
  Widget build(BuildContext context) {
    var args = Get.arguments;
    var playlistName = args["playlist_name"] as String;
    isPlaylistPUblick = args["is_public"] as bool? ?? true;
    Future.delayed(Duration.zero, () {
      playlistController.getSongRecommendation();
    });
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => CustomText(
            songController.selectedSongsForPlaylist.value.isNotEmpty
                ? "${songController.selectedSongsForPlaylist.value.length} songs"
                : appbarTitle,
          ),
        ),
      ),
      body: Obx(
        () => UIHelper.displayContent(
          showWhen: playlistController.recommendation != null,
          exception: playlistController.exception,
          isDataLoading: playlistController.isDataLoading,
          content: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: CustomTabView(
              // height: double.infinity,

              isSliver: false,
              tabs: const [
                Tab(text: "Popular songs"),
                Tab(text: "Most liked songs"),
                Tab(text: "New songs"),
              ],
              contents: [
                CustomTabContent(
                  Expanded(
                    child: Obx(
                      () => SongList(
                        playlistController.recommendation?.topSongs,
                        isSliver: false,
                        showAds: false,
                        selectedSongIds: songController.selecteSongIds,
                        selectionState: ListSelectionState.MULTI_SELECTION,
                        onClick: (song, _, __) {
                          songController.addOrRemoveSongId(song);
                        },
                      ),
                    ),
                  ),
                ),
                CustomTabContent(
                  Expanded(
                    child: Obx(
                      () => SongList(
                        playlistController.recommendation?.likedSongs,
                        isSliver: false,
                        showAds: false,
                        selectedSongIds: songController.selecteSongIds,
                        selectionState: ListSelectionState.MULTI_SELECTION,
                        onClick: (song, _, __) {
                          songController.addOrRemoveSongId(song);
                        },
                      ),
                    ),
                  ),
                ),
                CustomTabContent(
                  Expanded(
                    child: Obx(
                      () => SongList(
                        playlistController.recommendation?.newSongs,
                        isSliver: false,
                        showAds: false,
                        selectedSongIds: songController.selecteSongIds,
                        selectionState: ListSelectionState.MULTI_SELECTION,
                        onClick: (song, _, __) {
                          songController.addOrRemoveSongId(song);
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomButton("Create Playlist",
              buttonType: ButtonType.ROUND_ELEVATED_BUTTON,
              onPressed: () async {
            var playlistINfo = Playlist(
                name: playlistName,
                songs: songController.selecteSongIds,
                isPublic: isPlaylistPUblick,
                coverImagePath:
                    songController.selecteSongImages.take(4).toList());
            var playlistResult =
                await playlistController.createPlaylist(playlistINfo);
            if (playlistResult != null) {
              UIHelper.moveBack();
              UIHelper.moveToScreen("/playlist/${playlistResult.id!}",
                  navigatorId: UIHelper.bottomNavigatorKeyId);
            }
          }),
        )
      ],
    );
  }
}
