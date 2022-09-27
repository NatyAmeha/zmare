import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zema/modals/album.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/screens/category_screen.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/widget/album_widget/album_list.dart';
import 'package:zema/widget/custom_button.dart';
import 'package:zema/widget/custom_container.dart';
import 'package:zema/widget/custom_image.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/list_header.dart';
import 'package:zema/widget/song_widget.dart/song_list.dart';

class ArtistScreen extends StatelessWidget {
  static const routeName = "/artist";
  ArtistScreen({super.key});

  var songLists = [
    Song(title: "Song title 1", artistsName: ["Artist title 1"]),
    Song(title: "song no 2", artistsName: ["artist 2"]),
    Song(title: "short song title", artistsName: ["singers name info"]),
    Song(title: "Long Song and artist title", artistsName: ["Artist title 1"]),
    Song(title: "gospel playlist", artistsName: ["Long artist name and info"]),
    Song(title: "Long song with album info", artistsName: ["Artist title 1"]),
  ];

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
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  CustomImage(
                    "https://d1csarkz8obe9u.cloudfront.net/themedlandingpages/tlp_hero_album-covers-d12ef0296af80b58363dc0deef077ecc-1552649680.jpg",
                    // placeholder: "assets/images/artist_placeholder.jpg",
                    width: double.infinity,
                    height: 300,
                  ),
                  Positioned(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomContainer(
                        // borderColor: Colors.transparent,
                        padding: 16,
                        gradientColor: const [Colors.transparent, Colors.grey],
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText("Artist Name",
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                    const SizedBox(height: 4),
                                    CustomText("128 followers",
                                        fontWeight: FontWeight.bold)
                                  ],
                                ),
                                CustomButton("Follow",
                                    buttonType: ButtonType
                                        .ROUND_ELEVATED_BUTTON, onPressed: () {
                                  Get.toNamed(CategoryScreen.routeName);
                                })
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CustomContainer(
                color: Colors.grey,
                padding: 0,
                child: Stack(
                  children: [
                    ListTile(
                      // contentPadding: const EdgeInsets.only(top: 32),
                      leading: CustomImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0rXLxvzsiu1TFgCZW1H5j0QKRTW4SA3iUp-2ykco4teeM8GqQBlBpNxu-ikhhlcDafgc&usqp=CAU",
                          height: 70,
                          width: 50,
                          roundImage: true),
                      title: CustomText(
                        "Latest song",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      subtitle: CustomText("Album", fontSize: 15),
                      trailing: IconButton(
                        icon: Icon(Icons.play_circle),
                        onPressed: () {},
                      ),
                    ),
                    Positioned.fill(
                      left: 4,
                      top: 4,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Badge(
                          toAnimate: false,
                          shape: BadgeShape.square,
                          badgeColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          borderRadius: BorderRadius.circular(8),
                          badgeContent: CustomText("Latest", fontSize: 12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          ListHeader(
            "Popular songs",
            bottomPadding: 16,
          ),
          SongList(songLists),
          ListHeader("Albums Horizontal list"),
          SliverToBoxAdapter(
            child: AlbumList(
              albums,
              listType: AlbumListType.ALBUM_HORIZONTAL_LIST,
              height: 200,
              width: 220,
            ),
          )
        ],
      ),
    );
  }
}
