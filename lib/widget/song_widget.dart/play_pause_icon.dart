import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/extension.dart';

class PlayPauseIcon extends StatefulWidget {
  String? playlistOrAlbumId;
  double size;
  List<dynamic>? songs;
  AudioSrcType src;
  bool overrideDisplayBeheviour;
  PlaybackType? type;
  Color color;
  Function? onPlay;
  Function? onPause;
  PlayPauseIcon(
      {this.playlistOrAlbumId,
      this.songs,
      this.size = 80,
      this.overrideDisplayBeheviour = false,
      this.type,
      this.color = Colors.white,
      this.onPlay,
      this.onPause,
      this.src = AudioSrcType.NETWORK});

  @override
  State<PlayPauseIcon> createState() => _PlayPauseIconState();
  List<Song> fetchedPlaylist = [];
}

class _PlayPauseIconState extends State<PlayPauseIcon> {
  var appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: StreamBuilder(
        stream: appController.player.playerStateStream,
        builder: (context, snapshot) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                  child:
                      (snapshot.data?.playbackState == PlaybackState.PLAYING &&
                                  (appController.selectedAlbumorPlaylistId ==
                                      widget.playlistOrAlbumId) ||
                              (snapshot.data?.playbackState ==
                                      PlaybackState.PLAYING &&
                                  widget.overrideDisplayBeheviour))
                          ? InkWell(
                              onTap: () {
                                widget.onPause ?? appController.player.pause();
                              },
                              child: Icon(
                                Icons.pause_circle_filled_outlined,
                                size: widget.size,
                                color: widget.color,
                              ))
                          : InkWell(
                              onTap: () async {
                                widget.onPlay ?? startPlayback();
                              },
                              child: Icon(
                                Icons.play_circle,
                                size: widget.size,
                                color: widget.color,
                              ))),
              if ((snapshot.data?.playbackState == PlaybackState.BUFFERING &&
                      appController.selectedAlbumorPlaylistId ==
                          widget.playlistOrAlbumId) ||
                  (snapshot.data?.playbackState == PlaybackState.BUFFERING &&
                      widget.overrideDisplayBeheviour))
                const Positioned.fill(
                  child: CircularProgressIndicator(),
                ),
            ],
          );
        },
      ),
    );
  }

  startPlayback() async {
    if (widget.songs?.isNotEmpty == true &&
        (appController.selectedAlbumorPlaylistId != widget.playlistOrAlbumId)) {
      print("song rrrr");
      var songIds = widget.songs!.toSongId();
      var songResult = await appController.getPlaylistSongs(songIds);
      appController.startPlayingAudioFile(songResult!,
          id: widget.playlistOrAlbumId, src: widget.src);
    } else {
      if (widget.playlistOrAlbumId != null) {
        print("fetched playlist ${widget.fetchedPlaylist.length}");
        if (widget.fetchedPlaylist.isEmpty) {
          var songs =
              await appController.getSongIdFromChart(widget.playlistOrAlbumId!);
          setState(() {
            widget.fetchedPlaylist = songs;
          });
        }
        appController.startPlayingAudioFile(widget.fetchedPlaylist,
            id: widget.playlistOrAlbumId, src: widget.src);
      }
    }
    appController.player.play();
  }
}
