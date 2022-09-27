import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zema/widget/custom_image.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/song_widget.dart/play_pause_icon.dart';

class PlayerCard extends StatelessWidget {
  const PlayerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(0),
      child: ListTile(
        minVerticalPadding: 0,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        leading: CustomImage(
          "https://i.pinimg.com/736x/8a/b8/7b/8ab87bd6999d659eb282fbed00895d86--last-fm-album-cover.jpg",
          roundImage: true,
          width: 50,
          height: 50,
        ),
        title: CustomText("Song name 1",
            fontSize: 15, fontWeight: FontWeight.bold),
        subtitle: CustomText("Artist name", fontSize: 12),
        trailing: PlayPauseIcon(isBuffering: true, size: 40),
      ),
    );
  }
}
