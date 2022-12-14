import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zmare/utils/constants.dart';

class ApiClient {
  static Dio? _dioClient;

  static Dio getDioInstance() {
    if (_dioClient != null) {
      return _dioClient!;
    } else {
      var dioOption = BaseOptions(
        baseUrl: "http://api.komkum.com",
        connectTimeout: 30000,
        receiveTimeout: 30000,
        sendTimeout: 30000,
        responseType: ResponseType.json,
        contentType: ContentType.json.toString(),
      );
      _dioClient = Dio(dioOption);
      addAuthorizationInterceptor();
      return _dioClient!;
    }
  }

  static void addAuthorizationInterceptor() {
    _dioClient!.interceptors.clear();
    _dioClient!.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      // var pref = SharedPreferenceRepository<String>();
      var pr = await SharedPreferences.getInstance();
      var tokenResult = pr.getString(Constants.TOKEN);
      if (tokenResult != null) {
        // var b = tokenResult.replaceAllMapped("", (match) => null);
        var a = 'Bearer ${tokenResult}';
        print(a);
        options.headers[HttpHeaders.authorizationHeader] = a;
        // options.headers["Accept"] = "*/*";
      }
      return handler.next(options); //modify your request
    }));
  }
}
