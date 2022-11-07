import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/extension.dart';
import 'package:zmare/viewmodels/queue_state.dart';
import 'package:zmare/utils/constants.dart';

abstract class IPlayer {
  Future<Duration?> load(List<Song> songs,
      {AudioSrcType src, Duration position, int index});

  Future<Duration?> loadPreviousQueue();
  play();
  pause();
  next();
  prev();
  stop({bool savetoPreviousQueue});
  seek(Duration position, {int? index});
  addToQueue(Song song, {int? index, AudioSrcType? src});
  removeFromQueue(int index);

  Song? getCurrentSongInfo();

  // used to save list of songs and index when user navigate from preview player to main player and viceversa
  List<Song> savedQueues = [];
  int savedQueueIndex = 0;
  Duration savedPosition = Duration.zero;

  AudioSrcType? playbackSrc;
  List<MediaItem>? queue;
  QueueState? queueState;
  Stream<QueueState?>? queueStateStream;

  CustomPlayerState? playerState;
  Stream<CustomPlayerState>? playerStateStream;
  Stream<Duration>? position;
  Stream<Duration?>? totalDurationStream;
  Duration? duration;
}

class JustAudioPlayer extends IPlayer {
  late AudioPlayer player;
  List<Song> loadedSongs = [];
  ConcatenatingAudioSource? audioQueueList;

  JustAudioPlayer() {
    print("audio player instantiated");
    player = AudioPlayer();
  }

  @override
  AudioSrcType? get playbackSrc => AudioSrcType.NETWORK;

  @override
  List<MediaItem>? get queue => [];

  @override
  QueueState? get queueState => QueueState(
      currentIndex: player.sequenceState?.currentIndex,
      current: player.sequenceState?.currentSource?.tag as MediaItem,
      queues: player.sequenceState?.sequence
          .map((e) => e.tag as MediaItem)
          .toList());

  @override
  Stream<QueueState?> get queueStateStream =>
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
  CustomPlayerState? get playerState {
    switch (player.playerState.processingState) {
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
  }

  @override
  Stream<CustomPlayerState>? get playerStateStream =>
      player.playerStateStream.map(
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
  Stream<Duration?>? get totalDurationStream => player.durationStream;

  @override
  Duration? get duration => player.duration;

  @override
  List<Song> savedQueues = [];

  @override
  int savedQueueIndex = 0;

  @override
  Duration savedPosition = Duration.zero;

  @override
  Future<Duration?> load(
    List<Song> songs, {
    AudioSrcType src = AudioSrcType.NETWORK,
    Duration? position,
    int index = 0,
  }) async {
    loadedSongs = songs;
    playbackSrc = src;
    try {
      queue = songs
          .map(
            (song) => MediaItem(
              id: song.id!,
              title: song.title!,
              album: song.albumName,
              extras: {
                "songFile": song.songFilePath,
                "artistNames": song.artistsName?.join(",")
              },
              artUri: song.thumbnailPath != null
                  ? Uri.parse(song.thumbnailPath!)
                  : null,
              artist: song.artists?.join(","),
            ),
          )
          .toList();

      audioQueueList = ConcatenatingAudioSource(
          children: songs.map((song) => song.toAudioSource()).toList());

      var duration = await player.setAudioSource(audioQueueList!,
          initialIndex: index, initialPosition: position);
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

  @override
  stop({bool savetoPreviousQueue = false}) {
    if (savetoPreviousQueue) {
      savedQueues = loadedSongs;
      savedQueueIndex = player.currentIndex ?? 0;
      savedPosition = player.position;
    }
    player.stop();
  }

  @override
  Future<Duration?> loadPreviousQueue() async {
    var result = await load(savedQueues,
        index: savedQueueIndex,
        position: savedPosition,
        src: playbackSrc ?? AudioSrcType.NETWORK);
    return result;
  }

  @override
  addToQueue(Song song, {int? index, AudioSrcType? src}) async {
    if (audioQueueList == null) {
      await load([song], src: src ?? AudioSrcType.NETWORK);
      play();
    } else {
      var audioSource = song.toAudioSource();
      if (index != null) {
        audioQueueList?.insert(index, audioSource);
      } else {
        audioQueueList?.add(audioSource);
      }
    }
  }

  @override
  removeFromQueue(int index) {
    if (audioQueueList?.children.isNotEmpty == true) {
      audioQueueList?.removeAt(index);
    }
  }

  @override
  Song? getCurrentSongInfo() {
    if (loadedSongs.isNotEmpty && player.currentIndex != null) {
      return loadedSongs[player.currentIndex!];
    }
    return null;
  }
}
