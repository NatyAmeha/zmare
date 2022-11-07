import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zmare/modals/playlist.dart';
import 'package:zmare/screens/playlist_screen.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/song_widget.dart/play_pause_icon.dart';

class PlaylistGridTile extends StatelessWidget {
  Playlist? playlistInfo;
  String? title;
  String? image;
  double imageSize;
  Widget? subtitle;
  Function? onClick;
  double width;
  double height;
  AudioSrcType src;
  PlaylistGridTile({
    this.playlistInfo,
    this.title,
    this.image,
    this.subtitle,
    this.width = double.infinity,
    this.height = 200,
    this.imageSize = 150,
    this.src = AudioSrcType.NETWORK,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      margin: 0,
      padding: 8,
      onTap: () {
        UIHelper.moveToScreen("/playlist/${playlistInfo?.id!}",
            navigatorId: UIHelper.bottomNavigatorKeyId);
      },
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CustomImage(
                playlistInfo?.coverImagePath?.first ?? image,
                height: imageSize,
                width: width,
                roundImage: true,
              ),
              Positioned.fill(
                  right: 8,
                  bottom: 8,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: PlayPauseIcon(
                      playlistOrAlbumId: playlistInfo?.id,
                      size: 50,
                      color: Theme.of(context).colorScheme.primary,
                      songs: playlistInfo?.songs,
                    ),
                  ))
            ],
          ),
          const SizedBox(height: 10),
          CustomText(playlistInfo?.name ?? title ?? "",
              textStyle: Theme.of(context).textTheme.titleMedium,
              fontWeight: FontWeight.bold),
          const SizedBox(height: 4),
          if (subtitle != null) subtitle!
        ],
      ),
    );
  }
}
