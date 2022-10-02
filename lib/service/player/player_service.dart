import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/viewmodels/queue_state.dart';

abstract class IPlayer {
  Future<Duration?> load(List<Song> songs,
      {PlaybackSrc src, Duration position, int index});
  play();
  pause();
  next();
  prev();

  PlaybackSrc? playbackSrc;
  List<MediaItem>? queue;
  Stream<QueueState?>? queueState;
  Stream<CustomPlayerState>? playerState;
}

class JustAudioPlayer extends IPlayer {
  late AudioPlayer player;

  JustAudioPlayer() {
    print("audio player instantiated");
    player = AudioPlayer();
  }

  @override
  PlaybackSrc? get playbackSrc => PlaybackSrc.NETWORK;

  @override
  List<MediaItem>? get queue => [];

  @override
  Stream<QueueState?> get queueState =>
      player.sequenceStateStream.map((stream) => QueueState(
          currentIndex: stream?.currentIndex,
          current: stream?.currentSource?.tag as MediaItem,
          queues: stream?.sequence.map((e) => e.tag as MediaItem).toList()));

  static Future<void> initBackgroundPlayback() async {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    );
  }

  @override
  Stream<CustomPlayerState>? get playerState => player.playerStateStream.map(
        (event) {
          var a = event.playing;
          switch (event.processingState) {
            case ProcessingState.loading:
            case ProcessingState.buffering:
              return CustomPlayerState(PlaybackState.BUFFERING);
            case ProcessingState.ready:
              if (player.playing) {
                return CustomPlayerState(PlaybackState.PLAYING);
              } else {
                return CustomPlayerState(PlaybackState.PAUSED);
              }

            default:
              return CustomPlayerState(PlaybackState.IDLE);
          }
        },
      );

  @override
  Future<Duration?> load(List<Song> songs,
      {PlaybackSrc src = PlaybackSrc.NETWORK,
      Duration? position,
      int index = 0}) async {
    playbackSrc = src;
    try {
      queue = songs
          .map(
            (song) => MediaItem(
              id: song.id!,
              title: song.title!,
              album: song.albumName,
              artUri: Uri.parse(song.thumbnailPath!),
              artist: song.artistsName?.join(","),
            ),
          )
          .toList();
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
        initialIndex: index,
        initialPosition: position,
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
