import 'package:get/get.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/modals/exception.dart';
import 'package:zmare/modals/library.dart';
import 'package:zmare/modals/user.dart';
import 'package:zmare/repo/api_repository.dart';
import 'package:zmare/screens/artist_selection_list.dart';
import 'package:zmare/screens/main_screen.dart';
import 'package:zmare/screens/verification_screen.dart';
import 'package:zmare/service/account_service.dart';
import 'package:zmare/usecase/artist_usecase.dart';
import 'package:zmare/usecase/user_usecase.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';

class UserController extends GetxController {
  var appController = Get.find<AppController>();

  var _isDataLoading = false.obs;
  get isDataLoading => _isDataLoading.value;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  var _libraryResult = Library().obs;
  Library get libraryResult => _libraryResult.value;

  User? userInfo;

  sendCode(bool isPreviouslyLoggedIn) async {
    try {
      _isDataLoading(true);
      var userUsecase = UserUsecase(
          repo: ApiRepository<User>(), accountService: FirebaseAuthService());
      var verificationidResult =
          await userUsecase.sendVerificationCode(userInfo!.phoneNumber!);
      if (verificationidResult != null) {
        // phone is not auto verified
        print("code sent ${verificationidResult}");
        await UIHelper.moveToScreen(VerificationScreen.routeName, arguments: {
          "verificationId": verificationidResult,
          "isLoggedinBefore": isPreviouslyLoggedIn
        });
      } else {
        // phone is auto verified

        if (isPreviouslyLoggedIn) {
          await signupWithPhone(true, []);
          UIHelper.removeBackstackAndmoveToScreen(MainScreen.routName);
        } else {
          UIHelper.moveToScreen(ArtistSelectionListScreen.routeName);
        }
      }
    } catch (ex) {
      print(ex.toString());
      UIHelper.showSnackBar("Unable to send verificatin code",
          type: SnackbarType.ERROR_SNACKBAR);
      // _exception(ex as AppException);
    } finally {
      _isDataLoading(false);
    }
  }

  verifySmsCode(String verificationId, String submittedCode,
      bool isPreviouslyLoggedIn) async {
    try {
      _isDataLoading(true);
      // compare the above code and check verification using firebase auth
      var userUsecase = UserUsecase(
          repo: ApiRepository<User>(), accountService: FirebaseAuthService());
      var verificationResult =
          await userUsecase.verifySmsCode(verificationId, submittedCode);

      if (verificationResult) {
        //move to artist selection list
        if (isPreviouslyLoggedIn) {
          await signupWithPhone(true, []);
          UIHelper.removeBackstackAndmoveToScreen(MainScreen.routName);
        } else {
          UIHelper.moveToScreen(ArtistSelectionListScreen.routeName, pop: true);
        }
      } else {
        UIHelper.showSnackBar("Input is not correct",
            type: SnackbarType.ERROR_SNACKBAR);
      }
    } catch (ex) {
      UIHelper.showSnackBar("Sorry unable to verify phone number",
          type: SnackbarType.ERROR_SNACKBAR);
    } finally {
      _isDataLoading(false);
    }
  }

  signupWithPhone(
      bool isPreviouslyLOggedin, List<String> selectedArtistId) async {
    _exception(AppException());
    print("artist ids ${selectedArtistId}");
    try {
      _isDataLoading(true);
      var userUsecase = UserUsecase(
          repo: ApiRepository<User>(), accountService: FirebaseAuthService());
      var userResult =
          await userUsecase.registerOrAuthenticatewithPhone(userInfo!);

      var tokenSaveResult = await userUsecase.registerFCMToken();
      print("token save result $tokenSaveResult");
      appController.loggedInUser(userResult);
      if (!isPreviouslyLOggedin && selectedArtistId.isNotEmpty) {
        var artistUsecase = ArtistUsecase(repo: ApiRepository());
        var artistFollowResult =
            await artistUsecase.followArtists(selectedArtistId);
      }

      UIHelper.removeBackstackAndmoveToScreen(MainScreen.routName);
    } catch (ex) {
      print(ex.toString());
      _exception(ex as AppException);
    } finally {
      _isDataLoading(false);
    }
  }

  continueWithFacebook() async {
    try {
      _isDataLoading(true);
      var userUsecase = UserUsecase(
          repo: ApiRepository<User>(), accountService: FirebaseAuthService());
      var authResult = await userUsecase.signInWithFacebook();

      var tokenSaveResult = await userUsecase.registerFCMToken();
      print("token save result $tokenSaveResult");
      appController.loggedInUser(authResult["user"] as User);
      var isNewUser = authResult["isNew"] as bool;
      if (isNewUser) {
        // UIHelper.moveToScreen(ArtistSelectionListScreen.routeName);

      }

      UIHelper.removeBackstackAndmoveToScreen(MainScreen.routName);
    } catch (ex) {
      print(ex.toString());
      _exception(ex as AppException);
    } finally {
      _isDataLoading(false);
    }
  }
}
