import 'package:get/get.dart';
import 'package:zema/controller/app_controller.dart';
import 'package:zema/modals/artist.dart';
import 'package:zema/modals/exception.dart';
import 'package:zema/repo/api_repository.dart';
import 'package:zema/usecase/artist_usecase.dart';
import 'package:zema/usecase/user_usecase.dart';
import 'package:zema/viewmodels/artist_viewmodel.dart';

class ArtistController extends GetxController {
  var appController = Get.find<AppController>();
  // for data loading
  var _isDataLoading = true.obs;
  get isDataLoading => _isDataLoading.value;

  // for operation loading
  var _isLoading = false.obs;
  get isLoading => _isLoading.value;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  var _artistResult = ArtistViewmodel().obs;
  ArtistViewmodel get artistResult => _artistResult.value;
  var isFollowing = false.obs;

  List<Artist>? artistList;

  // checkArtistFollowing() async {
  //   var userId = await appController.getUserId();
  //   print("userid $userId ${artistResult.artist?.followersId}");
  //   isFollowing(userId != null &&
  //       artistResult.artist?.followersId?.contains(userId) == true);
  // }

  getArtist(String artistId) async {
    try {
      _isDataLoading(true);
      var artistUsecase = ArtistUsecase(repo: ApiRepository<ArtistViewmodel>());
      var result = await artistUsecase.getArtistInfo(artistId);
      _isDataLoading(false);
      _artistResult(result);
    } catch (ex) {
      _isDataLoading(false);
      print(ex.toString());
      _exception(ex as AppException);
    }
  }

  followArtist(String artistId) async {
    try {
      _isLoading(true);
      var artistUsecase = ArtistUsecase(repo: ApiRepository());
      var result = await artistUsecase.followArtist(artistId);
      _isLoading(false);
      isFollowing(true);
    } catch (ex) {
      _isDataLoading(false);
      print(ex.toString());
      _exception(ex as AppException);
    }
  }

  unfollowArtist(String artistId) async {
    try {
      _isLoading(true);
      var artistUsecase = ArtistUsecase(repo: ApiRepository());
      var result = await artistUsecase.unfollowArtist(artistId);
      _isLoading(false);
      isFollowing(false);
    } catch (ex) {
      // _isDataLoading(false);
      print(ex.toString());
      _exception(ex as AppException);
    }
  }

  isArtistInFavorite(String artistId) async {
    try {
      _isLoading(true);
      var artistUsecase = ArtistUsecase(repo: ApiRepository());
      var result = await artistUsecase.isArtistInFavorite(artistId);
      print("userid  $result");
      _isLoading(false);
      isFollowing(result);
    } catch (ex) {
      _isLoading(false);
      print(ex.toString());
      _exception(ex as AppException);
    }
  }

  getUserFavoriteArtists() async {
    try {
      _isDataLoading(true);
      var userUsecase = UserUsecase(repo: ApiRepository());
      var result =
          await userUsecase.getUserLibrary<Artist>("/library", "artist");
      print("resul ti s");
      print(result);
      artistList = result;
    } catch (ex) {
      print("error ${ex.toString()}");
      _exception(ex as AppException);
    } finally {
      _isDataLoading(false);
    }
  }
}
