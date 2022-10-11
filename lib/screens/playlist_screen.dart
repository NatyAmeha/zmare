import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/playlist_controller.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/album_widget/album_playlist_header.dart';
import 'package:zmare/widget/custom_button.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/image_collection.dart';
import 'package:zmare/widget/song_widget.dart/song_list.dart';

class PlaylistScreen extends StatelessWidget {
  static const routeName = "/playlist/:id";
  PlaylistScreen({super.key});

  var playlistController = Get.put(PlaylistController());

  @override
  Widget build(BuildContext context) {
    var playlitsId = Get.parameters["id"];
    playlistController.getPlaylist(playlitsId!);
    return Scaffold(
      body: Obx(() => UIHelper.displayContent(
            showWhen: playlistController.playlistResult.name != null,
            exception: playlistController.exception,
            isDataLoading: playlistController.isDataLoading,
            content: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 470,
                  pinned: true,
                  backgroundColor: Colors.white,
                  title: CustomText(
                    playlistController.playlistResult.name ?? "",
                    color: Colors.black,
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        playlistController.downloadPlaylist();
                      },
                      icon: const Icon(Icons.download, color: Colors.grey),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite, color: Colors.grey),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert, color: Colors.grey),
                    )
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 120),
                        AlbumPlayListHeader(
                          images: playlistController.playlistImages ?? [],
                          title: playlistController.playlistResult.name ?? "",
                          actionText: "Start Playing",
                          size: 200,
                          onActionClick: () {
                            if (playlistController
                                    .playlistResult.songs?.isNotEmpty ==
                                true) {
                              playlistController.playPlaylist(
                                  playlistController.playlistSongs!);
                            }
                          },
                          subtitle: CustomText(
                            "${playlistController.playlistResult.followersId?.length ?? 0} followers",
                            fontSize: 12,
                          ),
                        ),
                        const Divider(thickness: 1)
                      ],
                    ),
                  ),
                ),
                if (playlistController.playlistResult.songs?.isNotEmpty == true)
                  SongList(
                    playlistController.playlistResult.songs!
                        .map((e) => Song.fromJson(e))
                        .toList(),
                  ),
              ],
            ),
          )),
    );
  }
}
