import 'package:zema/repo/repository.dart';

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

  Future<bool> isSongFavorite(String songId) async {
    var result = await repo!.update("/library/checksongfavorite",
        queryParameters: {"songid": songId});
    return result;
  }
}
