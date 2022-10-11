import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zmare/modals/album.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/widget/album_widget/album_list.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/list_header.dart';
import 'package:zmare/widget/playlist_widget/large_playlist_list_item.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = "/category";
  String categoryName;

  CategoryScreen(this.categoryName);

  var albums = [
    Album(name: "Album 1", songs: [
      Song(title: "Song title 1", artistsName: ["Artist title 1"]),
      Song(title: "song no 2", artistsName: ["artist 2"]),
      Song(title: "short song title", artistsName: ["singers name info"]),
    ]),
    Album(name: "Long Album Name with artist", artistsName: [
      "Artist name one"
    ], songs: [
      Song(title: "Song title 1", artistsName: ["Artist title 1"]),
      Song(title: "song no 2", artistsName: ["artist 2"]),
      Song(title: "short song title", artistsName: ["singers name info"]),
    ]),
    Album(name: "Album 1", artistsName: [
      "LOng Artist name with description"
    ], songs: [
      Song(title: "Song title 1", artistsName: ["Artist title 1"]),
      Song(title: "song no 2", artistsName: ["artist 2"]),
      Song(title: "short song title", artistsName: ["singers name info"]),
    ]),
    Album(name: "Album 1", artistsName: [
      "bereket tesfaye"
    ], songs: [
      Song(title: "Song title 1", artistsName: ["Artist title 1"]),
      Song(title: "song no 2", artistsName: ["artist 2"]),
      Song(title: "short song title", artistsName: ["singers name info"]),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              title: CustomText(categoryName),
              expandedTitleScale: 2,
              collapseMode: CollapseMode.pin,
              background: CustomContainer(
                gradientColor: [Colors.red, Colors.blue],
                child: Container(),
              ),
            ),
          ),
          // SliverToBoxAdapter(
          //   child: Container(
          //     height: 250,
          //     child: ListView.separated(
          //       padding: const EdgeInsets.symmetric(horizontal: 16),
          //       scrollDirection: Axis.horizontal,
          //       itemCount: 5,
          //       separatorBuilder: (context, index) => const SizedBox(width: 16),
          //       itemBuilder: (context, index) => LargePlaylistTile(),
          //     ),
          //   ),
          // ),
          ListHeader("Albums"),
          AlbumList(
            albums,
            isSliver: true,
            height: 400,
          ),
        ],
      ),
    );
  }
}
