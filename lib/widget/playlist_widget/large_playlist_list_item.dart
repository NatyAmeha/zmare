import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/playlist_controller.dart';
import 'package:zmare/modals/playlist.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/song_widget.dart/play_pause_icon.dart';

class LargePlaylistTile extends StatelessWidget {
  Playlist playlistInfo;
  bool querySongs;
  LargePlaylistTile(this.playlistInfo, {this.querySongs = true});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        onTap: () {
          print(playlistInfo.songs);
          print(playlistInfo.id);
          UIHelper.moveToPlaylistScreen(playlistInfo.id,
              navigatorId: UIHelper.bottomNavigatorKeyId,
              plyalistInfo: playlistInfo);
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
                child: CustomContainer(
              gradientColor: [Colors.transparent, Colors.blueGrey],
              child: Container(),
            )),
            Positioned.fill(
                right: 10,
                bottom: 10,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: PlayPauseIcon(
                    playlistOrAlbumId: playlistInfo.id,
                    songs: querySongs ? playlistInfo.songs : null,
                    size: 45,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )),
            Positioned.fill(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      playlistInfo.name ?? "",
                      color: Colors.white,
                      textStyle: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    CustomText(
                      "${playlistInfo.songs?.length ?? playlistInfo.followersId?.length} ${playlistInfo.songs?.length.isGreaterThan(0) == true ? 'songs' : 'Listeners'}",
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ))
          ],
        ));
  }
}
