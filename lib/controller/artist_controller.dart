import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/modals/album.dart';
import 'package:zmare/modals/artist.dart';
import 'package:zmare/modals/exception.dart';
import 'package:zmare/repo/api_repository.dart';
import 'package:zmare/repo/local_audio_repo.dart';
import 'package:zmare/screens/account_onboarding_screen.dart';
import 'package:zmare/usecase/artist_usecase.dart';
import 'package:zmare/usecase/home_usecase.dart';
import 'package:zmare/usecase/user_usecase.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/viewmodels/artist_viewmodel.dart';

import '../modals/song.dart';

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

  Artist? localArtistResult;

  ArtistViewmodel? artistResult;
  List<Song>? get singleSongs =>
      artistResult?.artist?.singleSongs?.map((e) => Song.fromJson(e)).toList();
  List<Album>? get albums =>
      artistResult?.artist?.albums?.map((e) => Album.fromJson(e)).toList();
  String get rankText {
    if (artistResult?.rank == 1)
      return "1st this month";
    else if (artistResult?.rank == 2)
      return "2nd this month";
    else if (artistResult?.rank == 3)
      return "3rd this month";
    else
      return "${artistResult?.rank} this month";
  }

  var isFollowing = false.obs;

  var selectedArtistId = <String>[].obs;

  List<Artist>? artistList;

  @override
  onInit() {
    print("init called");
    artistResult = null;
    super.onInit();
  }

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
      artistResult = result;
    } catch (ex) {
      _isDataLoading(false);
      print(ex.toString());
      var exception = ex as AppException;
      exception.action = () {
        _exception(AppException());
        getArtist(artistId);
      };
      _exception(exception);
    }
  }

  getArtistInfoFromLocal(Artist artistInfo) async {
    _exception(AppException());
    try {
      _isDataLoading(true);
      var homeUsecase = HomeUsecase(repo: LocalAudioRepo());
      var songResult = await homeUsecase.getSongsFrom(
          artistInfo.id!, AudiosFromType.ARTIST_ID);
      _isDataLoading(false);
      artistInfo.singleSongs = songResult;
      localArtistResult = artistInfo;
    } catch (ex) {
      print("error ${ex.toString()}");
      _isDataLoading(false);
      _exception(ex as AppException);
    }
  }

  followArtist(String artistId) async {
    try {
      _isDataLoading(true);
      var artistUsecase = ArtistUsecase(repo: ApiRepository());
      var result = await artistUsecase.followArtist(artistId);
      _isDataLoading(false);
      isFollowing(true);
    } catch (ex) {
      print(ex.toString());
      var exception = ex as AppException;
      UIHelper.handleException(exception);
    } finally {
      _isLoading(false);
      _isDataLoading(false);
    }
  }

  followArtists(List<String> artistIds) async {
    try {
      _isLoading(true);
      var artistUsecase = ArtistUsecase(repo: ApiRepository());
      var result = await artistUsecase.followArtists(artistIds);
      _isLoading(false);
      isFollowing(true);
    } catch (ex) {
      _isDataLoading(false);
      var exception = ex as AppException;
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

      var exception = ex as AppException;
      if (exception.type == AppException.UNAUTORIZED_EXCEPTION) {
        UIHelper.showSnackBar("Sign in to continue", actionText: "Sign in",
            onclick: () {
          UIHelper.moveToScreen(AccountOnboardingScreen.routName);
        });
      }
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

  getAllArtists() async {
    try {
      _isDataLoading(true);
      var artistRepo = ArtistUsecase(repo: ApiRepository());
      var result = await artistRepo.getAllArtists();
      artistList = result;
    } catch (ex) {
      _exception(ex as AppException);
    } finally {
      _isDataLoading(false);
    }
  }

  // state controller
  addOrRemoveArtistId(String id) {
    print(id);
    if (selectedArtistId.contains(id) == true) {
      selectedArtistId.remove(id);
    } else {
      selectedArtistId.add(id);
    }
  }
}
