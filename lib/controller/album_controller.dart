import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:zema/controller/app_controller.dart';
import 'package:zema/modals/album.dart';
import 'package:zema/modals/exception.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/repo/api_repository.dart';
import 'package:zema/repo/db/db_repo.dart';
import 'package:zema/repo/local_audio_repo.dart';
import 'package:zema/usecase/album_usecase.dart';
import 'package:zema/usecase/download_usecase.dart';
import 'package:zema/usecase/home_usecase.dart';
import 'package:zema/usecase/user_usecase.dart';
import 'package:zema/utils/constants.dart';

class AlbumController extends GetxController {
  var appController = Get.find<AppController>();

  var _isDataLoading = true.obs;
  get isDataLoading => _isDataLoading.value;

  var _isLoading = false.obs;
  get isLoading => _isLoading.value;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  Album? albumResult;

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
      _isDataLoading(false);
    } catch (ex) {
      print("error ${ex.toString()}");
      _isDataLoading(false);
      _exception(ex as AppException);
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
    } catch (ex) {
      print("error ${ex.toString()}");
      _exception(ex as AppException);
    } finally {
      _isDataLoading(false);
    }
  }

  likeAlbum(String albumId) async {
    try {
      _isLoading(true);
      var albumUsecase = AlbumUsecase(repo: ApiRepository<Album>());
      var result = await albumUsecase.likeAlbum(albumId);
      _isLoading(false);
      _isFavoriteAlbum(true);
    } catch (ex) {
      print("error ${ex.toString()}");
      _isLoading(false);
      _exception(ex as AppException);
    }
  }

  unlikeAlbum(String albumId) async {
    try {
      _isLoading(true);
      var albumUsecase = AlbumUsecase(repo: ApiRepository<Album>());
      var result = await albumUsecase.unlikeAlbum(albumId);
      _isLoading(false);
      _isFavoriteAlbum(false);
    } catch (ex) {
      print("error ${ex.toString()}");
      _isLoading(false);
      _exception(ex as AppException);
    }
  }

  downloadAlbum(List<Song> albumSongs) async {
    try {
      _isLoading(true);
      var downloadUsecase = DownloadUsecase(repositroy: DBRepo());
      var result = await downloadUsecase.startDownload(albumSongs, "");
      print("Download result ${result}");
    } catch (ex) {
      _exception(ex as AppException);
    } finally {
      _isLoading(false);
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
      _exception(ex as AppException);
    }
  }
}
