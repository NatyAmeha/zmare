import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zema/controller/album_controller.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/widget/album_widget/album_like_unlike_btn.dart';
import 'package:zema/widget/album_widget/album_playlist_header.dart';
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
    albumController.getAlbum(albumId);
    albumController.checkAlbumFavorite(albumId);

    return Scaffold(
      body: Obx(() {
        if (albumController.isDataLoading) {
          return LoadingProgressbar(
            loadingState: albumController.isDataLoading,
          );
        } else if (albumController.exception.message != null) {
          return ErrorPage(exception: albumController.exception);
        } else if (albumController.albumResult.id != null) {
          return buildPage();
        } else {
          return Container();
        }
      }),
    );
  }

  Widget buildPage() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 470,
          pinned: true,
          backgroundColor: Colors.white,
          title: CustomText(
            albumController.albumResult.name ?? "",
            color: Colors.black,
            maxLine: 1,
            overflow: TextOverflow.ellipsis,
          ),
          actions: [
            Obx(
              () => AlbumLikeUnlikeBtn(
                albumId: albumController.albumResult.id!,
                positiveAction: () {
                  albumController.likeAlbum(albumController.albumResult.id!);
                },
                negetiveAction: () {
                  albumController.unlikeAlbum(albumController.albumResult.id!);
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
                      images: [albumController.albumResult.artWork ?? ""],
                      title: albumController.albumResult.name ?? "",
                      actionText: "Start Playing",
                      size: 200,
                      subtitle: CustomText(
                          "${albumController.albumResult.favoriteCount} followers",
                          fontSize: 12)),
                  const Divider(thickness: 1)
                ],
              ),
            ),
          ),
        ),
        if (albumController.albumResult.songs?.isNotEmpty == true)
          SongList(
            albumController.albumResult.songs!
                .map((e) => Song.fromJson(e))
                .toList(),
          ),
      ],
    );
  }
}
