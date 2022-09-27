import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/utils/ui_helper.dart';
import 'package:zema/viewmodels/menu_viewmodel.dart';
import 'package:zema/widget/custom_image.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/dialog/song_menu_modal.dart';
import 'package:zema/widget/song_widget.dart/play_pause_icon.dart';

class SongListItem extends StatelessWidget {
  Song songInfo;
  int index;
  Key? key;
  bool isSelected;
  bool showDownloadIcon;
  bool showFavoriteIcon;
  bool showDragIcon;
  bool showPlayPauseIcon;
  bool showDrag;
  bool showMore;
  Function(Song)? onMoreclicked;

  var songMenus = [
    MenuViewmodel(text: "Like song", icon: Icons.favorite_outline),
    MenuViewmodel(text: "Dislike song", icon: Icons.favorite),
    MenuViewmodel(text: "Download song", icon: Icons.download),
    MenuViewmodel(text: "Go to Album", icon: Icons.album),
    MenuViewmodel(text: "Go to Artist", icon: Icons.mic),
    MenuViewmodel(text: "Delete song", icon: Icons.delete),
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
    this.onMoreclicked,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: key,
      selected: isSelected,
      selectedColor: Colors.grey,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      minVerticalPadding: 0,
      onTap: () {},
      leading: CustomImage(songInfo.thumbnailPath,
          height: 50, width: 50, roundImage: true),
      title: CustomText(
        songInfo.title ?? "",
        fontWeight: FontWeight.bold,
        fontSize: 17,
        maxLine: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: CustomText(songInfo.artistsName?.first ?? "",
            fontSize: 13, maxLine: 1, overflow: TextOverflow.ellipsis),
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
            const Icon(Icons.drag_handle),
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
                onMoreclicked?.call(songInfo) ??
                    UIHelper.showBottomSheet(
                        SongMenuModal(song: songInfo, menuList: songMenus),
                        scrollControlled: true);
              },
              icon: const Icon(Icons.more_vert),
            )
        ],
      ),
    );
  }
}
