import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/utils/constants.dart';

abstract class IPlayer {
  Future<Duration?> load(List<Song> songs, PlaybackSrc src,
      {Duration position, int index});
  play();
  pause();
  next();
  prev();

  PlaybackSrc? playbackSrc;
}

class JustAudioPlayer extends IPlayer {
  late AudioPlayer player;

  JustAudioPlayer() {
    print("audio player instantiated");
    player = AudioPlayer();
  }

  @override
  PlaybackSrc? get playbackSrc => PlaybackSrc.NETWORK;

  static Future<void> initBackgroundPlayback() async {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    );
  }

  @override
  Future<Duration?> load(List<Song> songs, PlaybackSrc src,
      {Duration? position, int index = 0}) async {
    playbackSrc = src;
    try {
      var duration = await player.setAudioSource(
        ConcatenatingAudioSource(
          children: songs
              .map(
                (song) => AudioSource.uri(
                  Uri.parse(song.songFilePath!),
                  tag: MediaItem(
                    id: song.id!,
                    title: song.title!,
                    album: song.albumName,
                    artUri: Uri.parse(song.thumbnailPath!),
                    artist: song.artistsName?.join(","),
                  ),
                ),
              )
              .toList(),
        ),
        // initialIndex: index,
        // initialPosition: position
      );
      return duration;
    } catch (ex) {
      print(ex.toString());
      return Future.error(ex);
    }
  }

  @override
  next() {
    player.seekToNext();
  }

  @override
  pause() {
    player.pause();
  }

  @override
  play() {
    print("playlist song");
    player.play();
  }

  @override
  prev() {
    player.seekToPrevious();
  }
}
