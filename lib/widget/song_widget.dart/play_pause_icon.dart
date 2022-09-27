import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PlayPauseIcon extends StatelessWidget {
  bool isPlaying;
  bool isBuffering;
  double size;
  PlayPauseIcon(
      {this.isPlaying = false, this.isBuffering = false, this.size = 80});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
              child: isPlaying
                  ? Icon(Icons.pause_circle, size: size)
                  : Icon(Icons.play_circle, size: size)),
          if (isBuffering)
            Positioned.fill(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
