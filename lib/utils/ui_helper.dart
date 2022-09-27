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

  // Widget displayContent(Widget conent,
  //     {required AppException exception, bool isLoading = false}) {
  //   if (isLoading) {
  //     return LoadingProgressbar(loadingState: isLoading);
  //   } else if (exception.message != null) {
  //     ErrorPage(exception: exception);
  //   }
  //   else if()
  // }
}
