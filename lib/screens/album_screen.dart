import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:zmare/controller/album_controller.dart';
import 'package:zmare/modals/album.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/album_widget/album_like_unlike_btn.dart';
import 'package:zmare/widget/album_widget/album_playlist_header.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/error_page.dart';
import 'package:zmare/widget/icon_option_list.dart';
import 'package:zmare/widget/loading_progressbar.dart';
import 'package:zmare/widget/loading_widget/album_playlist_shimmer.dart';
import 'package:zmare/widget/popup_menu_list.dart';
import 'package:zmare/widget/song_widget.dart/song_list.dart';

class AlbumScreen extends StatelessWidget {
  static const routName = "/album/:id";

  String albumId;
  Map<String, dynamic>? args;

  AlbumScreen({required this.albumId, this.args});

  var albumController = Get.put(AlbumController());

  @override
  Widget build(BuildContext context) {
    if (albumController.albumResult == null) {
      Future.delayed(Duration.zero, () {
        getData();
      });
    }

    return Scaffold(
      body: Obx(() => UIHelper.displayContent(
            showWhen: albumController.albumResult != null,
            exception: albumController.exception,
            isDataLoading: albumController.isDataLoading,
            loadingWidget: const AlbumPlaylistShimmer(),
            content: buildPage(),
          )),
    );
  }

  getData() {
    // var albumId = Get.parameters["id"]!;
    print("album id ${albumId}");
    // var args = Get.arguments as Map<String, dynamic>?;
    var albumSrcType = args?["src"] as AudioSrcType? ?? AudioSrcType.NETWORK;
    var albumInfo = args?["album_info"] as Album?;
    switch (albumSrcType) {
      case AudioSrcType.NETWORK:
        albumController.getAlbum(albumId);
        break;
      case AudioSrcType.LOCAL_STORAGE:
        albumController.getAlbumFromLocalStorage(albumInfo!);
        break;

      default:
    }

    albumController.checkAlbumFavorite(albumId);
  }

  Widget buildPage() {
    // var args = Get.arguments as Map<String, dynamic>;
    var scrollController = ScrollController();
    var albumSrcType = args?["src"] as AudioSrcType?;
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        FutureBuilder(
          initialData: null,
          future: UIHelper.generateColorFromImage(
              albumController.albumResult?.artWork),
          builder: (context, snapshot) {
            return SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.55,
              pinned: true,
              title: CustomText(
                albumController.albumResult?.name ?? "",
                maxLine: 1,
                overflow: TextOverflow.ellipsis,
              ),
              actions: albumSrcType == AudioSrcType.NETWORK
                  ? [
                      Obx(
                        () => IconOptionList(
                          widgets: const [
                            Icon(
                              Icons.favorite_outline,
                            ),
                            Icon(
                              Icons.favorite,
                            )
                          ],
                          actions: [
                            () {
                              albumController
                                  .likeAlbum(albumController.albumResult!.id!);
                            },
                            () {
                              albumController.unlikeAlbum(
                                  albumController.albumResult!.id!);
                            },
                          ],
                          isLoading: albumController.isLoading,
                          selectedWidgetIndex:
                              albumController.isFavoriteAlbum ? 1 : 0,
                        ),
                      ),
                      Obx(
                        () => PopupMenu(
                          menuList: {
                            "Download": () {
                              albumController.downloadAlbum(
                                  albumController.albumResult!.songs!
                                      .cast<Song>(),
                                  albumController.albumResult!.id!,
                                  albumController.albumResult!.name!);
                            },
                            "Remove Download": () {},
                            "Go to Artists": () {}
                          },
                          iconList: [
                            albumController.isAlbumDownloaded
                                ? Icons.remove
                                : Icons.download,
                            Icons.person
                          ],
                          inActiveMenus: [
                            albumController.isAlbumDownloaded
                                ? "Download"
                                : "Remove Download"
                          ],
                        ),
                      ),
                    ]
                  : [],
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
                      const SizedBox(height: 100),
                      AlbumPlayListHeader(
                        images: albumSrcType == AudioSrcType.LOCAL_STORAGE
                            ? null
                            : [albumController.albumResult?.artWork ?? ""],
                        title: albumController.albumResult?.name ?? "",
                        actionText: "Shuffle songs",
                        onActionClick: () {
                          var songs =
                              albumController.albumResult!.songs?.cast<Song>();
                          songs?.shuffle();
                          albumController.appController
                              .startPlayingAudioFile(songs!, src: albumSrcType);
                        },
                        size: 200,
                        leading: albumSrcType == AudioSrcType.LOCAL_STORAGE
                            ? QueryArtworkWidget(
                                id: int.parse(albumController.albumResult!.id!),
                                type: ArtworkType.ALBUM,
                                artworkWidth: 200,
                                artworkHeight: 200,
                                nullArtworkWidget: CustomImage(
                                  null,
                                  roundImage: true,
                                  height: 200,
                                  width: 200,
                                ),
                              )
                            : null,
                        subtitle: CustomText(
                          "${albumController.albumResult?.favoriteCount ?? albumController.albumResult?.songs?.length ?? 0} ${albumController.albumResult?.favoriteCount != null ? 'Likes' : 'Songs'}",
                          textStyle: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        if (albumController.albumResult?.songs?.isNotEmpty == true)
          SongList(
            albumController.albumResult!.songs?.cast<Song>(),
            showAds: albumController.albumResult!.songs!.length >= 3,
            adIndexs: UIHelper.selectAdIndex(
                albumController.albumResult!.songs!.length),
            src: albumSrcType ?? AudioSrcType.NETWORK,
          ),
        const SliverToBoxAdapter(child: SizedBox(height: 100))
      ],
    );
  }
}
