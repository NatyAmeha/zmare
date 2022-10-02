import 'dart:math';

import 'package:darq/darq.dart';
import 'package:get/get.dart';
import 'package:zema/controller/app_controller.dart';
import 'package:zema/modals/exception.dart';
import 'package:zema/modals/playlist.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/repo/api_repository.dart';
import 'package:zema/service/player/player_service.dart';
import 'package:zema/usecase/playlist_usecase.dart';
import 'package:zema/utils/constants.dart';

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

  playPlaylist(List<Song> songs) async {
    var playlistUsecase = PlaylistUsecase(player: appController.player);
    await playlistUsecase.playPlaylist(songs, PlaybackSrc.NETWORK);
  }
}
