import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:zema/modals/exception.dart';
import 'package:zema/modals/library.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/modals/user.dart';
import 'package:zema/repo/api_repository.dart';
import 'package:zema/repo/db/db_manager.dart';
import 'package:zema/repo/local_audio_repo.dart';
import 'package:zema/service/permission_service.dart';
import 'package:zema/service/player/player_service.dart';
import 'package:zema/usecase/home_usecase.dart';
import 'package:zema/usecase/song_usecase.dart';
import 'package:zema/usecase/user_usecase.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/viewmodels/browse_viewmodel.dart';
import 'package:zema/viewmodels/home_viewmodel.dart';
import 'package:zema/viewmodels/search_viewmodel.dart';

import '../repo/shared_pref_repo.dart';

class AppController extends GetxController {
  var player = JustAudioPlayer();
  final ReceivePort _port = ReceivePort();

  var _isDataLoading = true.obs;
  get isDataLoading => _isDataLoading.value;

  var _isLoading = false.obs;
  get isLoading => _isLoading.value;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  var _isFavoriteSong = false.obs;
  bool get isFavoriteSong => _isFavoriteSong.value;

  removeException() {
    _exception(AppException());
  }

  var loggedInUser = User().obs;
  User get loggedInUserResult => loggedInUser.value;

  var _homeResult = HomeViewmodel().obs;
  HomeViewmodel get homeResult => _homeResult.value;

  HomeViewmodel? localAudioFiles;

  var _browseResult = BrowseViewmodel().obs;
  BrowseViewmodel get browseResult => _browseResult.value;

  var _searchResult = SearchViewmodel().obs;
  SearchViewmodel get searhResult => _searchResult.value;

  // var _libraryResult = Library().obs;
  Library? libraryResult;

  @override
  onInit() {
    getHomeData();
    super.onInit();
  }

  startPlayingAudioFile(List<Song> songs,
      {int index = 0, AudioSrcType src = AudioSrcType.NETWORK}) async {
    await player.load(songs, index: index);
    await player.play();
  }

  getHomeData() async {
    try {
      _isDataLoading(true);
      var usecase = HomeUsecase(repo: ApiRepository<HomeViewmodel>());
      var result = await usecase.getHomeData();
      _isDataLoading(false);
      _homeResult(result);
    } catch (ex) {
      print("error ${ex.toString()}");
      _isDataLoading(false);
      _exception(ex as AppException);
    }
  }

  getBrowseResult(String category) async {
    try {
      _isDataLoading(true);
      var usecase = HomeUsecase(repo: ApiRepository<BrowseViewmodel>());
      var result = await usecase.getBrowseResult(category);
      _isDataLoading(false);
      print(result?.topSongs?.length);
      _browseResult(result);
    } catch (ex) {
      print("error ${ex.toString()}");
      _isDataLoading(false);
      _exception(ex as AppException);
    }
  }

  getSearchResult(String query) async {
    try {
      _isDataLoading(true);
      var usecase = HomeUsecase(repo: ApiRepository<SearchViewmodel>());
      var result = await usecase.getSearchResult(query);
      _isDataLoading(false);
      _searchResult(result);
    } catch (ex) {
      print("error ${ex.toString()}");
      _isDataLoading(false);
      _exception(ex as AppException);
    }
  }

  getLocalAudioFiles() async {
    _exception(AppException());
    ;
    try {
      _isDataLoading(true);
      var usecase = HomeUsecase(
          repo: LocalAudioRepo(), permissionService: PermissionService());
      var result = await usecase.getLocalAudioFiles();
      print("playlist local ${result.playlists?.length}");
      _isDataLoading(false);
      localAudioFiles = result;
    } catch (ex) {
      print("error ${ex.toString()}");
      _isDataLoading(false);
      _exception(ex as AppException);
    }
  }

  Future<Library?> getAllUserLibrary() async {
    try {
      _isDataLoading(true);
      var userUsecase = UserUsecase(repo: ApiRepository<User>());
      var result = await userUsecase.getUserLibraryInfo<Library>("/library");
      _isDataLoading(false);
      libraryResult = result;
      print(result?.likedAlbums?.length);
      return result;
    } catch (ex) {
      _isDataLoading(false);
      print(ex.toString());
      _exception(ex as AppException);
    }
  }

  Future<String?> getUserId() async {
    var userUsecase =
        UserUsecase(sharedPrefRepo: const SharedPreferenceRepository<String>());
    var userIdResult = await userUsecase.getUserIdFromPref();
    return userIdResult;
  }

  likeSong(List<String> songIds) async {
    try {
      _isLoading(true);
      var albumUsecase = SongUsecase(repo: ApiRepository<Song>());
      var result = await albumUsecase.likeSong(songIds);
      _isLoading(false);
      _isFavoriteSong(true);
    } catch (ex) {
      print("error ${ex.toString()}");
      _isLoading(false);
      _exception(ex as AppException);
    }
  }

  unlikeSong(List<String> songIds) async {
    try {
      _isLoading(true);
      var albumUsecase = SongUsecase(repo: ApiRepository<Song>());
      var result = await albumUsecase.unlikeSong(songIds);
      _isLoading(false);
      _isFavoriteSong(true);
    } catch (ex) {
      print("error ${ex.toString()}");
      _isLoading(false);
      _exception(ex as AppException);
    }
  }

  isSongLiked(String songIds) async {
    try {
      _isLoading(true);
      var albumUsecase = SongUsecase(repo: ApiRepository<Song>());
      var result = await albumUsecase.isSongFavorite(songIds);
      _isLoading(false);
      _isFavoriteSong(true);
    } catch (ex) {
      print("error ${ex.toString()}");
      _isLoading(false);
      _exception(ex as AppException);
    }
  }

  // flutter downloader callback functions
  // static downloadCallback(0)

  // createIsolate() {
  //    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
  //   _port.listen((dynamic data) {
  //     String id = data[0];
  //     DownloadTaskStatus status = data[1];
  //     int progress = data[2];

  //   });
  // }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }
}
