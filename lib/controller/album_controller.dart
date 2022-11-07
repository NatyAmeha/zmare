import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/modals/album.dart';
import 'package:zmare/modals/exception.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/repo/api_repository.dart';
import 'package:zmare/repo/db/db_repo.dart';
import 'package:zmare/repo/db/download_db_repo.dart';
import 'package:zmare/repo/local_audio_repo.dart';
import 'package:zmare/screens/account_onboarding_screen.dart';
import 'package:zmare/screens/account_screen.dart';
import 'package:zmare/screens/browse_screen.dart';
import 'package:zmare/usecase/album_usecase.dart';
import 'package:zmare/usecase/download_usecase.dart';
import 'package:zmare/usecase/home_usecase.dart';
import 'package:zmare/usecase/user_usecase.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';

class AlbumController extends GetxController {
  var appController = Get.find<AppController>();

  var _isDataLoading = true.obs;
  get isDataLoading => _isDataLoading.value;

  var _isLoading = false.obs;
  get isLoading => _isLoading.value;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  Album? albumResult;
  var _isAlbumDownloaded = false.obs;
  bool get isAlbumDownloaded => _isAlbumDownloaded.value;

  var _isFavoriteAlbum = false.obs;
  bool get isFavoriteAlbum => _isFavoriteAlbum.value;

  List<Album>? albumList;

  @override
  void onInit() {
    var id = Get.parameters["id"];
    print("album id $id");
    super.onInit();
  }

  getAlbum(String albumId, {PlaybackSrc src = PlaybackSrc.NETWORK}) async {
    try {
      _isDataLoading(true);
      var albumUsecase = AlbumUsecase(repo: ApiRepository<Album>());
      var result = await albumUsecase.getAlbum(albumId);
      var albumSongs = result?.songs?.map((e) => Song.fromJson(e)).toList();
      albumResult = result;
      albumResult!.songs = albumSongs;
      checkIsAlbumDownloaded();
    } catch (ex) {
      print("error ${ex.toString()}");
      var exception = ex as AppException;
      exception.action = () {
        _exception(AppException());
        getAlbum(albumId, src: src);
      };
      _exception(exception);
    } finally {
      _isDataLoading(false);
    }
  }

  getAlbumFromLocalStorage(Album albumInfo) async {
    _exception(AppException());
    try {
      _isDataLoading(true);
      var albumUsecase = HomeUsecase(repo: LocalAudioRepo());
      var songResult = await albumUsecase.getSongsFrom(
          albumInfo.id!, AudiosFromType.ALBUM_ID);
      _isDataLoading(false);
      albumInfo.songs = songResult;
      albumResult = albumInfo;

      return albumInfo;
    } catch (ex) {
      print("error ${ex.toString()}");
      _isDataLoading(false);
      _exception(ex as AppException);
    }
  }

  getUserFavoriteAlbums() async {
    try {
      _isDataLoading(true);
      var userUsecase = UserUsecase(repo: ApiRepository());
      var result = await userUsecase.getUserLibrary<Album>("/library", "album");
      print(result);
      albumList = result;
      if (result.isEmpty) {
        _exception(
          AppException(
            message: "Your favorite albums will collected here",
            title: "No album found",
            actionText: "Browse Albums",
            action: () {
              UIHelper.moveBack();
              UIHelper.moveToScreen(BrowseScreen.routeName,
                  navigatorId: UIHelper.bottomNavigatorKeyId);
            },
          ),
        );
      }
    } catch (ex) {
      print("error ${ex.toString()}");
      _exception(ex as AppException);
    } finally {
      _isDataLoading(false);
    }
  }

  likeAlbum(String albumId) async {
    try {
      _isDataLoading(true);
      var albumUsecase = AlbumUsecase(repo: ApiRepository<Album>());
      var result = await albumUsecase.likeAlbum(albumId);
      _isFavoriteAlbum(true);
    } catch (ex) {
      print("error ${ex.toString()}");
      var exception = ex as AppException;
      if (exception.type == AppException.UNAUTORIZED_EXCEPTION) {
        UIHelper.showSnackBar("Sign in to continue", actionText: "Sign in",
            onclick: () {
          UIHelper.moveToScreen(AccountOnboardingScreen.routName);
        });
      }
    } finally {
      _isDataLoading(false);
    }
  }

  unlikeAlbum(String albumId) async {
    try {
      _isDataLoading(true);
      var albumUsecase = AlbumUsecase(repo: ApiRepository<Album>());
      var result = await albumUsecase.unlikeAlbum(albumId);
      _isFavoriteAlbum(false);
    } catch (ex) {
      print("error ${ex.toString()}");
      var exception = ex as AppException;
      if (exception.type == AppException.UNAUTORIZED_EXCEPTION) {
        UIHelper.showSnackBar("Sign in to continue", actionText: "Sign in",
            onclick: () {
          UIHelper.moveToScreen(AccountOnboardingScreen.routName);
        });
      }
    } finally {
      _isDataLoading(false);
    }
  }

  downloadAlbum(List<Song> albumSongs, String albumId, String albumName) async {
    try {
      _isDataLoading(true);
      var downloadUsecase = DownloadUsecase(repositroy: DownloadRepository());
      var result = await downloadUsecase.startDownload(
          albumSongs, "", DownloadType.ALBUM, albumId, albumName);
      print("Download result ${result}");
    } catch (ex) {
      _exception(ex as AppException);
    } finally {
      _isDataLoading(false);
    }
  }

  checkAlbumFavorite(String albumId) async {
    try {
      _isLoading(true);
      var albumUsecase = AlbumUsecase(repo: ApiRepository<Album>());
      var result = await albumUsecase.isAlbumInFavorite(albumId);
      _isLoading(false);
      _isFavoriteAlbum(result);
    } catch (ex) {
      print("error ${ex.toString()}");
      _isLoading(false);
      // _exception(ex as AppException);
    }
  }

  checkIsAlbumDownloaded() async {
    try {
      _isDataLoading(true);
      var downloadUsecase = DownloadUsecase(repositroy: DownloadRepository());
      if (albumResult?.songs != null) {
        var result =
            await downloadUsecase.isPlaylistDownloaded(albumResult!.id!);
        _isAlbumDownloaded(result);
      } else {
        UIHelper.showSnackBar("Unable to download playlist",
            type: SnackbarType.ERROR_SNACKBAR);
      }
    } catch (ex) {
      print("error ${ex.toString()}");
      // _exception(ex as AppException);
    } finally {
      _isDataLoading(false);
    }
  }
}
