import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zema/modals/exception.dart';
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
    if (isLoading) {
      return LoadingProgressbar(loadingState: isLoading);
    } else if (exception.message != null) {
      return ErrorPage(exception: exception);
    } else if (showWhen) {
      return content;
    } else {
      return Container();
    }
  }

  static moveToPlaylistScreen(String playlistId) {
    Get.toNamed("/playlist/${playlistId}");
  }
}
