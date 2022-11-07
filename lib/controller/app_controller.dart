import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:zmare/modals/album.dart';
import 'package:zmare/modals/exception.dart';
import 'package:zmare/modals/library.dart';
import 'package:zmare/modals/playlist.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/modals/user.dart';
import 'package:zmare/repo/api_repository.dart';
import 'package:zmare/repo/db/db_manager.dart';
import 'package:zmare/repo/db/download_db_repo.dart';
import 'package:zmare/repo/local_audio_repo.dart';
import 'package:zmare/screens/account_onboarding_screen.dart';
import 'package:zmare/screens/login_screen.dart';
import 'package:zmare/screens/onboarding/onboarding_screen.dart';
import 'package:zmare/service/account_service.dart';
import 'package:zmare/service/permission_service.dart';
import 'package:zmare/service/player/player_service.dart';
import 'package:zmare/usecase/download_usecase.dart';
import 'package:zmare/usecase/home_usecase.dart';
import 'package:zmare/usecase/song_usecase.dart';
import 'package:zmare/usecase/user_usecase.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/viewmodels/browse_viewmodel.dart';
import 'package:zmare/viewmodels/home_viewmodel.dart';
import 'package:zmare/viewmodels/search_viewmodel.dart';

import '../repo/shared_pref_repo.dart';

class AppController extends GetxController {
  var player = JustAudioPlayer();
  // album or playlist id currently playing
  String? selectedAlbumorPlaylistId = "init_id";
  final ReceivePort _port = ReceivePort();

  var selectedBottomPageIndex = 0.obs;

  var _isDataLoading = true.obs;
  get isDataLoading => _isDataLoading.value;

  var _isLoading = false.obs;
  get isLoading => _isLoading.value;

  var _isPlayerCardActive = true.obs;
  bool get playerCardActive => _isPlayerCardActive.value;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  var _isFavoriteSong = false.obs;
  bool get isFavoriteSong => _isFavoriteSong.value;

  removeException() {
    _exception(AppException());
  }

  var loggedInUser = User().obs;
  User get loggedInUserResult => loggedInUser.value;

  HomeViewmodel? homeResult;
  List<String> get recentActivityImages =>
      homeResult!.recentActivity!.map((e) => e.image ?? "").toList();
  List<Playlist>? get playlistCollection {
    return [...homeResult?.madeForYou ?? [], ...homeResult?.topCharts ?? []];
  }

  List<Album>? get albumsCollection {
    if (homeResult?.recommendedAlbum?.isNotEmpty == true)
      return homeResult?.recommendedAlbum;
    else
      return homeResult?.newAlbum;
  }

  HomeViewmodel? localAudioFiles;

  var _browseResult = BrowseViewmodel().obs;
  BrowseViewmodel get browseResult => _browseResult.value;

  BrowseViewmodel? browseByTagResult;

  List<BrowseCommand>? browseCommands;

  SearchViewmodel? searhResult;

  // to show interstitial ad after 5 click
  var playerCardClickCount = 0;

  // var _libraryResult = Library().obs;
  Library? libraryResult;

  @override
  onInit() async {
    super.onInit();
    await checkUserLoginStatus();
    getHomeData();
    var tokenResult = await FirebaseMessaging.instance.getToken();
    print("tokenresult $tokenResult");
    // check user loggedin status after the app started
    ever(loggedInUser, (user) {
      print("token ever triggered ${user.username}");
      if (user.username != null) {
        //refetch the data since user logged in
        getHomeData();
        // getAllUserLibrary();
      }
    });
  }

  @override
  onReady() async {
    var pref = SharedPreferenceRepository();
    var showOnboarding =
        await pref.get<bool>(Constants.SHOW_ONBOARDING) ?? false;
    if (!showOnboarding) {
      UIHelper.moveToScreen(OnboardingScreen.routName);
      print("called after navigation");
      pref.create(Constants.SHOW_ONBOARDING, true);
    }
  }

  checkUserLoginStatus() async {
    var userUsecase = UserUsecase(accountService: FirebaseAuthService());
    var result = await userUsecase.getUserInfoFromPref();
    print(" userinfo ${result?.username}");
    if (result != null) loggedInUser(result);
  }

  startPlayingAudioFile(List<Song> songs,
      {int index = 0, AudioSrcType? src, String? id}) async {
    selectedAlbumorPlaylistId = id;
    await player.load(
      songs,
      index: index,
      src: src ?? AudioSrcType.NETWORK,
    );
    await player.play();
    updateSongStreamCount();
  }

  getHomeData() async {
    try {
      _exception(AppException());
      _isDataLoading(true);
      var usecase = HomeUsecase(repo: ApiRepository<HomeViewmodel>());
      var result = await usecase.getHomeData();
      homeResult = result;
    } catch (ex) {
      print("error ${ex.toString()}");
      var exception = ex as AppException;
      exception.action = () {
        print('home clickc');
        _exception(AppException());
        getHomeData();
      };
      _exception(exception);
    } finally {
      _isDataLoading(false);
    }
  }

  getBrowseResult() async {
    try {
      _isDataLoading(true);
      var usecase = HomeUsecase(repo: ApiRepository<BrowseViewmodel>());
      var result = await usecase.getBrowseResult("GOSPEL");
      print(result?.topSongs?.length);
      _browseResult(result);
    } catch (ex) {
      print("error ${ex.toString()}");
      var exception = ex as AppException;
      exception.action = () {
        print('home clickc');
        _exception(AppException());
        getBrowseResult();
      };
      _exception(exception);
      _exception(ex as AppException);
    } finally {
      _isDataLoading(false);
    }
  }

  var isEmptyScree = false.obs;

  browseByTags(List<String> tags) async {
    try {
      browseByTagResult = null;
      isEmptyScree(false);
      _isDataLoading(true);
      var usecase = HomeUsecase(repo: ApiRepository<BrowseViewmodel>());
      var result = await usecase.browseByTags(tags);

      browseByTagResult = result;
      if (browseByTagResult?.playlist?.isEmpty == true) isEmptyScree(true);
    } catch (ex) {
      print("error ${ex.toString()}");
      var exception = ex as AppException;
      exception.action = () {
        _exception(AppException());
        browseByTags(tags);
      };
      _exception(exception);
    } finally {
      _isDataLoading(false);
    }
  }

  getSearchResult(String query) async {
    try {
      _isDataLoading(true);
      var usecase = HomeUsecase(repo: ApiRepository<SearchViewmodel>());
      var result = await usecase.getSearchResult(query);
      searhResult = result;
      _isDataLoading(false);
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

  Future<List<Song>?> getPlaylistSongs(List<String> songIds) async {
    try {
      print("song result");
      var usecase = SongUsecase(repo: ApiRepository<Playlist>());
      var songResult = await usecase.getSongsByid(songIds);
      print("song result $songResult");
      // playlistResult!.songs = playlistSongs;
      _isDataLoading(false);
      return songResult;
    } catch (ex) {
      UIHelper.showSnackBar("Unable to get playlist songs",
          type: SnackbarType.ERROR_SNACKBAR);
      return null;
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
      // _exception(ex as AppException);
    }
  }

  Future<String?> getUserId() async {
    var userUsecase =
        UserUsecase(sharedPrefRepo: const SharedPreferenceRepository<String>());
    var userIdResult = await userUsecase.getUserIdFromPref();
    return userIdResult;
  }

  likeSong(List<String> songIds) async {
    var snackController = UIHelper.showLoadingSnackbar();
    try {
      _isLoading(true);
      var albumUsecase = SongUsecase(repo: ApiRepository<Song>());
      var result = await albumUsecase.likeSong(songIds);
      print("like result $result");
      _isFavoriteSong(true);
    } catch (ex) {
      print("error ${ex.toString()}");
      // _exception(ex as AppException);
      UIHelper.handleException(ex as AppException);
    } finally {
      _isLoading(false);
      snackController.close();
    }
  }

  unlikeSong(List<String> songIds) async {
    var snackController = UIHelper.showLoadingSnackbar();
    try {
      _isLoading(true);
      var albumUsecase = SongUsecase(repo: ApiRepository<Song>());
      var result = await albumUsecase.unlikeSong(songIds);
      _isLoading(false);
      _isFavoriteSong(true);
    } catch (ex) {
      print("error ${ex.toString()}");
      _isLoading(false);
      // _exception(ex as AppException);
      UIHelper.handleException(ex as AppException);
    } finally {
      _isLoading(false);
      snackController.close();
    }
  }

  Future<bool> isSongLiked(String songIds) async {
    try {
      var songUsecase = SongUsecase(repo: ApiRepository<Song>());
      var result = await songUsecase.isSongFavorite(songIds);

      return result;
    } catch (ex) {
      print("error ${ex.toString()}");
      return false;
    }
  }

  Future<bool> isSongDownloaded(String songId) async {
    try {
      var downloadUsecase = DownloadUsecase(repositroy: DownloadRepository());
      var result = await downloadUsecase.isSongDownloaded(songId);

      return result;
    } catch (ex) {
      print("error ${ex.toString()}");
      return false;
    }
  }

  Future<bool> donwloadSingleSongs(List<Song> songs) async {
    var snackController =
        UIHelper.showLoadingSnackbar(text: "Downloading", seconds: 3);
    try {
      var downloadUsecase = DownloadUsecase(repositroy: DownloadRepository());
      var result = await downloadUsecase.startDownload(
        songs,
        "",
        DownloadType.SINGLE,
        Constants.DOWNLOAD_ID_FOR_SINGLE_SONGS,
        Constants.DONWLOAD_NAME_FORM_SINGLE_SONGS,
      );
      return result;
    } catch (ex) {
      print("error ${ex.toString()}");
      _exception(ex as AppException);
      return false;
    }
  }

  removeDownloadedSongs(List<Song> songs) async {
    var snackController =
        UIHelper.showLoadingSnackbar(text: "Deleting download", seconds: 3);
    try {
      var downloadUsecase = DownloadUsecase(repositroy: DownloadRepository());
      await Future.forEach(songs, (song) async {
        var downloadResult = await downloadUsecase.getDownload(song.id!);
        if (downloadResult != null) {
          var removeResult =
              await downloadUsecase.removeDownloads([downloadResult]);
        }
      });
    } catch (ex) {
      print("error ${ex.toString()}");
      _exception(ex as AppException);
    }
  }

  Future<List<Song>> getSongIdFromChart(String playlistId) async {
    try {
      var songUsecase = SongUsecase(repo: ApiRepository<Song>());
      var result = await songUsecase.getSongIdFromChart(playlistId);
      return result;
    } catch (ex) {
      print("error ${ex.toString()}");
      return [];
    }
  }

  updateSongStreamCount() async {
    try {
      Timer? timer;

      player.queueStateStream.listen((queueState) {
        print("song New song selected");
        if (queueState?.current != null) {
          timer?.cancel();
          timer = Timer(const Duration(seconds: 30), () async {
            var songUsecase = SongUsecase(repo: ApiRepository<Song>());
            var result =
                await songUsecase.updateStreamCount(queueState!.current!.id);
            print("song stream update result $result");
          });
        }
      });
    } catch (ex) {
      print("stream update error ${ex.toString()}");
    }
  }

  showPlayerCard(bool p) {
    _isPlayerCardActive(p);
  }

  changeTheme(bool isDarkTheme) async {
    var result = await UIHelper.changeAppTheme(isDarkTheme: isDarkTheme);
  }

  addtoQueue(Song song, {int? index, AudioSrcType src = AudioSrcType.NETWORK}) {
    var controller = UIHelper.showLoadingSnackbar(text: "Adding to queue");
    player.addToQueue(song, src: src, index: index);
    controller.close();
  }

  removeFromQueue(int index) {
    var controller = UIHelper.showLoadingSnackbar(text: "Removing from queue");
    player.removeFromQueue(index);
    controller.close();
  }

  logout({bool navigateToAccount = true}) async {
    var sharedPrefRepo = SharedPreferenceRepository();
    sharedPrefRepo.delete(Constants.TOKEN);
    await sharedPrefRepo.delete(Constants.USERNAME);
    await sharedPrefRepo.delete(Constants.USER_ID);
    // await sharedPrefRepo.delete(Constants.TOKEN);
    loggedInUser(User());
    if (navigateToAccount)
      UIHelper.moveToScreen(AccountOnboardingScreen.routName);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }
}
