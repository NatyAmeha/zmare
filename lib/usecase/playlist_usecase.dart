import 'package:zema/modals/playlist.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/repo/repository.dart';
import 'package:zema/service/player/player_service.dart';
import 'package:zema/utils/constants.dart';

class PlaylistUsecase {
  IRepositroy? repo;
  IPlayer? player;

  PlaylistUsecase({this.repo, this.player});

  Future<Playlist?> getPlaylist(String playlistId) async {
    var result = await repo?.get<Playlist>("/playlist/$playlistId");
    return result;
  }

  Future<void> playPlaylist(List<Song> songs, AudioSrcType src) async {
    var duration = await player!.load(songs, src: src);
    player!.play();
  }
}
