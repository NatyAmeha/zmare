import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:zema/modals/exception.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/repo/api_repository.dart';
import 'package:zema/usecase/user_usecase.dart';
import 'package:zema/widget/song_widget.dart/song_list.dart';

class SongController extends GetxController {
  var _isDataLoading = true.obs;
  get isDataLoading => _isDataLoading.value;

  var _isLoading = false.obs;
  get isLoading => _isLoading.value;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  List<Song>? songList;

  getUserFavoriteSongs() async {
    try {
      _isDataLoading(true);
      var userUsecase = UserUsecase(repo: ApiRepository());
      var result = await userUsecase.getUserLibrary<Song>("/library", "song");
      print(result);
      songList = result;
    } catch (ex) {
      print("error ${ex.toString()}");
      _exception(ex as AppException);
    } finally {
      _isDataLoading(false);
    }
  }
}
