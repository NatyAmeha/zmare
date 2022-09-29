import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zema/modals/exception.dart';
import 'package:zema/repo/shared_pref_repo.dart';
import 'package:zema/screens/login_screen.dart';
import 'package:zema/screens/registration_screen.dart';
import 'package:zema/usecase/user_usecase.dart';
import 'package:zema/widget/error_page.dart';
import 'package:zema/widget/loading_progressbar.dart';

class UIHelper {
  static Future<T> showBottomSheet<T>(Widget widget,
      {bool dismissable = true, bool scrollControlled = false}) async {
    return await Get.bottomSheet(
      widget,
      isScrollControlled: scrollControlled,
      backgroundColor: Colors.white,
      isDismissible: dismissable,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    );
  }

  static Widget displayContent(
      {required Widget content,
      required bool showWhen,
      required AppException exception,
      bool isLoading = false}) {
    Widget widget;
    if (isLoading) {
      widget = LoadingProgressbar(loadingState: isLoading);
    }
    if (exception.message != null) {
      widget = ErrorPage(exception: exception);
    } else if (showWhen) {
      widget = content;
    } else {
      widget = Container();
    }
    return widget;
  }

  static moveToPlaylistScreen(String playlistId) {
    Get.toNamed("/playlist/${playlistId}");
  }

  static Future<T?> moveToScreen<T>(String routeName,
      {bool waitForRespnse = false}) async {
    if (waitForRespnse) {
      var result = await Get.toNamed<T>(routeName);
      return result;
    } else {
      Get.toNamed(routeName);
      print("NO response");
      return null;
    }
  }

  static moveToLoginOrRegister() async {
    var userUsecase =
        UserUsecase(sharedPrefRepo: const SharedPreferenceRepository<String>());
    var tokenResult = await userUsecase.getSavedToken();
    if (tokenResult != null) {
      moveToScreen(LoginScreen.routeName);
    } else {
      moveToScreen(RegistrationScreen.routeName);
    }
  }

  static moveBack({dynamic? result}) {
    Get.back(result: result);
  }
}
