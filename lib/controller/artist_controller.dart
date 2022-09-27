import 'package:get/get.dart';
import 'package:zema/modals/exception.dart';
import 'package:zema/repo/api_repository.dart';
import 'package:zema/usecase/artist_usecase.dart';
import 'package:zema/viewmodels/artist_viewmodel.dart';

class ArtistController extends GetxController {
  var _isDataLoading = true.obs;
  get isDataLoading => _isDataLoading.value;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;
  var _artistResult = ArtistViewmodel().obs;
  ArtistViewmodel get artistResult => _artistResult.value;

  getArtist(String artistId) async {
    try {
      _isDataLoading(true);
      var artistUsecase = ArtistUsecase(repo: ApiRepository<ArtistViewmodel>());
      var result = await artistUsecase.getArtistInfo(artistId);
      _isDataLoading(false);
      _artistResult(result);
    } catch (ex) {
      print(ex.toString());
      _exception(ex as AppException);
    }
  }
}
