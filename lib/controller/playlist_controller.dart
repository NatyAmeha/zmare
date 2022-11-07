import 'dart:math';

import 'package:darq/darq.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/modals/exception.dart';
import 'package:zmare/modals/playlist.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/repo/api_repository.dart';
import 'package:zmare/repo/db/download_db_repo.dart';
import 'package:zmare/screens/account_onboarding_screen.dart';
import 'package:zmare/screens/browse_screen.dart';
import 'package:zmare/service/player/player_service.dart';
import 'package:zmare/usecase/download_usecase.dart';
import 'package:zmare/usecase/home_usecase.dart';
import 'package:zmare/usecase/playlist_usecase.dart';
import 'package:zmare/usecase/song_usecase.dart';
import 'package:zmare/usecase/user_usecase.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/viewmodels/browse_viewmodel.dart';

class PlaylistController extends GetxController {
  var appController = Get.find<AppController>();

  var _isDataLoading = true.obs;
  get isDataLoading => _isDataLoading.value;

  var _isLoading = false.obs;
  get isLoading => _isLoading.value;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  var _isFavoritePlaylist = false.obs;
  bool get isFavoritePlaylist => _isFavoritePlaylist.value;

  var _isPlaylistDownloaded = false.obs;
  bool get isPlaylistDownloaded => _isPlaylistDownloaded.value;

  BrowseViewmodel? recommendation;

  Playlist? playlistResult;
  List<Song> _playlistSongs = [];
  set playlistSongs(List<Song> songs) => _playlistSongs = songs;
  List<Song> get playlistSongs => _playlistSongs;

  List<Playlist>? playlists;

  List<String>? get playlistImages {
    if (playlistSongs.isNotEmpty) {
      var songImages = playlistSongs.map((e) => e.thumbnailPath!).toList();
      songImages.shuffle();
      return songImages;
    } else
      return [""];
    ;
  }

  getPlaylist(String playlistId) async {
    try {
      _isDataLoading(true);
      var usecase = PlaylistUsecase(repo: ApiRepository<Playlist>());
      var result = await usecase.getPlaylist(playlistId);
      var songs = result?.songs?.map((e) => Song.fromJson(e)).toList();
      playlistSongs = songs ?? [];

      playlistResult = result;
      // playlistResult!.songs = playlistSongs;
      _isDataLoading(false);

      checkPlaylistDownloaded();
    } catch (ex) {
      print(ex.toString());
      var exception = ex as AppException;
      exception.action = () {
        _exception(AppException());
        getPlaylist(playlistId);
      };
      _exception(exception);
    }
  }

  getPlaylistSongs(Playlist playlistInfo) async {
    try {
      _isDataLoading(true);
      var songs = playlistInfo.songs?.cast<String>();
      var usecase = SongUsecase(repo: ApiRepository<Playlist>());
      if (songs?.isNotEmpty == true) {
        var songResult = await usecase.getSongsByid(songs!);

        playlistResult = playlistInfo;
        playlistSongs = songResult;
      }
    } catch (ex) {
      print(ex.toString());
      var exception = ex as AppException;
      exception.action = () {
        _exception(AppException());
        getPlaylistSongs(playlistInfo);
      };
      _exception(exception);
    } finally {
      _isDataLoading(false);
    }
  }

  checkPlaylistDownloaded() async {
    try {
      _isDataLoading(true);
      var downloadUsecase = DownloadUsecase(repositroy: DownloadRepository());
      if (playlistResult?.songs != null) {
        var result =
            await downloadUsecase.isPlaylistDownloaded(playlistResult!.id!);
        _isPlaylistDownloaded(result);
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

  downloadPlaylist() async {
    try {
      _isDataLoading(true);
      var downloadUsecase = DownloadUsecase(repositroy: DownloadRepository());
      if (playlistResult?.songs != null) {
        var result = await downloadUsecase.startDownload(
            playlistResult!.songs!.map((e) => Song.fromJson(e)).toList(),
            "",
            DownloadType.PLAYLIST,
            playlistResult!.id!,
            playlistResult!.name!);
        _isPlaylistDownloaded(true);
      } else {
        UIHelper.showSnackBar("Unable to download playlist",
            type: SnackbarType.ERROR_SNACKBAR);
      }
    } catch (ex) {
      print("error ${ex.toString()}");
      _exception(ex as AppException);
    } finally {
      _isDataLoading(false);
    }
  }

  followPlaylist(String playlistId) async {
    try {
      _isDataLoading(true);
      var playlistUsecase = PlaylistUsecase(repo: ApiRepository());
      var result = await playlistUsecase.likePlaylist(playlistId);

      _isFavoritePlaylist(true);
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

  unfollowPlaylist(String playlistId) async {
    try {
      _isDataLoading(true);
      var playlistUsecase = PlaylistUsecase(repo: ApiRepository());
      var result = await playlistUsecase.unlikePlaylist(playlistId);
      _isFavoritePlaylist(false);
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

  checkPlaylistInFavorite(String playlistId) async {
    try {
      _isDataLoading(true);
      var playlistUsecase = PlaylistUsecase(repo: ApiRepository());
      var result = await playlistUsecase.isPlaylistInFavorite(playlistId);

      print("playlist fav $result");
      _isFavoritePlaylist(result);
    } catch (ex) {
      print("error ${ex.toString()}");

      // _exception(ex as AppException);
    } finally {
      _isLoading(false);
    }
  }

  Future<Playlist?> createPlaylist(Playlist playlistInfo) async {
    try {
      playlistInfo.filter = "USER_PLAYLIST";
      playlistInfo.category = "GOSPEL";

      _isDataLoading(true);
      var playlistUsecase = PlaylistUsecase(repo: ApiRepository());
      var result = await playlistUsecase.createPlaylist(playlistInfo);
      return result;
    } catch (ex) {
      print("error ${ex.toString()}");
      UIHelper.handleException(ex as AppException,
          message: "Unable to create playlist");

      return null;
    } finally {
      _isDataLoading(false);
    }
  }

  getUserFavoritePlaylists() async {
    try {
      _isDataLoading(true);
      var userUsecase = PlaylistUsecase(repo: ApiRepository());
      var result = await userUsecase.getUserPlaylists();
      print(result);
      playlists = result;
      if (result?.isEmpty == true) {
        _exception(
          AppException(
            message:
                "Your playlist and playlist you follow will collected here",
            title: "No playlist found",
            actionText: "Browse songs",
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

  getSongRecommendation() async {
    try {
      _isDataLoading(true);
      var usecase = HomeUsecase(repo: ApiRepository<BrowseViewmodel>());
      var result = await usecase.getBrowseResult("GOSPEL");
      recommendation = result;
    } catch (ex) {
      print("error ${ex.toString()}");
      _exception(ex as AppException);
    } finally {
      _isDataLoading(false);
    }
  }

  playPlaylist(List<Song> songs) async {
    var playlistUsecase = PlaylistUsecase(player: appController.player);
    await playlistUsecase.playPlaylist(songs, AudioSrcType.NETWORK);
  }
}
