import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/album_widget/album_list.dart';
import 'package:zmare/widget/artist_widget/artist_list.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/playlist_widget/playlist_list.dart';
import 'package:zmare/widget/song_widget.dart/local_song_list_item.dart';
import 'package:zmare/widget/song_widget.dart/song_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          title: CustomText("Local audios", fontSize: 20),
          leading: const Icon(Icons.library_books),
          bottom: TabBar(
            isScrollable: true,
            labelColor: Theme.of(context).colorScheme.primary,
            indicatorColor: Colors.green,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                text: AppLocalizations.of(context)!.album,
              ),
              Tab(text: AppLocalizations.of(context)!.artist),
              Tab(text: "Songs"),
              Tab(text: AppLocalizations.of(context)!.playlist),
            ],
          ),
        ),
        body: Obx(
          () => UIHelper.displayContent(
            showWhen: true,
            isDataLoading: appController.isDataLoading,
            exception: appController.exception,
            content: TabBarView(
              physics: const BouncingScrollPhysics(),
              children: [
                buildTabItem(
                    AlbumList(
                      appController.localAudioFiles?.albums,
                      primary: false,
                      listType: AlbumListType.ALBUM_GRID_LIST,
                      src: AudioSrcType.LOCAL_STORAGE,
                      height: 250,
                    ),
                    appController.localAudioFiles?.albums?.length ?? 0,
                    AppLocalizations.of(context)!.no_album_found,
                    onActionClick: () {}),
                buildTabItem(
                    ArtistList(
                      appController.localAudioFiles?.artists,
                      type: ArtistListType.ARTIST_GRID_LIST,
                      src: AudioSrcType.LOCAL_STORAGE,
                    ),
                    appController.localAudioFiles?.albums?.length ?? 0,
                    AppLocalizations.of(context)!.no_artist_found,
                    onActionClick: () {}),
                buildTabItem(
                    SongList(
                      appController.localAudioFiles?.songs,
                      isSliver: false,
                      src: AudioSrcType.LOCAL_STORAGE,
                      adIndexs: UIHelper.selectAdIndex(
                          appController.localAudioFiles?.songs?.length ?? 0),
                    ),
                    appController.localAudioFiles?.albums?.length ?? 0,
                    AppLocalizations.of(context)!.no_song_sound,
                    onActionClick: () {}),
                buildTabItem(
                    PlaylistList(
                      appController.localAudioFiles?.playlists,
                      src: AudioSrcType.LOCAL_STORAGE,
                      listType: PlaylistListType.GRID,
                      height: 200,
                    ),
                    appController.localAudioFiles?.playlists?.length ?? 0,
                    "No playlist found",
                    iconData: Icons.add,
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
          height: 200,
          width: 200,
          onTap: () {
            onActionClick?.call();
          },
          borderRadius: 16,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.hourglass_empty, size: 60),
              const SizedBox(height: 16),
              CustomText(actionText, fontSize: 16)
            ],
          ),
        ),
      );
    }
  }
}
