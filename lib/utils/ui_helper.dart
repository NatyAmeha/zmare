import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:zmare/modals/exception.dart';
import 'package:zmare/repo/shared_pref_repo.dart';
import 'package:zmare/screens/account_onboarding_screen.dart';
import 'package:zmare/screens/artist_screen.dart';
import 'package:zmare/screens/login_screen.dart';
import 'package:zmare/screens/main_screen.dart';
import 'package:zmare/screens/registration_screen.dart';
import 'package:zmare/usecase/user_usecase.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/theme.dart';
import 'package:zmare/widget/custom_button.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/error_page.dart';
import 'package:zmare/widget/loading_progressbar.dart';
import 'package:zmare/widget/loading_widget/home_shimmer.dart';

import '../modals/playlist.dart';

class UIHelper {
  static const mainNavigatorKeyId = 10;
  static const bottomNavigatorKeyId = 11;

  static Future<T> showBottomSheet<T>(Widget widget,
      {bool dismissable = true, bool scrollControlled = false}) async {
    return await Get.bottomSheet(
      widget,
      isScrollControlled: scrollControlled,
      backgroundColor: Theme.of(Get.context!).dialogBackgroundColor,
      isDismissible: dismissable,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    );
  }

  static SnackbarController showSnackBar(
    String message, {
    String title = "Successful",
    SnackbarType? type = SnackbarType.ERROR_SNACKBAR,
    IconData? leading,
    Duration duration = const Duration(seconds: 20),
    String? actionText,
    Function? onclick,
  }) {
    var controller = Get.snackbar(title, "",
        titleText: CustomText(
          (type == SnackbarType.SUCCESS_SNACKBAR) ? "Successfull" : "Error",
          textStyle: Theme.of(Get.context!).textTheme.titleMedium,
          fontWeight: FontWeight.bold,
        ),
        messageText: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            CustomText(
              message,
              textStyle: Theme.of(Get.context!).textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            if (actionText != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(actionText,
                      wrapContent: true,
                      buttonType: ButtonType.ROUND_ELEVATED_BUTTON,
                      onPressed: () {
                    moveBack();
                    onclick?.call();
                  }),
                ],
              )
          ],
        ),
        snackPosition: SnackPosition.BOTTOM,
        animationDuration: const Duration(milliseconds: 500),
        duration: duration,

        // icon: Icon(
        //   (type == SnackbarType.SUCCESS_SNACKBAR ? Icons.check : Icons.error),
        // ),
        backgroundColor: type == SnackbarType.SUCCESS_SNACKBAR
            ? Colors.green
            : Theme.of(Get.context!).backgroundColor,
        margin: const EdgeInsets.all(8));
    return controller;
  }

  static showToast(BuildContext context, String message,
      {Toast length = Toast.LENGTH_SHORT}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: length,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Theme.of(context).backgroundColor,
        // textColor: Colors.white,
        fontSize: 16.0);
  }

  static SnackbarController showLoadingSnackbar(
      {String text = "Loading", int? seconds}) {
    var controller = Get.rawSnackbar(
      titleText: SizedBox(),
      messageText: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(),
            ),
            const SizedBox(width: 16),
            CustomText(text)
          ],
        ),
      ),
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: Theme.of(Get.context!).backgroundColor,
      snackPosition: SnackPosition.BOTTOM,
      animationDuration: const Duration(milliseconds: 500),
      duration: Duration(seconds: seconds ?? 60),
    );

    return controller;
  }

  static Widget displayContent({
    required Widget content,
    required bool showWhen,
    required AppException exception,
    bool isDataLoading = true,
    Widget? loadingWidget,
  }) {
    if (!showWhen && exception.message != null) {
      return ErrorPage(exception: exception);
    } else {
      return Stack(
        children: [
          if (showWhen) content,
          if (isDataLoading)
            showWhen
                ? LoadingProgressbar(loadingState: isDataLoading)
                : loadingWidget ??
                    LoadingProgressbar(loadingState: isDataLoading)
        ],
      );
    }

    // else {
    //   return content;
    // }
  }

  static Future<PaletteGenerator?> generateColorFromImage(String? image,
      {String imageSource = "network"}) async {
    if (image == null) return null;
    var generator = await PaletteGenerator.fromImageProvider(
        NetworkImage(image),
        size: const Size(200, 100));
    return generator;
  }

  static moveToPlaylistScreen(String? playlistId,
      {Playlist? plyalistInfo, int? navigatorId}) {
    if (playlistId != null) {
      Get.toNamed("/playlist/${playlistId}", id: navigatorId);
    } else if (plyalistInfo != null) {
      Get.toNamed("/playlist/id", id: navigatorId, arguments: plyalistInfo);
    }
  }

  static Future<T?> moveToScreen<T>(
    String routeName, {
    dynamic arguments,
    bool waitForRespnse = false,
    bool pop = false,
    int? navigatorId,
  }) async {
    if (waitForRespnse) {
      T? result;
      if (pop) {
        result = await Get.offAllNamed<T>(routeName,
            arguments: arguments, id: navigatorId);
      } else {
        result = await Get.toNamed<T>(routeName,
            id: navigatorId, arguments: arguments);
      }

      return result;
    } else {
      Get.toNamed(routeName, arguments: arguments, id: navigatorId);
      return null;
    }
  }

  static Future<void> removeBackstackAndmoveToScreen(
    String routeName, {
    dynamic arguments,
    int? navigatorId,
  }) async {
    var result = await Get.offAllNamed(
      routeName,
      id: navigatorId,
      arguments: arguments,
    );
  }

  static moveToLoginOrRegister() async {
    var repo = SharedPreferenceRepository();
    var isPreviouslyRegistered = await repo.get<bool>(Constants.REGISTERED);
    if (isPreviouslyRegistered == true) {
      moveToScreen(LoginScreen.routeName);
    } else {
      moveToScreen(RegistrationScreen.routeName);
    }
  }

  static moveToArtistScreen(
    List<String> artistIds,
    List<String> artistNames, {
    int? navigatorId,
  }) {
    if (artistIds.length > 1) {
      UIHelper.showBottomSheet(
        UIHelper.showArtistSelectionDialog(
          artistNames,
          (index) {
            UIHelper.moveToScreen("/artist/${artistIds.elementAt(index)}",
                navigatorId: navigatorId);
          },
        ),
      );
    } else {
      UIHelper.moveToScreen("/artist/${artistIds.elementAt(0)}",
          navigatorId: navigatorId);
    }
  }

  static moveBack({dynamic? result}) {
    Get.back(result: result);
  }

  static Future<void> showInfoDialog(
      String title, String message, Function onActionClicked) async {
    var rationaleDialog = await Get.defaultDialog(
      title: title,
      content: Flexible(
        child: Text(message),
      ),
      confirm: TextButton(
        child: const Text('OK'),
        onPressed: () async {
          Get.back();
          onActionClicked();
        },
      ),
    );
  }

  static Future<bool?> getAppTheme() async {
    var prefREpo = const SharedPreferenceRepository();
    var isDarkTheme = await prefREpo.get<bool>(Constants.IS_DARK_THEME);
    if (isDarkTheme == null) {
      return null;
    }
    return isDarkTheme;
  }

  static Future<bool> changeLanguage(AppLanguage language) async {
    Locale _local;
    if (language == AppLanguage.AMHARIC) {
      _local = Locale('am', '');
    } else {
      _local = Locale("en", "");
    }
    var result = await Get.updateLocale(_local);
    return true;
  }

  static Future<void> changeAppTheme({bool? isDarkTheme}) async {
    var prefREpo = const SharedPreferenceRepository();
    if (isDarkTheme == null) {
      var resut = await prefREpo.delete(Constants.IS_DARK_THEME);
      Get.changeThemeMode(ThemeMode.system);
    } else {
      var resut = await prefREpo.create<bool, bool>(
          Constants.IS_DARK_THEME, isDarkTheme);

      isDarkTheme
          ? Get.changeThemeMode(ThemeMode.dark)
          : Get.changeThemeMode(ThemeMode.light);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarColor:
              Theme.of(Get.context!).scaffoldBackgroundColor));
    }
  }

  static handleException(AppException exception, {String? message}) {
    if (exception.type == AppException.UNAUTORIZED_EXCEPTION) {
      UIHelper.showSnackBar("Sign in to continue", actionText: "Sign in",
          onclick: () {
        UIHelper.moveToScreen(AccountOnboardingScreen.routName);
      });
    } else if (exception.type == AppException.BAD_REQUEST_EXCEPTION) {
      var controller = UIHelper.showSnackBar(message ?? "Error occured",
          actionText: "Close");
    }
  }

  static Widget showArtistSelectionDialog(
      List<String> artistNames, Function(int) onSelected) {
    return Column(
      children: [
        CustomText("Select Artists"),
        Expanded(
          child: ListView(
            children: List.generate(
              artistNames.length,
              (index) => ListTile(
                onTap: onSelected(index),
                title: CustomText(artistNames[index]),
              ),
            ),
          ),
        )
      ],
    );
  }

  static List<int> selectAdIndex(int songListLength) {
    if (songListLength <= 5)
      return [3];
    else if (songListLength <= 10)
      return [5];
    else if (songListLength <= 20)
      return [3, 10];
    else if (songListLength <= 30)
      return [3, 13, 19];
    else if (songListLength <= 40)
      return [5, 15, 25, songListLength - 1];
    else
      return [5, 15, 25, 35, 40];
  }
}
