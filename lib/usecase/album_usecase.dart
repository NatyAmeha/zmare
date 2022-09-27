import 'package:zema/modals/album.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/repo/repository.dart';

class AlbumUsecase {
  IRepositroy? repo;

  AlbumUsecase({this.repo});
  Future<Album?> getAlbum(String albumId) async {
    var result = await repo?.get("/album/$albumId") as Album;
    print("album result");

    return result;
  }
}
