import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/playlist_controller.dart';
import 'package:zmare/modals/playlist.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/album_widget/album_playlist_header.dart';
import 'package:zmare/widget/custom_button.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/image_collection.dart';
import 'package:zmare/widget/loading_widget/album_playlist_shimmer.dart';
import 'package:zmare/widget/popup_menu_list.dart';
import 'package:zmare/widget/song_widget.dart/song_list.dart';

class PlaylistScreen extends StatelessWidget {
  static const routeName = "/playlist/:id";

  String? playlistId;
  Playlist? playlistInfo;

  PlaylistScreen({this.playlistId, this.playlistInfo});

  var playlistController = Get.put(PlaylistController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (playlistInfo != null) {
        playlistController.getPlaylistSongs(playlistInfo!);
      } else if (playlistId != null) {
        playlistController.getPlaylist(playlistId!);
        playlistController.checkPlaylistInFavorite(playlistId!);
      }
    });

    return Scaffold(
      body: Obx(() => UIHelper.displayContent(
            showWhen: playlistController.playlistResult != null,
            exception: playlistController.exception,
            isDataLoading: playlistController.isDataLoading,
            loadingWidget: const AlbumPlaylistShimmer(),
            content: CustomScrollView(
              slivers: [
                FutureBuilder(
                    initialData: null,
                    future: UIHelper.generateColorFromImage(
                        playlistController.playlistImages?.first),
                    builder: (context, snapshot) {
                      return SliverAppBar(
                        expandedHeight: 470,
                        pinned: true,
                        title: CustomText(
                          playlistController.playlistResult?.name ?? "",
                        ),
                        actions: [
                          Obx(
                            () => PopupMenu(
                              menuList: {
                                "Follow": () {
                                  playlistController.followPlaylist(
                                      playlistController.playlistResult!.id!);
                                },
                                "Unfollow": () {
                                  playlistController.unfollowPlaylist(
                                      playlistController.playlistResult!.id!);
                                },
                                "Download": () {
                                  playlistController.downloadPlaylist();
                                },
                                "Remove download": () {}
                              },
                              iconList: [
                                playlistController.isFavoritePlaylist
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                playlistController.isPlaylistDownloaded
                                    ? Icons.remove
                                    : Icons.download
                              ],
                              inActiveMenus: [
                                playlistController.isFavoritePlaylist
                                    ? "Follow"
                                    : "Unfollow",
                                playlistController.isPlaylistDownloaded
                                    ? "Download"
                                    : "Remove download"
                              ],
                            ),
                          ),
                        ],
                        flexibleSpace: CustomContainer(
                          gradientColor: snapshot.data?.lightMutedColor != null
                              ? [
                                  snapshot.data!.lightMutedColor!.color,
                                  Theme.of(context).scaffoldBackgroundColor,
                                ]
                              : null,
                          child: FlexibleSpaceBar(
                            background: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 120),
                                AlbumPlayListHeader(
                                  images:
                                      playlistController.playlistImages ?? [],
                                  title:
                                      playlistController.playlistResult?.name ??
                                          "",
                                  actionText: "Shuffle playlist",
                                  size: 200,
                                  onActionClick: () {
                                    if (playlistController
                                            .playlistSongs.isNotEmpty ==
                                        true) {
                                      var songs =
                                          playlistController.playlistSongs;
                                      songs.shuffle();

                                      playlistController.appController
                                          .startPlayingAudioFile(songs);
                                    }
                                  },
                                  subtitle: CustomText(
                                    "${playlistController.playlistResult?.followersId?.length ?? 0} followers",
                                    fontSize: 12,
                                  ),
                                ),
                                // const Divider(thickness: 1)
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                if (playlistController.playlistSongs.isNotEmpty == true)
                  SongList(
                    playlistController.playlistSongs,
                    adIndexs: UIHelper.selectAdIndex(
                        playlistController.playlistSongs.length),
                  ),
                const SliverToBoxAdapter(child: SizedBox(height: 100))
              ],
            ),
          )),
    );
  }
}
