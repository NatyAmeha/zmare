import 'package:zema/modals/user.dart';
import 'package:zema/service/jwt_decoder.dart';

abstract class IAccountService {
  Future<bool> sendVerificationCode();
  Future<bool> verifyCode(String code);
  Future<User> decodeToken(String token);
}

class FirebaseAuthService implements IAccountService {
  IJWTDecoder jwtDecocer;
  FirebaseAuthService({this.jwtDecocer = const JwtDecoder()});
  @override
  Future<bool> sendVerificationCode() {
    return Future.value(true);
  }

  @override
  Future<bool> verifyCode(String code) {
    return Future.value(true);
  }

  @override
  Future<User> decodeToken(String token) async {
    var result = await jwtDecocer.decodeToken(token);
    var userResult = User(
      username: result["username"],
      phoneNumber: result["phoneNumber"],
      profileImagePath: result["profileImagePath"],
    );
    return userResult;
  }
}
