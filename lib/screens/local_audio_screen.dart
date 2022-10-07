import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:zema/controller/app_controller.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/utils/ui_helper.dart';
import 'package:zema/widget/album_widget/album_list.dart';
import 'package:zema/widget/artist_widget/artist_list.dart';
import 'package:zema/widget/custom_container.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/playlist_widget/playlist_list.dart';
import 'package:zema/widget/song_widget.dart/local_song_list_item.dart';
import 'package:zema/widget/song_widget.dart/song_list.dart';

class LocalAudioScreen extends StatelessWidget {
  static const routeName = "/local_audio";
  var appController = Get.find<AppController>();
  LocalAudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (appController.localAudioFiles == null) {
        appController.getLocalAudioFiles();
      }
    });

    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: CustomText("Local audios"),
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey[400],
            isScrollable: true,
            tabs: const [
              Tab(text: "Playlists"),
              Tab(text: "Albums"),
              Tab(text: "Artists"),
              Tab(text: "Songs")
            ],
          ),
        ),
        body: Obx(
          () => UIHelper.displayContent(
            showWhen: true,
            isDataLoading: appController.isDataLoading,
            exception: appController.exception,
            content: TabBarView(
              children: [
                buildTabItem(
                    PlaylistList(
                      appController.localAudioFiles?.playlists,
                      src: AudioSrcType.LOCAL_STORAGE,
                      listType: PlaylistListType.GRID,
                      height: 200,
                    ),
                    appController.localAudioFiles?.playlists?.length ?? 0,
                    "Create Playlist",
                    iconData: Icons.add,
                    onActionClick: () {}),
                buildTabItem(
                    AlbumList(
                      appController.localAudioFiles?.albums,
                      isSliver: false,
                      listType: AlbumListType.ALBUM_GRID_LIST,
                      src: AudioSrcType.LOCAL_STORAGE,
                      height: 250,
                    ),
                    appController.localAudioFiles?.albums?.length ?? 0,
                    "No Album found",
                    onActionClick: () {}),
                buildTabItem(
                    ArtistList(
                      appController.localAudioFiles?.artists,
                      type: ArtistListType.ARTIST_GRID_LIST,
                      src: AudioSrcType.LOCAL_STORAGE,
                    ),
                    appController.localAudioFiles?.albums?.length ?? 0,
                    "No Artist found",
                    onActionClick: () {}),
                buildTabItem(
                    SongList(appController.localAudioFiles?.songs,
                        isSliver: false),
                    appController.localAudioFiles?.albums?.length ?? 0,
                    "No Song found",
                    onActionClick: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTabItem(Widget widget, int listLength, String actionText,
      {Function? onActionClick, IconData iconData = Icons.hourglass_empty}) {
    if (listLength > 0) {
      return widget;
    } else {
      return Center(
        child: CustomContainer(
          color: Colors.grey[200],
          height: 200,
          width: 200,
          onTap: () {
            onActionClick?.call();
          },
          borderRadius: 16,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(iconData, size: 60),
            const SizedBox(height: 16),
            CustomText(actionText, fontSize: 16)
          ]),
        ),
      );
    }
  }
}