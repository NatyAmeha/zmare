import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/playlist_controller.dart';
import 'package:zmare/modals/playlist.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/dialog/create_playlist_dialog.dart';
import 'package:zmare/widget/playlist_widget/playlist_list.dart';

class PlaylistListScreen extends StatelessWidget {
  Map<String, dynamic>? args;
  PlaylistListScreen({super.key, this.args});

  static const routName = "/playlist_list";

  var playlistController = Get.put(PlaylistController());

  @override
  Widget build(BuildContext context) {
    var arguments = args ?? Get.arguments as Map<String, dynamic>?;
    var dataType = arguments?["type"] as PlaylistListDatatype? ??
        PlaylistListDatatype.CHARTS;

    var playlists = arguments?["playlists"] as List<Playlist>?;
    getPlaylists(dataType);
    return Scaffold(
      appBar: AppBar(
        title: CustomText("Playlists"),
        actions: [
          IconButton(
              onPressed: () {
                UIHelper.showBottomSheet(CreatePlaylistDialog(),
                    dismissable: false, scrollControlled: true);
              },
              icon: Icon(Icons.add, color: Colors.grey))
        ],
      ),
      body: playlists?.isNotEmpty == true
          ? PlaylistList(
              playlists!,
              listType: PlaylistListType.GRID,
              height: 300,
            )
          : Obx(
              () => UIHelper.displayContent(
                showWhen: playlistController.playlists != null,
                exception: playlistController.exception,
                isDataLoading: playlistController.isDataLoading,
                content: Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: PlaylistList(
                    playlistController.playlists,
                    listType: PlaylistListType.GRID,
                    height: 300,
                  ),
                ),
              ),
            ),
    );
  }

  getPlaylists(PlaylistListDatatype type) {
    switch (type) {
      case PlaylistListDatatype.USER_FAVORITE_PLAYLIST:
        playlistController.getUserFavoritePlaylists();
        break;

      default:
        break;
    }
  }
}
