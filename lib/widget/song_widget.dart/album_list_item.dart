import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zema/modals/album.dart';
import 'package:zema/widget/custom_container.dart';
import 'package:zema/widget/custom_image.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/song_widget.dart/play_pause_icon.dart';

class AlbumListItem extends StatelessWidget {
  Album albumInfo;
  double width;
  double height;

  AlbumListItem(
    this.albumInfo, {
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: () {
        Get.toNamed("/album/${albumInfo.id}");
      },
      borderRadius: 16,
      padding: 8,
      margin: 0,
      width: width,
      child: Stack(
        children: [
          CustomImage(
            albumInfo.artWork,
            width: width,
            height: height,
            roundImage: true,
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
