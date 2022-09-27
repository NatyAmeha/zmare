import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zema/modals/artist.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/widget/circle_tile.dart';

class ArtistList extends CircleTileList {
  List<Artist> artistList;
  double height;
  ArtistListType type;
  ArtistList(
    this.artistList, {
    this.type = ArtistListType.ARTIST_HORIZONTAL_LIST,
    this.height = 200,
  }) : super(
            height: height,
            circleRadius: 70,
            listType: type,
            image: artistList.map((e) => e.profileImagePath!.first).toList(),
            text: artistList.map((e) => e.name!).toList(),
            subtitle: [
              "128 followers",
              "128 followers",
              "128 followers",
              "128 followers",
              "128 followers",
              "128 followers"
            ]);
}
