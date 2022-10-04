import 'package:on_audio_query/on_audio_query.dart';
import 'package:zema/modals/album.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/repo/local_audio_repo.dart';
import 'package:zema/repo/repository.dart';

class AlbumUsecase {
  IRepositroy? repo;

  AlbumUsecase({this.repo});
  Future<Album?> getAlbum(String albumId) async {
    var result = await repo?.get<Album>("/album/$albumId") as Album;
    print("album result");

    return result;
  }

  Future<bool> likeAlbum(String albumId) async {
    var result = await repo!.update("/library/likealbum", body: [albumId]);
    return result;
  }

  Future<bool> unlikeAlbum(String albumId) async {
    var result = await repo!.update("/library/removefavalbum", body: [albumId]);
    return result;
  }

  Future<bool> isAlbumInFavorite(String albumId) async {
    var result = await repo!.update("/library/checkalbuminfavorite",
        queryParameters: {"albumid": albumId});
    return result;
  }
}
