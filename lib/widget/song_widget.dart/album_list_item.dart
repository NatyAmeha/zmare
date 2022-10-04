import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:zema/modals/album.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/utils/ui_helper.dart';
import 'package:zema/widget/custom_container.dart';
import 'package:zema/widget/custom_image.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/song_widget.dart/play_pause_icon.dart';

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
          UIHelper.moveToScreen("/album/${albumInfo.id}", arguments: {
            "src": AudioSrcType.NETWORK,
          });
        } else if (src == AudioSrcType.LOCAL_STORAGE) {
          UIHelper.moveToScreen(
            "/album/${albumInfo.id}",
            arguments: {
              "src": AudioSrcType.LOCAL_STORAGE,
              "album_info": albumInfo
            },
          );
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
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomContainer(
                borderRadius: 0,
                borderColor: Colors.grey[200],
                padding: 8,
                margin: 0,
                gradientColor: [Colors.grey[200]!, Colors.grey[200]!],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(albumInfo.name ?? "",
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              maxLine: 1,
                              overflow: TextOverflow.ellipsis),
                          CustomText(
                            albumInfo.artistsName?.join(",") ?? "",
                            fontSize: 12,
                            maxLine: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                    PlayPauseIcon(
                      isPlaying: true,
                      size: 30,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
