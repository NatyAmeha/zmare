import 'package:on_audio_query/on_audio_query.dart';

abstract class IPremissionService {
  Future<bool> requestStoragePermission();
}

class PermissionService extends IPremissionService {
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
