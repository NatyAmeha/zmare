import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/viewmodels/menu_viewmodel.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/dialog/song_menu_modal.dart';
import 'package:zmare/widget/song_widget.dart/play_pause_icon.dart';

class SongListItem extends StatelessWidget {
  Song songInfo;
  int index;
  Key? key;
  bool isSelected;
  bool showDownloadIcon;
  bool showFavoriteIcon;
  bool showDragIcon;
  bool showPlayPauseIcon;
  AudioSrcType src;
  bool showDrag;
  bool showMore;
  List<String> selectedSongIds;
  ListSelectionState selectionState;
  Function(Song)? onMoreclicked;
  Widget? leading;
  Function(int?)? onTap;
  Function(Song)? onLongPress;

  var songMenus = [
    MenuViewmodel(
      text: "Like song",
      icon: Icons.favorite_outline,
      type: MenuViewmodel.MENU_TYPE_LIKE_SONG,
    ),
    MenuViewmodel(
      text: "Unlike song",
      icon: Icons.favorite,
      type: MenuViewmodel.MENU_TYPE_UNLIKE_SONG,
    ),
    MenuViewmodel(
      text: "Download",
      icon: Icons.download,
      type: MenuViewmodel.MENU_TYPE_DOWNLOAD_SONG,
    ),
    MenuViewmodel(
      text: "Remove Download",
      icon: Icons.remove,
      type: MenuViewmodel.MENU_TYPE_REMOVE_DOWNLOAD_SONG,
    ),
    MenuViewmodel(
      text: "Add to queue",
      icon: Icons.queue_music,
      type: MenuViewmodel.MENU_TYPE_ADD_TO_QUEUE,
    ),
    MenuViewmodel(
        text: "Go to Album",
        icon: Icons.album,
        type: MenuViewmodel.MENU_TYPE_GO_TO_ALBUM),
    MenuViewmodel(
        text: "Go to Artist",
        icon: Icons.mic,
        type: MenuViewmodel.MENU_TYPE_GO_TO_ARTIST),
  ];

  var localSongMenus = [
    MenuViewmodel(
        text: "Play",
        icon: Icons.play_circle,
        type: MenuViewmodel.MENU_TYPE_PLAY_SONG),
  ];

  var downloadedSongMenus = [
    MenuViewmodel(
        text: "Play",
        icon: Icons.play_circle,
        type: MenuViewmodel.MENU_TYPE_PLAY_SONG),
    MenuViewmodel(
      text: "Remove Download",
      icon: Icons.remove,
      type: MenuViewmodel.MENU_TYPE_REMOVE_DOWNLOAD_SONG,
    ),
  ];

  SongListItem(
    this.songInfo, {
    this.key,
    this.index = -1,
    this.isSelected = false,
    this.showFavoriteIcon = false,
    this.showDownloadIcon = false,
    this.showDragIcon = false,
    this.showMore = true,
    this.showPlayPauseIcon = false,
    this.showDrag = false,
    this.src = AudioSrcType.NETWORK,
    this.leading,
    this.selectedSongIds = const [],
    this.selectionState = ListSelectionState.SINGLE_SELECTION,
    this.onTap,
    this.onLongPress,
    this.onMoreclicked,
  });

  var appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // key: key,
      selected: isSelected,
      // selectedColor: Colors.black,
      selectedTileColor: Theme.of(context).backgroundColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      minVerticalPadding: 0,
      onTap: () {
        onTap?.call(null);
      },
      // onLongPress: () {
      //   onLongPress?.call(songInfo);
      // },
      leading: buildLeading(),
      title: CustomText(
        songInfo.title ?? "",
        textStyle: Theme.of(context).textTheme.titleSmall,
        maxLine: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: CustomText(
          songInfo.artistsName?.first ?? "",
          textStyle: Theme.of(context).textTheme.bodySmall,
          maxLine: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      trailing: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDownloadIcon) ...[
            const Icon(Icons.download_for_offline),
            const SizedBox(width: 16)
          ],
          if (showFavoriteIcon) ...[
            const Icon(Icons.favorite_outline),
            const SizedBox(width: 10),
          ],
          if (showDragIcon) ...[
            IconButton(onPressed: () {}, icon: const Icon(Icons.drag_handle)),
            const SizedBox(width: 16),
          ],
          if (showPlayPauseIcon) ...[
            PlayPauseIcon(size: 30),
            const SizedBox(width: 16),
          ],
          if (showDrag) ...[
            const Icon(Icons.drag_handle),
            const SizedBox(width: 16),
          ],
          if (showMore)
            IconButton(
              onPressed: () async {
                List<MenuViewmodel> selectedMenus = [];
                var checkLikeStatus = false;
                var checkDownloadStatus = false;
                if (src == AudioSrcType.LOCAL_STORAGE) {
                  selectedMenus = localSongMenus;
                } else if (src == AudioSrcType.DOWNLOAD) {
                  selectedMenus = downloadedSongMenus;
                } else {
                  selectedMenus = [...songMenus];
                  checkLikeStatus = true;
                  checkDownloadStatus = true;
                }
                onMoreclicked?.call(songInfo) ??
                    showSongMenu(selectedMenus,
                        checkLikeStatus: checkLikeStatus,
                        checkDownloadstatus: checkDownloadStatus);
              },
              icon: const Icon(Icons.more_vert),
            ),
        ],
      ),
    );
  }

  Widget buildLeading() {
    return src == AudioSrcType.LOCAL_STORAGE
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selectionState == ListSelectionState.MULTI_SELECTION)
                Checkbox(
                    value: selectedSongIds.contains(songInfo.id),
                    onChanged: (isSelected) {}),
              const SizedBox(width: 8),
              QueryArtworkWidget(
                id: int.parse(songInfo.id!),
                type: ArtworkType.AUDIO,
                artworkWidth: 50,
                artworkHeight: 50,
                nullArtworkWidget: CustomImage(
                  null,
                  roundImage: true,
                  height: 50,
                  width: 50,
                ),
              ),
            ],
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selectionState == ListSelectionState.MULTI_SELECTION)
                Checkbox(
                    value: selectedSongIds.contains(songInfo.id),
                    onChanged: (isSelected) {}),
              const SizedBox(width: 8),
              CustomImage(songInfo.thumbnailPath,
                  height: 50, width: 50, roundImage: true),
            ],
          );
  }

  Future<void> showSongMenu(List<MenuViewmodel> menus,
      {bool checkLikeStatus = true, bool checkDownloadstatus = true}) async {
    UIHelper.showBottomSheet(
      SongMenuModal(
        songInfo: songInfo,
        headerTitle: songInfo.title,
        headerSubtitle: songInfo.artistsName?.join(","),
        headerImage: songInfo.thumbnailPath,
        menuList: [],
        onclick: (selectedAction) {
          onTap?.call(selectedAction);
        },
      ),
      scrollControlled: true,
    );
    if (checkLikeStatus) {
      var isSongLiked = await appController.isSongLiked(songInfo.id!);
      if (isSongLiked)
        menus.removeWhere((e) => e.type == MenuViewmodel.MENU_TYPE_LIKE_SONG);
      else
        menus.removeWhere((e) => e.type == MenuViewmodel.MENU_TYPE_UNLIKE_SONG);
    }
    if (checkDownloadstatus) {
      var downloadResult = await appController.isSongDownloaded(songInfo.id!);
      if (downloadResult)
        menus.removeWhere(
            (e) => e.type == MenuViewmodel.MENU_TYPE_DOWNLOAD_SONG);
      else
        menus.removeWhere(
            (e) => e.type == MenuViewmodel.MENU_TYPE_REMOVE_DOWNLOAD_SONG);
    }

    UIHelper.moveBack();
    UIHelper.showBottomSheet(
      SongMenuModal(
        songInfo: songInfo,
        headerTitle: songInfo.title,
        headerSubtitle: songInfo.artistsName?.join(","),
        headerImage: songInfo.thumbnailPath,
        menuList: menus,
      ),
      scrollControlled: true,
    );
  }
}
