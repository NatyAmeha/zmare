import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zema/modals/download.dart';
import 'package:zema/modals/exception.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/repo/db/db_manager.dart';
import 'package:zema/repo/flutter_downloader_repo.dart';
import 'package:zema/repo/repository.dart';
import 'package:zema/service/download/download_service.dart';
import 'package:zema/service/download/file_downloader.service.dart';
import 'package:zema/service/permission_service.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/utils/extension.dart';

class DownloadUsecase {
  IRepositroy? repositroy;
  IDownloadService downloadService;
  IPremissionService permission;

  DownloadUsecase(
      {this.repositroy,
      this.downloadService = const FileDownloaderService(),
      this.permission = const PermissionService()});

  Future<List<Download>> getDownloads() async {
    print("Download usecase called");
    var result =
        await repositroy!.getAll<Download>(DatabaseManager.DB_TABLE_DOWNLOAD);
    return result;
  }

  Future<bool> startDownload(
      List<Song> songs, String path, DownloadType type, String typeId) async {
    var listIds = [];
    var permissionResult =
        await permission.requestPermission(Permission.storage);
    if (permissionResult) {
      await Future.forEach(songs, (song) async {
        var taskId = await downloadService.startSingle(song, path);

        if (taskId != null) {
          var dbInsertResult = await repositroy!.create<int, Download>(
            DatabaseManager.DB_TABLE_DOWNLOAD,
            song.toDownload(taskId, type, typeId),
          );
        }
      });
      print("download completed");
      return true;
    } else {
      return Future.error(AppException(
          type: AppException.PERMISSION_DENIED_EXCEPTION,
          message: "Permission denied"));
    }
  }
}
