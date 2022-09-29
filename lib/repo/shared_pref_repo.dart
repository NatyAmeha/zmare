import 'package:shared_preferences/shared_preferences.dart';
import 'package:zema/modals/exception.dart';
import 'package:zema/modals/user.dart';
import 'package:zema/repo/repository.dart';
import 'package:zema/utils/constants.dart';

abstract class ISharedPrefRepository<T> extends IRepositroy<T> {
  Future<bool> saveUserInfo(User userInfo, String token);
}

class SharedPreferenceRepository<T> implements ISharedPrefRepository<T> {
  const SharedPreferenceRepository();
  @override
  Future<R> create<R, S>(String path, S body,
      {Map<String, dynamic>? queryParameters}) async {
    var sharedPref = await SharedPreferences.getInstance();
    print("pref type ${S.runtimeType}");
    try {
      switch (S) {
        case String:
          var result = await sharedPref.setString(path, body as String);
          print(result);
          return result as R;

        case int:
          var result = await sharedPref.setInt(path, body as int);
          return result as R;

        case bool:
          var result = await sharedPref.setBool(path, body as bool);
          return result as R;
        case List<String>:
          var result =
              await sharedPref.setStringList(path, body as List<String>);
          return result as R;
        default:
          return Future.error(AppException(
              message: "Trying to save unsupported type to preference"));
      }
    } catch (e) {
      print(e.toString());
      return Future.error(AppException(
          type: AppException.STORAGE_EXCEPTION, message: e.toString()));
    }
  }

  @override
  Future<T?> get(String path, {Map<String, dynamic>? queryParameters}) async {
    var sharedPref = await SharedPreferences.getInstance();
    try {
      switch (T) {
        case String:
          if (sharedPref.containsKey(path)) {
            var result = sharedPref.getString(path);

            return result as T?;
          } else {
            return null;
          }

        case int:
          if (sharedPref.containsKey(path)) {
            var result = sharedPref.getInt(path);
            return result as T?;
          } else {
            return null;
          }

        case bool:
          var rr = sharedPref.containsKey(path);
          print("get result $rr");
          if (sharedPref.containsKey(path)) {
            var result = sharedPref.getBool(path);
            return result as T?;
          } else {
            return null;
          }

        case List<String>:
          var rr = sharedPref.containsKey(path);
          if (sharedPref.containsKey(path)) {
            var result = sharedPref.getStringList(path);
            return result as T?;
          } else {
            return null;
          }

        default:
          return null;
      }
    } catch (e) {
      print(e.toString());
      return Future.error(AppException(
          type: AppException.STORAGE_EXCEPTION, message: e.toString()));
    }
  }

  @override
  Future<List<T>> getAll(String path,
      {Map<String, dynamic>? queryParameters}) async {
    return [] as List<T>;
  }

  @override
  Future<R> update<R>(String path, T? body,
      {Map<String, dynamic>? queryParameters}) async {
    return true as R;
  }

  @override
  Future<bool> delete(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      var sharedPref = await SharedPreferences.getInstance();
      var result = await sharedPref.remove(path);
      return result;
    } catch (ex) {
      print(ex);
      return Future.error(AppException(
          type: AppException.STORAGE_EXCEPTION,
          message: "trying to remove non existent key from preference"));
    }
  }

  @override
  Future<bool> saveUserInfo(User userInfo, String token) async {
    try {
      var userNameSave =
          await create<bool, String>(Constants.USERNAME, userInfo.username!);
      var PhoneSave = await create<bool, String>(
          Constants.PHONE_NUMBER, userInfo.phoneNumber!);
      if (userInfo.profileImagePath != null) {
        var profileImageSave = await create<bool, String>(
            Constants.PROFILE_IMAGE, userInfo.profileImagePath!);
      }

      var loginState = await create<bool, bool>(Constants.LOGGED_IN, true);
      var tokenSaveREsult = await create<bool, String>(Constants.TOKEN, token);
      return true;
    } catch (ex) {
      print(ex.toString());
      return Future.error(AppException(
          type: AppException.STORAGE_EXCEPTION, message: ex.toString()));
    }
  }
}
