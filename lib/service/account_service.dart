import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:zmare/modals/exception.dart';
import 'package:zmare/modals/user.dart' as u;
import 'package:zmare/service/jwt_decoder.dart';

abstract class IAccountService {
  Future<String?> sendVerificationCode(String phoneNumber);
  Future<bool> verifyCode(String verificationId, String code);
  Future<u.User> decodeToken(String token);
}

class FirebaseAuthService implements IAccountService {
  IJWTDecoder jwtDecocer;
  FirebaseAuthService({this.jwtDecocer = const JwtDecoder()});
  var firebaseAuthInstance = FirebaseAuth.instance;
  @override
  Future<String?> sendVerificationCode(String phoneNumber) async {
    //converting callback to future based api
    var completer = Completer<String?>();
    try {
      await firebaseAuthInstance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (a) {
            print("verification completed ${a.toString()}");
            completer.complete(null);
          },
          verificationFailed: (ex) {
            if (ex.code == "invalid-phone-number") {
              completer.completeError(AppException(
                  type: AppException.INVALID_PHONE_NUMBER_EXCEPTION,
                  message: ex.message));
            }
          },
          codeSent: (verificationId, resendToken) {
            print("code sent to device  ${verificationId.toString()}");

            completer.complete(verificationId);
          },
          codeAutoRetrievalTimeout: (valverificationId) {});
    } catch (ex) {
      completer.completeError(AppException(
          type: AppException.UNKNOWN_EXCEPTION, message: ex.toString()));
    }
    return completer.future;
  }

  @override
  Future<bool> verifyCode(String verificationId, String code) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: code);
    if (credential.smsCode == code) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<u.User> decodeToken(String token) async {
    var result = jwtDecocer.decodeToken(token);
    var userResult = u.User(
      id: result["_id"],
      username: result["username"],
      phoneNumber: result["phoneNumber"],
      profileImagePath: result["profileImagePath"],
    );
    return userResult;
  }
}
