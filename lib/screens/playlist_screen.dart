import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/widget/album_widget/album_playlist_header.dart';
import 'package:zema/widget/custom_button.dart';
import 'package:zema/widget/custom_image.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/image_collection.dart';
import 'package:zema/widget/song_widget.dart/song_list.dart';

class PlaylistScreen extends StatelessWidget {
  static const routeName = "/playlist";
  PlaylistScreen({super.key});

  var songLists = [
    Song(title: "Song title 1", artistsName: ["Artist title 1"]),
    Song(title: "song no 2", artistsName: ["artist 2"]),
    Song(title: "short song title", artistsName: ["singers name info"]),
  ];

  var images = const [
    "https://i.pinimg.com/736x/8a/b8/7b/8ab87bd6999d659eb282fbed00895d86--last-fm-album-cover.jpg",
    "https://d1csarkz8obe9u.cloudfront.net/themedlandingpages/tlp_hero_album-covers-d12ef0296af80b58363dc0deef077ecc-1552649680.jpg",
    "https://i.pinimg.com/736x/8a/b8/7b/8ab87bd6999d659eb282fbed00895d86--last-fm-album-cover.jpg",
    "https://d1csarkz8obe9u.cloudfront.net/themedlandingpages/tlp_hero_album-covers-d12ef0296af80b58363dc0deef077ecc-1552649680.jpg",
    "https://i.pinimg.com/736x/8a/b8/7b/8ab87bd6999d659eb282fbed00895d86--last-fm-album-cover.jpg",
    "https://d1csarkz8obe9u.cloudfront.net/themedlandingpages/tlp_hero_album-covers-d12ef0296af80b58363dc0deef077ecc-1552649680.jpg",
    "https://i.pinimg.com/736x/8a/b8/7b/8ab87bd6999d659eb282fbed00895d86--last-fm-album-cover.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 470,
            pinned: true,
            backgroundColor: Colors.white,
            title: CustomText(
              "Playlist info",
              color: Colors.black,
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.download,
                  color: Colors.grey,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.grey,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.grey,
                ),
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                // alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 120),
                    AlbumPlayListHeader(
                      images: images,
                      title: "Playlist Name ",
                      actionText: "Start Playing",
                      size: 200,
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleImageCollection(
                              image: images.take(3).toList(), radius: 15),
                          const SizedBox(width: 10),
                          CustomText(
                            "68 followers",
                            fontSize: 12,
                          )
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    )
                  ],
                ),
              ),
            ),
          ),
          SongList(songLists),
        ],
      ),
    );
  }
}
