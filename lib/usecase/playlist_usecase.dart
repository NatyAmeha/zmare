import 'package:zema/modals/playlist.dart';
import 'package:zema/repo/repository.dart';

class PlaylistUsecase {
  IRepositroy? repo;

  PlaylistUsecase({this.repo});

  Future<Playlist?> getPlaylist(String playlistId) async {
    var result = await repo?.get<Playlist>("/playlist/$playlistId");
    return result;
  }
}
