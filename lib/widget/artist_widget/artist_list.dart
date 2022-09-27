import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zema/modals/artist.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/widget/circle_tile.dart';

class ArtistList extends StatelessWidget {
  List<Artist> artistList;
  double height;
  ArtistListType type;

  ArtistList(
    this.artistList, {
    this.type = ArtistListType.ARTIST_HORIZONTAL_LIST,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    if (type == ArtistListType.ARTIST_HORIZONTAL_LIST) {
      return SizedBox(
        height: height,
        child: ListView.separated(
          itemCount: artistList.length,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemBuilder: (context, index) => CircleTile(
            image: artistList[index].profileImagePath!.elementAt(0),
            text: artistList[index].name,
            radius: 70,
            onClick: () {
              Get.toNamed("/artist/${artistList[index].id}");
            },
          ),
        ),
      );
    } else if (type == ArtistListType.ARTIST_GRID_LIST) {
      return GridView.builder(
        itemCount: artistList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
        itemBuilder: (context, index) => CircleTile(
          image: artistList[index].profileImagePath!.elementAt(0),
          text: artistList[index].name,
          radius: 40,
          onClick: () {
            Get.toNamed("/artist/${artistList[index].id}");
          },
        ),
      );
    } else {
      return SizedBox(
        height: height,
        child: ListView.separated(
          itemCount: artistList.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) => CircleVerticalListTile(
            image: artistList[index].profileImagePath!.elementAt(0),
            text: artistList[index].name,
            radius: 40,
            onClick: () {
              Get.toNamed("/artist/${artistList[index].id}");
            },
          ),
        ),
      );
    }
  }
}
