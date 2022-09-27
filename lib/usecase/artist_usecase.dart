import 'package:zema/repo/repository.dart';
import 'package:zema/viewmodels/artist_viewmodel.dart';

class ArtistUsecase {
  IRepositroy? repo;

  ArtistUsecase({this.repo});

  Future<ArtistViewmodel> getArtistInfo(String artistId) async {
    var result = await repo?.get("/artist/$artistId");
    return result;
  }
}
