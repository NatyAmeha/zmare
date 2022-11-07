import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/modals/exception.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/repo/api_repository.dart';
import 'package:zmare/screens/browse_screen.dart';
import 'package:zmare/usecase/user_usecase.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/song_widget.dart/song_list.dart';

class SongController extends GetxController {
  var appController = Get.find<AppController>();
  var _isDataLoading = true.obs;
  get isDataLoading => _isDataLoading.value;

  var _isLoading = false.obs;
  get isLoading => _isLoading.value;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  var selectedSongsForPlaylist = <Song>[].obs;
  List<String> get selecteSongIds =>
      selectedSongsForPlaylist.value.map((e) => e.id!).toList();
  List<String> get selecteSongImages =>
      selectedSongsForPlaylist.value.map((e) => e.thumbnailPath!).toList();

  List<Song>? songList;

  addOrRemoveSongId(Song songINfo) {
    if (selecteSongIds.contains(songINfo.id) == true) {
      selectedSongsForPlaylist.remove(songINfo);
    } else {
      selectedSongsForPlaylist.add(songINfo);
    }
    selectedSongsForPlaylist.refresh();
  }

  getUserFavoriteSongs() async {
    try {
      _isDataLoading(true);
      var userUsecase = UserUsecase(repo: ApiRepository());
      var result = await userUsecase.getUserLibrary<Song>("/library", "song");
      if (result.isEmpty) {
        _exception(
          AppException(
            message: "Your favorite sogns will collected here",
            title: "No favorite songs found",
            actionText: "Browse songs",
            action: () {
              UIHelper.moveBack();
              UIHelper.moveToScreen(BrowseScreen.routeName,
                  navigatorId: UIHelper.bottomNavigatorKeyId);
            },
          ),
        );
      }
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
