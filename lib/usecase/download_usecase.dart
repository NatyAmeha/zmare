import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zmare/modals/download.dart';
import 'package:zmare/modals/exception.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/repo/db/db_manager.dart';
import 'package:zmare/repo/db/download_db_repo.dart';
import 'package:zmare/repo/flutter_downloader_repo.dart';
import 'package:zmare/repo/repository.dart';
import 'package:zmare/service/download/download_service.dart';
import 'package:zmare/service/download/file_downloader.service.dart';
import 'package:zmare/service/permission_service.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/extension.dart';

class DownloadUsecase {
  IDownloadRepository? repositroy;
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

  Future<bool> startDownload(List<Song> songs, String path, DownloadType type,
      String typeId, String typeName) async {
    var listIds = [];
    var permissionResult =
        await permission.requestPermission(Permission.storage);
    if (permissionResult) {
      var a = await Future.forEach(songs, (song) async {
        var taskId = await downloadService.startSingle(song, path);
        print("download rs $taskId");
        if (taskId != null) {
          var dbInsertResult = await repositroy!.create<int, Download>(
            DatabaseManager.DB_TABLE_DOWNLOAD,
            song.toDowwnload(taskId, type, typeId, typeName),
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

  Future<bool> isPlaylistDownloaded(String playlistId) async {
    var result = await repositroy!.isPlaylistorAlbumDownloaded(playlistId);
    return result;
  }

  Future<bool> isSongDownloaded(String songId) async {
    var result = await repositroy!.isDownloaded(songId);
    return result;
  }

  Future<bool> pauseDownloads(List<String> ids) async {
    await Future.forEach(ids, (id) async {
      var result = await downloadService.pause(id);
    });
    return true;
  }

  Future<bool> resumeDownloads(List<String> ids) async {
    await Future.forEach(ids, (id) async {
      var newTaskId = await downloadService.resume(id);
      print("new task id $newTaskId");
      if (newTaskId != null) {
        var taskIDUpdateREsult =
            await repositroy!.updateDownloadTaskId(id, newTaskId);
      }
    });
    return true;
  }

  Future<Download?> getDownload(String songId) async {
    var result = await repositroy!
        .get<Download>("fileId", queryParameters: {"arg1": songId});
    return result;
  }

  Future<bool> removeDownloads(List<Download> downloads) async {
    await Future.forEach(downloads, (d) async {
      var newTaskId = await downloadService.removeDownload(d.taskId!);
      print("download id ${d.id}");
      var dbDeleteResult = await repositroy!.delete(
          DatabaseManager.DB_TABLE_DOWNLOAD,
          queryParameters: {"id": d.id});
    });
    return true;
  }
}
