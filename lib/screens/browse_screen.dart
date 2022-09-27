import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zema/modals/album.dart';
import 'package:zema/modals/artist.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/widget/album_widget/album_list.dart';
import 'package:zema/widget/artist_widget/artist_list.dart';
import 'package:zema/widget/circle_tile.dart';
import 'package:zema/widget/custom_carousel.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/list_header.dart';
import 'package:zema/widget/search_widget.dart';
import 'package:zema/widget/song_widget.dart/category_list.dart';
import 'package:zema/widget/song_widget.dart/song_list.dart';

class BrowseScreen extends StatelessWidget {
  static const routeName = "/browse";
  BrowseScreen({super.key});

  var songLists = [
    Song(title: "Song title 1", artistsName: ["Artist title 1"]),
    Song(title: "song no 2", artistsName: ["artist 2"]),
    Song(title: "short song title", artistsName: ["singers name info"]),
    Song(title: "Song title 1", artistsName: ["Artist title 1"]),
    Song(title: "song no 2", artistsName: ["artist 2"]),
    Song(title: "short song title", artistsName: ["singers name info"]),
    Song(title: "Song title 1", artistsName: ["Artist title 1"]),
    Song(title: "song no 2", artistsName: ["artist 2"]),
    Song(title: "short song title", artistsName: ["singers name info"]),
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

  var artist = [
    Artist(
      name: "Artist name",
      profileImagePath: [
        "https://i.pinimg.com/736x/8a/b8/7b/8ab87bd6999d659eb282fbed00895d86--last-fm-album-cover.jpg",
        "https://imusician.imgix.net/images/how-to-make-an-album-cover.jpg?auto=compress&w=1200&h=630&fit=crop",
      ],
    ),
    Artist(
      name: "Artist name",
      profileImagePath: [
        "https://i.pinimg.com/736x/8a/b8/7b/8ab87bd6999d659eb282fbed00895d86--last-fm-album-cover.jpg",
        "https://imusician.imgix.net/images/how-to-make-an-album-cover.jpg?auto=compress&w=1200&h=630&fit=crop",
      ],
    ),
    Artist(
      name: "Artist name",
      profileImagePath: [
        "https://i.pinimg.com/736x/8a/b8/7b/8ab87bd6999d659eb282fbed00895d86--last-fm-album-cover.jpg",
        "https://imusician.imgix.net/images/how-to-make-an-album-cover.jpg?auto=compress&w=1200&h=630&fit=crop",
      ],
    ),
    Artist(
      name: "Artist name",
      profileImagePath: [
        "https://i.pinimg.com/736x/8a/b8/7b/8ab87bd6999d659eb282fbed00895d86--last-fm-album-cover.jpg",
        "https://imusician.imgix.net/images/how-to-make-an-album-cover.jpg?auto=compress&w=1200&h=630&fit=crop",
      ],
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: CustomText("Browse", color: Colors.black),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: SearchBar(
                    borderRadius: 16,
                    hintText: "Search music, albums and playlist"),
              ),
              const SizedBox(height: 16),
              Container(
                height: 250,
                child: Categorylist(),
              ),
              CustomCarousel(
                widgets: [
                  SongList(songLists.take(4).toList(),
                      isSliver: false, shrinkWrap: true),
                  SongList(songLists.take(4).toList(),
                      isSliver: false, shrinkWrap: true),
                ],
                headers: [
                  ListHeader(
                    "Top Songs",
                    isSliver: false,
                    showMore: songLists.length > 4,
                  ),
                  ListHeader(
                    "New Songs",
                    isSliver: false,
                    showMore: songLists.length > 4,
                  )
                ],
                height: 400,
              ),
              CustomCarousel(
                widgets: [
                  AlbumList(albums.take(4).toList(),
                      listType: AlbumListType.ALBUM_GRID_LIST,
                      isSliver: false,
                      height: 300,
                      shrinkWrap: true),
                  AlbumList(albums.take(4).toList(),
                      listType: AlbumListType.ALBUM_GRID_LIST,
                      isSliver: false,
                      height: 300,
                      shrinkWrap: true),
                ],
                headers: [
                  ListHeader(
                    "top Albums",
                    isSliver: false,
                    showMore: albums.length > 4,
                  ),
                  ListHeader(
                    "New Albums",
                    isSliver: false,
                    showMore: songLists.length > 4,
                  )
                ],
                height: 400,
              ),
              CustomCarousel(
                widgets: [
                  ArtistList(artist,
                      height: 400, type: ArtistListType.ARTIST_VERTICAL_LIST),
                  ArtistList(
                    artist,
                    height: 400,
                    type: ArtistListType.ARTIST_VERTICAL_LIST,
                  ),
                ],
                headers: [
                  ListHeader(
                    "Top Artists ",
                    isSliver: false,
                    showMore: albums.length > 4,
                  ),
                  ListHeader(
                    "New Artists",
                    isSliver: false,
                    showMore: songLists.length > 4,
                  )
                ],
                height: 800,
              )
            ],
          )),
        ],
      ),
    );
  }
}
