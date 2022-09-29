import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zema/controller/app_controller.dart';
import 'package:zema/modals/album.dart';
import 'package:zema/modals/artist.dart';
import 'package:zema/screens/browse_screen.dart';
import 'package:zema/screens/player_screen.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/viewmodels/menu_viewmodel.dart';
import 'package:zema/widget/album_widget/album_list.dart';
import 'package:zema/widget/artist_widget/artist_list.dart';
import 'package:zema/widget/circle_tile.dart';
import 'package:zema/widget/error_page.dart';
import 'package:zema/widget/image_courousel.dart';
import 'package:zema/widget/list_header.dart';
import 'package:zema/widget/loading_progressbar.dart';
import 'package:zema/widget/playlist_widget/large_playlist_list_item.dart';
import 'package:zema/widget/screen_header.dart';
import 'package:zema/widget/song_widget.dart/song_list.dart';

import '../modals/song.dart';

class HomeScreen extends StatelessWidget {
  static const routName = "/home";

  var appController = Get.find<AppController>();

  HomeScreen({super.key});

  var songLists = [
    Song(title: "Song title 1", artistsName: ["Artist title 1"]),
    Song(title: "song no 2", artistsName: ["artist 2"]),
    Song(title: "short song title", artistsName: ["singers name info"]),
  ];

  var images = [
    "https://i.pinimg.com/736x/8a/b8/7b/8ab87bd6999d659eb282fbed00895d86--last-fm-album-cover.jpg",
    "https://imusician.imgix.net/images/how-to-make-an-album-cover.jpg?auto=compress&w=1200&h=630&fit=crop"
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (appController.isDataLoading) {
          return LoadingProgressbar(loadingState: appController.isDataLoading);
        } else if (appController.exception.message != null) {
          return ErrorPage(
            exception: appController.exception,
            action: () {
              appController.removeException();
              appController.getHomeData();
            },
          );
        } else if (appController.homeResult.newMusic?.isNotEmpty == true) {
          return buildPage();
        } else {
          return Container();
        }
      },
    );
  }

  Widget buildPage() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ScreenHeaderDart(),
              CircleTileList(
                image: const [
                  "https://i.pinimg.com/736x/8a/b8/7b/8ab87bd6999d659eb282fbed00895d86--last-fm-album-cover.jpg",
                  "https://imusician.imgix.net/images/how-to-make-an-album-cover.jpg?auto=compress&w=1200&h=630&fit=crop",
                  "https://i.pinimg.com/736x/8a/b8/7b/8ab87bd6999d659eb282fbed00895d86--last-fm-album-cover.jpg",
                  "https://imusician.imgix.net/images/how-to-make-an-album-cover.jpg?auto=compress&w=1200&h=630&fit=crop",
                ],
              ),
              Container(
                height: 250,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: appController.homeResult.topCharts!.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 16),
                  itemBuilder: (context, index) => LargePlaylistTile(
                      appController.homeResult.topCharts![index]),
                ),
              ),
            ],
          ),
        ),
        if (appController.homeResult.popularArtist?.isNotEmpty == true) ...[
          ListHeader("Artists you might like", topPadding: 32),
          SliverToBoxAdapter(
              child: ArtistList(
            appController.homeResult.popularArtist!,
          )),
        ],
        SliverToBoxAdapter(
          child: InkWell(
            onTap: () {
              Get.toNamed(BrowseScreen.routeName);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ImageCarousel(images: images, height: 250),
            ),
          ),
        ),
        ListHeader(
          "Popular songs",
          bottomPadding: 16,
          onClick: () {
            Get.toNamed(PlayerScreen.routeName);
          },
        ),
        SongList(songLists),
        if (appController.homeResult.newAlbum?.isNotEmpty == true) ...[
          ListHeader("Albums"),
          AlbumList(appController.homeResult.newAlbum!,
              isSliver: true, height: 250),
        ],
        ListHeader("Albums Horizontal list"),
        SliverToBoxAdapter(
          child: AlbumList(
            appController.homeResult.newAlbum!,
            listType: AlbumListType.ALBUM_HORIZONTAL_LIST,
            height: 200,
            width: 220,
          ),
        )
      ],
    );
  }
}
