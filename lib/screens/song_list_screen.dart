import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/widget/custom_chip.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/song_widget.dart/song_list.dart';

class SongListScreen extends StatelessWidget {
  static const routName = "/songs";
  bool showFilter;

  SongListScreen({
    this.showFilter = false,
  });

  var songs = [
    Song(title: "Song title 1", artistsName: ["Artist title 1"]),
    Song(title: "song no 2", artistsName: ["artist 2"]),
    Song(title: "short song title", artistsName: ["singers name info"]),
    Song(title: "Long Song and artist title", artistsName: ["Artist title 1"]),
    Song(title: "gospel playlist", artistsName: ["Long artist name and info"]),
    Song(title: "Long song with album info", artistsName: ["Artist title 1"]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText("Song List type"),
        bottom: showFilter
            ? PreferredSize(
                preferredSize: const Size.fromHeight(100),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CustomChip(label: "Songs"),
                    CustomChip(label: "Album"),
                    CustomChip(label: "Playlists"),
                    CustomChip(label: "Artists")
                  ],
                ),
              )
            : null,
      ),
      body: SongList(
        songs,
        isSliver: false,
      ),
    );
  }
}
