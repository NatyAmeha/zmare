import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/modals/exception.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/screens/account_onboarding_screen.dart';
import 'package:zmare/utils/ui_helper.dart';

import '../repo/api_repository.dart';
import '../usecase/song_usecase.dart';

class PlayerController extends GetxController {
  var appController = Get.find<AppController>();
  var queueScrollPosition = false.obs;

  var _isSongLiked = false.obs;
  bool get isSongLiked => _isSongLiked.value;

  var _isSongDownloaded = false.obs;
  bool get isSongDownloaded => _isSongDownloaded.value;

  Rx<Color> _selectedColor = (Colors.blueGrey as Color).obs;
  Color get selectedColor => _selectedColor.value;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }

  trackSongLikeStatus(String songId) async {
    try {
      var result = await appController.isSongLiked(songId);
      _isSongLiked(result);
    } catch (ex) {
      return false;
    }
  }

  likeSong(String songId) async {
    try {
      var albumUsecase = SongUsecase(repo: ApiRepository<Song>());
      var result = await albumUsecase.likeSong([songId]);
      _isSongLiked(result);
    } catch (ex) {
      print(ex.toString());
      var exception = ex as AppException;
      if (exception.type == AppException.UNAUTORIZED_EXCEPTION) {
        UIHelper.showSnackBar("Sign in to continue", actionText: "Sign in",
            onclick: () {
          UIHelper.moveToScreen(AccountOnboardingScreen.routName);
        });
      }
      _isSongLiked(false);
    }
  }

  unLikeSong(String songId) async {
    try {
      var albumUsecase = SongUsecase(repo: ApiRepository<Song>());
      var result = await albumUsecase.unlikeSong([songId]);
      _isSongLiked(false);
    } catch (ex) {
      print(ex.toString());
      _isSongLiked(false);
    }
  }

  trackSongDownloadStatus(String songId) async {
    try {
      var downloadResult = await appController.isSongDownloaded(songId);
      _isSongDownloaded(downloadResult);
    } catch (ex) {
      _isSongDownloaded(false);
    }
  }

  downloadSong(Song? songInfo) async {
    try {
      if (songInfo != null) {
        var result = await appController.donwloadSingleSongs([songInfo]);
        _isSongDownloaded(result);
      }
    } catch (ex) {
      _isSongDownloaded(false);
    }
  }

  removeDownloadedSong(Song? songInfo) async {
    try {
      if (songInfo != null) {
        var result = await appController.removeDownloadedSongs([songInfo]);
        _isSongDownloaded(!result);
      }
    } catch (ex) {
      _isSongDownloaded(true);
    }
  }

  changePlayerbackgroundColor(String? image) async {
    if (image != null) {
      var result = await UIHelper.generateColorFromImage(image);

      _selectedColor(result?.lightVibrantColor?.color ?? Colors.grey);
    }
  }
}
