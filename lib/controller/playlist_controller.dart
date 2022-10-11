import 'dart:math';

import 'package:darq/darq.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/modals/exception.dart';
import 'package:zmare/modals/playlist.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/repo/api_repository.dart';
import 'package:zmare/repo/db/download_db_repo.dart';
import 'package:zmare/service/player/player_service.dart';
import 'package:zmare/usecase/download_usecase.dart';
import 'package:zmare/usecase/playlist_usecase.dart';
import 'package:zmare/utils/constants.dart';

class PlaylistController extends GetxController {
  var appController = Get.find<AppController>();

  var _isDataLoading = true.obs;
  get isDataLoading => _isDataLoading.value;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  var _playlistResult = Playlist().obs;
  Playlist get playlistResult => _playlistResult.value;
  List<Song>? get playlistSongs =>
      playlistResult.songs?.map((e) => Song.fromJson(e)).toList();

  List<String>? get playlistImages {
    var songImages = playlistResult.songs
        ?.map((e) => Song.fromJson(e))
        .map((e) => e.thumbnailPath!)
        .toList();
    songImages?.shuffle();
    return songImages;
  }

  getPlaylist(String playlistId) async {
    try {
      _isDataLoading(true);
      var usecase = PlaylistUsecase(repo: ApiRepository<Playlist>());
      var result = await usecase.getPlaylist(playlistId);
      _isDataLoading(false);
      _playlistResult(result);
    } catch (ex) {
      print(ex.toString());
      _exception(ex as AppException);
    }
  }

  downloadPlaylist() async {
    try {
      _isDataLoading(true);
      var downloadUsecase = DownloadUsecase(repositroy: DownloadRepository());
      var result = await downloadUsecase.startDownload(
          playlistResult.songs!.cast<Song>(),
          "",
          DownloadType.PLAYLIST,
          playlistResult.id!,
          playlistResult.name!);
    } catch (ex) {
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
