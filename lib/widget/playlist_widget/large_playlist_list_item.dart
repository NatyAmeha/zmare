import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zmare/modals/playlist.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/song_widget.dart/play_pause_icon.dart';

class LargePlaylistTile extends StatelessWidget {
  Playlist playlistInfo;
  LargePlaylistTile(this.playlistInfo);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        onTap: () {
          UIHelper.moveToPlaylistScreen(playlistInfo.id!);
        },
        width: 200,
        height: 250,
        padding: 0,
        margin: 0,
        borderRadius: 24,
        child: Stack(
          children: [
            CustomImage(
              playlistInfo.coverImagePath?.elementAt(0),
              width: 200,
              height: 250,
              roundImage: true,
            ),
            Positioned.fill(
                left: 0,
                bottom: 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomContainer(
                    borderRadius: 10,
                    padding: 8,
                    borderColor: Colors.transparent,
                    gradientColor: const [Colors.transparent, Colors.grey],
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          playlistInfo.name ?? "",
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 4),
                        CustomText(
                          "${playlistInfo.songs?.length} songs",
                          fontSize: 12,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            PlayPauseIcon(
                              isPlaying: true,
                              size: 30,
                            ),
                            const SizedBox(width: 8),
                            CustomText("Now playing", fontSize: 15)
                          ],
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ));
  }
}
