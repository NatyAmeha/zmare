import 'package:zema/modals/library.dart';
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
    var result = await sharedPrefRepo!.get<String>(Constants.USER_ID);
    return result;
  }

  Future<String?> getSavedToken() async {
    var result = await sharedPrefRepo!.get<String>(Constants.TOKEN);
    return result;
  }

  Future<R?> getUserLibraryInfo<R>(String path, {LibraryFilter? filter}) async {
    var result = await repo!.get<R>(path, queryParameters: {"filter": filter});
    return result;
  }

  Future<List<R>?> getUserLibrary<R>(String path, String filter) async {
    var result =
        await repo!.getAll<R>(path, queryParameters: {"filter": filter});
    return result;
  }
}
