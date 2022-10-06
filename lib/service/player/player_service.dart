import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/viewmodels/queue_state.dart';

abstract class IPlayer {
  Future<Duration?> load(List<Song> songs,
      {AudioSrcType src, Duration position, int index});
  play();
  pause();
  next();
  prev();
  seek(Duration position, {int? index});

  AudioSrcType? playbackSrc;
  List<MediaItem>? queue;
  Stream<QueueState?>? queueState;
  Stream<CustomPlayerState>? playerState;
  Stream<Duration>? position;
  Stream<Duration?>? totalDuration;
}

class JustAudioPlayer extends IPlayer {
  late AudioPlayer player;

  JustAudioPlayer() {
    print("audio player instantiated");
    player = AudioPlayer();
  }

  @override
  AudioSrcType? get playbackSrc => AudioSrcType.NETWORK;

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
  Stream<Duration>? get position => player.positionStream;

  @override
  Stream<Duration?>? get totalDuration => player.durationStream;

  @override
  Future<Duration?> load(List<Song> songs,
      {AudioSrcType src = AudioSrcType.NETWORK,
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
              extras: {"songFile": song.songFilePath},
              artUri: song.thumbnailPath != null
                  ? Uri.parse(song.thumbnailPath!)
                  : null,
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
                    extras: {"songFile": song.songFilePath},
                    artUri: song.thumbnailPath != null
                        ? Uri.parse(song.thumbnailPath!)
                        : null,
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
    player.play();
  }

  @override
  pause() {
    player.pause();
  }

  @override
  play() {
    player.play();
  }

  @override
  prev() {
    player.seekToPrevious();
    player.play();
  }

  @override
  seek(Duration position, {int? index}) {
    player.seek(position, index: index);
  }
}
