import 'package:zmare/modals/playlist.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/repo/repository.dart';
import 'package:zmare/service/player/player_service.dart';
import 'package:zmare/utils/constants.dart';

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
