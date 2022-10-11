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
        var submittedCode = await UIHelper.moveToScreen(
            VerificationScreen.routeName,
            waitForRespnse: true);

        // compare the above code and check verification using firebase auth
        var verificationResult = await userUsecase.verifySmsCode(
            verificationidResult, submittedCode);

        if (verificationResult) {
          //move to artist selection list
          if (isPreviouslyLoggedIn) {
            await signupWithPhone(true, []);
            UIHelper.moveToScreen(MainScreen.routName);
          } else {
            UIHelper.moveToScreen(ArtistSelectionListScreen.routeName);
          }
        } else {
          UIHelper.showSnackBar("Unable to verify phone number",
              type: SnackbarType.ERROR_SNACKBAR);
        }
      } else {
        // phone is auto verified
        // move to artist selection list
        UIHelper.moveToScreen(ArtistSelectionListScreen.routeName);
      }
    } catch (ex) {
      print(ex.toString());
      UIHelper.showSnackBar("Unable to verify phone number",
          type: SnackbarType.ERROR_SNACKBAR);
      // _exception(ex as AppException);
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
      appController.loggedInUser(userResult);
      if (!isPreviouslyLOggedin && selectedArtistId.isNotEmpty) {
        var artistUsecase = ArtistUsecase(repo: ApiRepository());
        var artistFollowResult =
            await artistUsecase.followArtists(selectedArtistId);
      }

      UIHelper.moveToScreen(MainScreen.routName);
    } catch (ex) {
      print(ex.toString());
      _exception(ex as AppException);
    } finally {
      _isDataLoading(false);
    }
  }
}
