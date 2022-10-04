import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:zema/controller/album_controller.dart';
import 'package:zema/modals/album.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/utils/ui_helper.dart';
import 'package:zema/widget/album_widget/album_like_unlike_btn.dart';
import 'package:zema/widget/album_widget/album_playlist_header.dart';
import 'package:zema/widget/custom_image.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/error_page.dart';
import 'package:zema/widget/loading_progressbar.dart';
import 'package:zema/widget/song_widget.dart/song_list.dart';

class AlbumScreen extends StatelessWidget {
  static const routName = "/album/:id";

  AlbumScreen({super.key});

  var albumController = Get.put(AlbumController());

  @override
  Widget build(BuildContext context) {
    var albumId = Get.parameters["id"]!;
    var args = Get.arguments as Map<String, dynamic>;
    var albumSrcType = args["src"] as AudioSrcType;
    var albumInfo = args["album_info"] as Album?;
    print("src ${albumSrcType} ${albumId}");
    print(albumInfo?.name);
    if (albumController.albumResult == null) {
      switch (albumSrcType) {
        case AudioSrcType.NETWORK:
          albumController.getAlbum(albumId);
          break;
        case AudioSrcType.LOCAL_STORAGE:
          albumController.getAlbumFromLocalStorage(albumInfo!);
          break;

        default:
      }
    }

    albumController.checkAlbumFavorite(albumId);

    return Scaffold(
      body: Obx(() => UIHelper.displayContent(
              showWhen: true,
              exception: albumController.exception,
              isDataLoading: albumController.isDataLoading,
              content: buildPage(albumSrcType))
          // {
          // if (albumController.isDataLoading) {
          //   return LoadingProgressbar(
          //     loadingState: albumController.isDataLoading,
          //   );
          // } else if (albumController.exception.message != null) {
          //   return ErrorPage(exception: albumController.exception);
          // } else if (albumController.albumResult.id != null) {
          //   return buildPage();
          // } else {
          //   return Container();
          // }
          // }
          ),
    );
  }

  Widget buildPage(AudioSrcType src) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 470,
          pinned: true,
          backgroundColor: Colors.white,
          title: CustomText(
            albumController.albumResult?.name ?? "",
            color: Colors.black,
            maxLine: 1,
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            Obx(
              () => AlbumLikeUnlikeBtn(
                albumId: albumController.albumResult!.id!,
                positiveAction: () {
                  albumController.likeAlbum(albumController.albumResult!.id!);
                },
                negetiveAction: () {
                  albumController.unlikeAlbum(albumController.albumResult!.id!);
                },
                isLoading: albumController.isLoading,
                state: albumController.isFavoriteAlbum,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.grey,
              ),
            )
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              // alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 120),
                  AlbumPlayListHeader(
                      images: src == AudioSrcType.LOCAL_STORAGE
                          ? null
                          : [albumController.albumResult?.artWork ?? ""],
                      title: albumController.albumResult?.name ?? "",
                      actionText: "Start Playing",
                      size: 200,
                      leading: src == AudioSrcType.LOCAL_STORAGE
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
                          "${albumController.albumResult?.favoriteCount} followers",
                          fontSize: 12)),
                  const Divider(thickness: 1)
                ],
              ),
            ),
          ),
        ),
        if (albumController.albumResult?.songs?.isNotEmpty == true)
          src == AudioSrcType.NETWORK
              ? SongList(
                  albumController.albumResult!.songs!
                      .map((e) => Song.fromJson(e))
                      .toList(),
                )
              : SongList(albumController.albumResult!.songs?.cast<Song>())
      ],
    );
  }
}
