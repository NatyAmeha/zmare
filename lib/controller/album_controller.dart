import 'package:get/get.dart';
import 'package:zema/controller/app_controller.dart';
import 'package:zema/modals/album.dart';
import 'package:zema/modals/exception.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/repo/api_repository.dart';
import 'package:zema/usecase/album_usecase.dart';

class AlbumController extends GetxController {
  var appController = Get.find<AppController>();

  var _isDataLoading = true.obs;
  get isDataLoading => _isDataLoading.value;

  var _isLoading = false.obs;
  get isLoading => _isLoading.value;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  var _albumResult = Album().obs;
  Album get albumResult => _albumResult.value;

  var _isFavoriteAlbum = false.obs;
  bool get isFavoriteAlbum => _isFavoriteAlbum.value;

  @override
  void onInit() {
    var id = Get.parameters["id"];
    print("album id $id");
    super.onInit();
  }

  getAlbum(String albumId) async {
    try {
      _isDataLoading(true);
      var albumUsecase = AlbumUsecase(repo: ApiRepository<Album>());
      var result = await albumUsecase.getAlbum(albumId);
      _isDataLoading(false);
      _albumResult(result);
    } catch (ex) {
      print("error ${ex.toString()}");
      _isDataLoading(false);
      _exception(ex as AppException);
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
