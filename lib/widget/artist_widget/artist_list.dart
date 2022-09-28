import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zema/modals/artist.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/widget/circle_tile.dart';
import 'package:zema/widget/custom_button.dart';

class ArtistList extends StatelessWidget {
  List<Artist>? artistList;
  double height;
  ArtistListType type;
  bool shrinkWrap;

  ArtistList(
    this.artistList, {
    this.type = ArtistListType.ARTIST_HORIZONTAL_LIST,
    this.shrinkWrap = false,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    if (artistList?.isNotEmpty == true) {
      if (type == ArtistListType.ARTIST_HORIZONTAL_LIST) {
        return SizedBox(
          height: height,
          child: ListView.separated(
            itemCount: artistList!.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) => CircleTile(
              image: artistList![index].profileImagePath!.elementAt(0),
              text: artistList![index].name,
              radius: 70,
              onClick: () {
                Get.toNamed("/artist/${artistList![index].id}");
              },
            ),
          ),
        );
      } else if (type == ArtistListType.ARTIST_GRID_LIST) {
        return GridView.builder(
          itemCount: artistList!.length,
          shrinkWrap: shrinkWrap,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 170,
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8),
          itemBuilder: (context, index) => CircleTile(
            image: artistList![index].profileImagePath!.elementAt(0),
            text: artistList![index].name,
            radius: 60,
            height: 160,
            onClick: () {
              Get.toNamed("/artist/${artistList![index].id}");
            },
          ),
        );
      } else {
        return SizedBox(
          height: height,
          child: ListView.builder(
            itemCount: artistList!.length,
            // separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemExtent: 100,
            itemBuilder: (context, index) => CircleVerticalListTile(
              image: artistList![index].profileImagePath!.elementAt(0),
              text: artistList![index].name,
              subtitle: "${artistList![index].followersCount} followers",
              radius: 40,
              trailing: CustomButton(
                "Follow",
                textSize: 12,
                wrapContent: true,
                buttonType: ButtonType.ROUND_ELEVATED_BUTTON,
                onPressed: () {},
              ),
              onClick: () {
                Get.toNamed("/artist/${artistList![index].id}");
              },
            ),
          ),
        );
      }
    } else {
      return Container();
    }
  }
}
