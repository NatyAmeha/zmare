import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/dialog/song_menu_modal.dart';

class LocalSongListItem extends StatelessWidget {
  Song songInfo;
  Key? key;
  bool isSelected;
  ArtworkType artWorkType;
  bool showMore;

  Function(Song)? onMoreclicked;
  Function? onTap;
  LocalSongListItem(
    this.songInfo, {
    required this.artWorkType,
    this.isSelected = false,
    this.showMore = true,
    this.onMoreclicked,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: key,
      selected: isSelected,
      // selectedColor: Colors.black,

      selectedTileColor: Colors.grey[200],
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      minVerticalPadding: 0,
      onTap: () {
        onTap?.call();
      },
      leading: QueryArtworkWidget(
          id: int.parse(songInfo.id!),
          type: artWorkType,
          nullArtworkWidget: CustomImage(
            null,
            height: 50,
            width: 50,
            roundImage: true,
          )),
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
          if (showMore)
            IconButton(
              onPressed: () async {
                onMoreclicked?.call(songInfo);
                // UIHelper.showBottomSheet(
                //   SongMenuModal(
                //     song: songInfo,
                //     menuList: songMenus,
                //     showProgress: true,
                //     activeMenusIndx:
                //         List.generate(songMenus.length, (index) => index),
                //   ),
                //   scrollControlled: true,
                // );
              },
              icon: const Icon(Icons.more_vert),
            ),
        ],
      ),
    );
  }
}

class LocalSongList extends StatelessWidget {
  List<Song>? songs;
  ArtworkType artworkType;
  LocalSongList(this.songs, {required this.artworkType});

  @override
  Widget build(BuildContext context) {
    if (songs?.isNotEmpty == true) {
      return ListView.builder(
        itemCount: songs!.length,
        itemBuilder: (context, index) =>
            LocalSongListItem(songs![index], artWorkType: artworkType),
      );
    } else {
      return Container();
    }
  }
}
