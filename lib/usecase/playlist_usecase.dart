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

  Future<List<Playlist>?> getUserPlaylists() async {
    var result = await repo?.getAll<Playlist>("/playlist");
    return result;
  }

  Future<void> playPlaylist(List<Song> songs, AudioSrcType src) async {
    var duration = await player!.load(songs, src: src);
    player!.play();
  }

  Future<bool> likePlaylist(String playlistId) async {
    var result = await repo!
        .update("/playlist/follow", queryParameters: {"id": playlistId});
    return result;
  }

  Future<bool> unlikePlaylist(String playlistId) async {
    var result = await repo!
        .update("/playlist/unfollow", queryParameters: {"id": playlistId});
    return result;
  }

  Future<bool> isPlaylistInFavorite(String albumId) async {
    var result = await repo!
        .update("/playlist/checkfavorite", queryParameters: {"id": albumId});
    return result;
  }

  Future<Playlist> createPlaylist(Playlist playlistInfo) async {
    var result = await repo!
        .create<Playlist, Playlist>("/playlist/create", playlistInfo);
    return result;
  }
}
