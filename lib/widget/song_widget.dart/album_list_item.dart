import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:zmare/modals/album.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/song_widget.dart/play_pause_icon.dart';

class AlbumListItem extends StatelessWidget {
  Album albumInfo;
  double width;
  double height;
  AudioSrcType src;

  AlbumListItem(this.albumInfo,
      {required this.width,
      required this.height,
      this.src = AudioSrcType.NETWORK});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: () {
        if (src == AudioSrcType.NETWORK) {
          // Get.toNamed("/album/${albumInfo.id}");
          UIHelper.moveToScreen("/album/${albumInfo.id}",
              arguments: {
                "src": AudioSrcType.NETWORK,
              },
              navigatorId: UIHelper.bottomNavigatorKeyId);
        } else if (src == AudioSrcType.LOCAL_STORAGE) {
          UIHelper.moveToScreen("/album/${albumInfo.id}",
              arguments: {
                "src": AudioSrcType.LOCAL_STORAGE,
                "album_info": albumInfo
              },
              navigatorId: UIHelper.bottomNavigatorKeyId);
        }
      },
      borderRadius: 16,
      padding: 8,
      margin: 0,
      width: width,
      child: Stack(
        children: [
          if (src == AudioSrcType.NETWORK)
            CustomImage(
              albumInfo.artWork,
              width: width,
              height: height,
              roundImage: true,
            ),
          if (src == AudioSrcType.LOCAL_STORAGE)
            QueryArtworkWidget(
              id: int.parse(albumInfo.id!),
              type: ArtworkType.ALBUM,
              artworkHeight: height,
              artworkWidth: width,
              nullArtworkWidget: CustomImage(
                null,
                width: width,
                height: height,
                roundImage: true,
              ),
            ),
          Positioned.fill(
              child: CustomContainer(
            gradientColor: [Colors.transparent, Colors.grey],
            child: Container(),
          )),
          Positioned.fill(
            left: 8,
            right: 8,
            bottom: 8,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(albumInfo.name ?? "",
                            textStyle: Theme.of(context).textTheme.titleLarge,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            maxLine: 1,
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 4),
                        CustomText(
                          albumInfo.artistsName?.join(",") ?? "",
                          textStyle: Theme.of(context).textTheme.bodySmall,
                          color: Colors.white,
                          maxLine: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (src == AudioSrcType.NETWORK)
            Positioned.fill(
                bottom: 8,
                right: 8,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: PlayPauseIcon(
                    size: 50,
                    playlistOrAlbumId: albumInfo.id,
                    songs: albumInfo.songs,
                    color: Theme.of(context).colorScheme.primary,
                    src: src,
                  ),
                ))
        ],
      ),
    );
  }
}
