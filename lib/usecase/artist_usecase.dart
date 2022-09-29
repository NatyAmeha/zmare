import 'package:zema/repo/repository.dart';
import 'package:zema/viewmodels/artist_viewmodel.dart';

class ArtistUsecase {
  IRepositroy? repo;

  ArtistUsecase({this.repo});

  Future<ArtistViewmodel> getArtistInfo(String artistId) async {
    var result = await repo?.get("/artist/$artistId");
    return result;
  }

  Future<bool> followArtist(String artistId) async {
    var result = await repo!
        .update<bool, List<String>>("/artist/follow", body: [artistId]);
    return result;
  }

  Future<bool> unfollowArtist(String artistId) async {
    var result = await repo!
        .update<bool, List<String>>("/artist/unfollow", body: [artistId]);
    return result;
  }

  Future<bool> isArtistInFavorite(String artistId) async {
    var result = await repo!.update<bool, dynamic>(
        "/library/checkartistinfavorite",
        queryParameters: {"artistid": artistId});
    return result;
  }
}
