import 'package:zema/modals/user.dart';
import 'package:zema/repo/repository.dart';
import 'package:zema/repo/shared_pref_repo.dart';
import 'package:zema/screens/verification_screen.dart';
import 'package:zema/service/account_service.dart';
import 'package:zema/utils/constants.dart';

class UserUsecase {
  IRepositroy? repo;
  ISharedPrefRepository? sharedPrefRepo;
  IAccountService? accountService;

  UserUsecase({
    this.repo,
    this.sharedPrefRepo = const SharedPreferenceRepository(),
    this.accountService,
  });

  Future<User> registerOrAuthenticatewithPhone(User userInfo) async {
    var verifyResult = await accountService!.verifyCode("12345");
    print("verifiatin result $verifyResult");
    var tokenResult =
        await repo!.create<String, User>("/auth/registerwithphone", userInfo);
    var userResult = await accountService!.decodeToken(tokenResult);
    print("${userResult.username} , ${userResult.phoneNumber}");
    var preferenceSaveResult =
        await sharedPrefRepo!.saveUserInfo(userResult, tokenResult);
    print("${userResult.username}  ${preferenceSaveResult}");
    return userResult;
  }

  Future<bool> sendVerificationCode(String phoneNumber) async {
    var result = await accountService!.sendVerificationCode();
    return result;
  }

  Future<String?> getUserIdFromPref() async {
    var result = await sharedPrefRepo!.get(Constants.USER_ID) as String?;
    return result;
  }

  Future<String?> getSavedToken() async {
    var result = await sharedPrefRepo!.get(Constants.TOKEN) as String?;
    return result;
  }
}
