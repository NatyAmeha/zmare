import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zmare/modals/playlist.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';

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
    return Container(
      height: height,
      child: Column(
        children: [
          CustomImage(
            playlistInfo?.coverImagePath?.first ?? image,
            height: imageSize,
            width: width,
            roundImage: true,
          ),
          const SizedBox(height: 10),
          CustomText(playlistInfo?.name ?? title ?? "",
              fontSize: 16, fontWeight: FontWeight.bold),
          const SizedBox(height: 4),
          if (subtitle != null) subtitle!
        ],
      ),
    );
  }
}
