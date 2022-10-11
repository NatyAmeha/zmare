import 'package:just_audio_background/just_audio_background.dart';
import 'package:zmare/utils/constants.dart';

class QueueState {
  int? currentIndex;
  List<MediaItem>? queues;
  MediaItem? current;

  QueueState({this.currentIndex, this.queues, this.current});
}

class CustomPlayerState {
  PlaybackState? playbackState;

  CustomPlayerState(this.playbackState);
}
