import 'package:zmare/modals/library.dart';
import 'package:zmare/modals/user.dart';
import 'package:zmare/repo/repository.dart';
import 'package:zmare/repo/shared_pref_repo.dart';
import 'package:zmare/service/account_service.dart';
import 'package:zmare/utils/constants.dart';

class UserUsecase {
  IRepositroy? repo;
  ISharedPrefRepository? sharedPrefRepo;
  IAccountService? accountService;

  UserUsecase({
    this.repo,
    this.sharedPrefRepo = const SharedPreferenceRepository(),
    this.accountService,
  });

  Future<String?> sendVerificaationCode(String phoneNumber) async {
    try {
      var verificationId =
          await accountService!.sendVerificationCode(phoneNumber);
      return verificationId;
    } catch (ex) {
      rethrow;
    }
  }

  Future<bool> verifySmsCode(String verificationId, String code) async {
    var result = await accountService!.verifyCode(verificationId, code);
    return result;
  }

  Future<User> registerOrAuthenticatewithPhone(User userInfo) async {
    var tokenResult =
        await repo!.create<String, User>("/auth/registerwithphone", userInfo);
    var userResult = await accountService!.decodeToken(tokenResult);
    print("${userResult.username} , ${userResult.phoneNumber}");
    var preferenceSaveResult =
        await sharedPrefRepo!.saveUserInfo(userResult, tokenResult);
    print("${userResult.username}  ${preferenceSaveResult}");
    return userResult;
  }

  Future<String?> sendVerificationCode(String phoneNumber) async {
    print("phone number $phoneNumber");
    var result = await accountService!.sendVerificationCode(phoneNumber);
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

  Future<User?> getUserInfoFromPref() async {
    var tokenResult = await getSavedToken();
    print("res $tokenResult");
    if (tokenResult != null) {
      var result = await accountService!.decodeToken(tokenResult);
      return result;
    } else {
      return null;
    }
  }

  Future<R?> getUserLibraryInfo<R>(String path, {LibraryFilter? filter}) async {
    var result = await repo!.get<R>(path, queryParameters: {"filter": filter});
    return result;
  }

  Future<List<R>> getUserLibrary<R>(String path, String filter) async {
    var result =
        await repo!.getAll<R>(path, queryParameters: {"filter": filter});
    return result;
  }
}
