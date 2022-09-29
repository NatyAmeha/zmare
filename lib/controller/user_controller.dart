import 'package:get/get.dart';
import 'package:zema/controller/app_controller.dart';
import 'package:zema/modals/exception.dart';
import 'package:zema/modals/user.dart';
import 'package:zema/repo/api_repository.dart';
import 'package:zema/screens/main_screen.dart';
import 'package:zema/screens/verification_screen.dart';
import 'package:zema/service/account_service.dart';
import 'package:zema/usecase/user_usecase.dart';
import 'package:zema/utils/ui_helper.dart';

class UserController extends GetxController {
  var appController = Get.find<AppController>();

  var _isDataLoading = true.obs;
  get isDataLoading => _isDataLoading.value;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  sendCode(User userInfo) async {
    try {
      _isDataLoading(true);
      var userUsecase = UserUsecase(
          repo: ApiRepository<User>(), accountService: FirebaseAuthService());
      var userResult = await userUsecase.sendVerificationCode("0915844494");
      var smsResult = await UIHelper.moveToScreen(VerificationScreen.routeName,
          waitForRespnse: true);
      print(smsResult);
      signupWithPhone(userInfo);
    } catch (ex) {
      print(ex.toString());
      _exception(ex as AppException);
    }
  }

  signupWithPhone(User userInfo) async {
    try {
      _isDataLoading(true);
      var userUsecase = UserUsecase(
          repo: ApiRepository<User>(), accountService: FirebaseAuthService());
      var userResult =
          await userUsecase.registerOrAuthenticatewithPhone(userInfo);
      _isDataLoading(false);
      appController.loggedInUser(userResult);
      UIHelper.moveToScreen(MainScreen.routName);
    } catch (ex) {
      print(ex.toString());
      _exception(ex as AppException);
    }
  }
}
