import 'package:zmare/modals/artist.dart';
import 'package:zmare/repo/repository.dart';
import 'package:zmare/viewmodels/artist_viewmodel.dart';

class ArtistUsecase {
  IRepositroy? repo;

  ArtistUsecase({this.repo});

  Future<ArtistViewmodel?> getArtistInfo(String artistId) async {
    var result = await repo?.get<ArtistViewmodel>("/artist/$artistId");
    return result;
  }

  Future<List<Artist>?> getAllArtists() async {
    var result = await repo?.getAll<Artist>("/artists");
    return result;
  }

  Future<bool> followArtist(String artistId) async {
    var result = await repo!
        .update<bool, List<String>>("/artist/follow", body: [artistId]);
    return result;
  }

  Future<bool> followArtists(List<String> artistIds) async {
    var result = await repo!
        .update<bool, List<String>>("/library/followartist", body: artistIds);
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
