import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/modals/download.dart';
import 'package:zmare/repo/shared_pref_repo.dart';
import 'package:zmare/utils/constants.dart';

class AppException implements Exception {
  final int? type;
  String title;
  String? message;
  String actionText;
  Function? action;
  final int? statusCode;
  AppException({
    this.type,
    this.message,
    this.statusCode,
    this.title = "Error occured",
    this.actionText = "Try again",
    this.action,
  });

  static const TIMEOUT_EXCEPTION = 1;
  static const NETWORK_EXCEPTION = 2;
  static const UNAUTORIZED_EXCEPTION = 3;
  static const NOT_FOUND_EXCEPTION = 4;
  static const SERVER_EXCEPTION = 5;
  static const BAD_REQUEST_EXCEPTION = 6;
  static const CANCEL_EXCEPTION = 7;
  static const UNKNOWN_EXCEPTION = 8;
  static const STORAGE_EXCEPTION = 9;

  static const SERVICE_NOT_ENABLED_EXCEPTION = 9;
  static const PERMISSION_DENIED_EXCEPTION = 10;
  static const PERMISSION_DENIED_FOREVER_EXCEPTION = 11;

  static const INVALID_PHONE_NUMBER_EXCEPTION = 12;
  static const DOWNLOAD_EXCEPTION = 13;
  static const DATABASE_EXCEPTION = 14;
  static const PLATFORM_EXCEPTION = 15;

  static AppException handleerror(DioError ex) {
    switch (ex.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
        return AppException(
          type: TIMEOUT_EXCEPTION,
          message: "Unable to connect to the server",
        );

      case DioErrorType.response:
        switch (ex.response?.statusCode) {
          case 401:
            deleteUserInfos();
            return AppException(
                type: UNAUTORIZED_EXCEPTION, message: ex.message);
          case 404:
            return AppException(type: NOT_FOUND_EXCEPTION, message: ex.message);
          case 500:
            return AppException(type: SERVER_EXCEPTION, message: ex.message);
          case 400:
            return AppException(
                type: BAD_REQUEST_EXCEPTION, message: ex.message);

          default:
            return AppException(type: UNKNOWN_EXCEPTION, message: ex.message);
        }
        break;
      case DioErrorType.cancel:
        return AppException(
            type: AppException.CANCEL_EXCEPTION, message: ex.message);

      case DioErrorType.other:
        return AppException(
            type: AppException.UNKNOWN_EXCEPTION,
            message: "Unable to connect to the server");

      default:
        return AppException(
            type: AppException.UNKNOWN_EXCEPTION, message: ex.message);
    }
  }

  static deleteUserInfos() {
    var appController = Get.find<AppController>();
    appController.logout(navigateToAccount: false);
  }
}
