import 'package:zmare/modals/song.dart';
import 'package:zmare/repo/repository.dart';

class SongUsecase {
  IRepositroy? repo;
  SongUsecase({this.repo});

  Future<bool> likeSong(List<String> songIds) async {
    var result = await repo!.update("/library/likesong", body: songIds);
    return result;
  }

  Future<bool> unlikeSong(List<String> songIds) async {
    var result = await repo!.update("/library/removelikesong", body: songIds);
    return result;
  }

  Future<List<Song>> getSongIdFromChart(String playlistId) async {
    var result = await repo!
        .getAll<Song>("/chart/songs", queryParameters: {"id": playlistId});
    return result;
  }

  Future<bool> updateStreamCount(String songId) async {
    var result = await repo!.update<bool, dynamic>("/song/updatestream",
        queryParameters: {"id": songId});
    return result;
  }

  Future<List<Song>> getSongsByid(List<String> songIds) async {
    var result = await repo!
        .getAll<Song>("/songs/find", queryParameters: {"ids": songIds});
    return result;
  }

  Future<bool> isSongFavorite(String songId) async {
    var result = await repo!.update("/library/checksongfavorite",
        queryParameters: {"songid": songId});
    return result;
  }
}
