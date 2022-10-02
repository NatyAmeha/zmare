import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zema/controller/app_controller.dart';
import 'package:zema/utils/constants.dart';

class PlayPauseIcon extends StatelessWidget {
  bool isPlaying;
  bool isBuffering;
  double size;
  PlayPauseIcon({
    this.isPlaying = false,
    this.isBuffering = false,
    this.size = 80,
  });

  var appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: appController.player.playerState,
        builder: (context, snapshot) {
          return SizedBox(
            height: size,
            width: size,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                    child: snapshot.data?.playbackState == PlaybackState.PLAYING
                        ? InkWell(
                            onTap: () {
                              appController.player.pause();
                            },
                            child: Icon(Icons.pause_circle, size: size))
                        : InkWell(
                            onTap: () {
                              appController.player.play();
                            },
                            child: Icon(Icons.play_circle, size: size))),
                if (snapshot.data?.playbackState == PlaybackState.BUFFERING)
                  const Positioned.fill(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          );
        });
  }
}
