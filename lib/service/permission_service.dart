import 'package:get/get_core/src/get_main.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zmare/modals/exception.dart';
import 'package:zmare/utils/ui_helper.dart';

abstract class IPremissionService {
  Future<bool> requestPermission(Permission permission);
  Future<bool> requestPermissionWithService(PermissionWithService permission);
  Future<bool> requestStoragePermission();
}

class PermissionService implements IPremissionService {
  const PermissionService();

  @override
  Future<bool> requestPermission(Permission permission) async {
    var status = await permission.request();
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      var showRationale = await permission.shouldShowRequestRationale;
      if (showRationale) {
        await UIHelper.showInfoDialog("Permission denied",
            "You have denied the permission to use this feature.\nPlease allow the permission to use this feature.",
            () async {
          await requestPermission(permission);
        });
        return true;
      } else {
        return false;
      }
    } else if (status.isPermanentlyDenied) {
      await UIHelper.showInfoDialog("Permission degined",
          "You have denied the permission to use this feature.\nPlease allow the permission to use this feature.",
          () async {
        await openAppSettings();
      });
      return false;
    } else {
      return false;
    }
  }

  @override
  Future<bool> requestPermissionWithService(
      PermissionWithService permission) async {
    var locationServiceStatus = await permission.serviceStatus;
    if (locationServiceStatus.isEnabled) {
      return await requestPermission(permission);
    } else {
      openAppSettings();

      throw AppException(type: AppException.SERVICE_NOT_ENABLED_EXCEPTION);
    }
  }

  @override
  Future<bool> requestStoragePermission() async {
    var audioQuery = OnAudioQuery();
    var permissionstatus = await audioQuery.permissionsStatus();
    if (!permissionstatus) {
      var result = await audioQuery.permissionsRequest();
      return result;
    } else {
      return permissionstatus;
    }
  }
}
