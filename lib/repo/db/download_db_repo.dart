import 'package:zmare/modals/exception.dart';
import 'package:zmare/repo/db/db_repo.dart';
import 'package:zmare/repo/repository.dart';

import 'db_manager.dart';

abstract class IDownloadRepository extends IRepositroy {
  Future<int> updateDownloadTaskId(String oldTAskId, String newTaskId);
  Future<bool> isDownloaded(String id);
  Future<bool> isPlaylistorAlbumDownloaded(String id);
}

class DownloadRepository extends DBRepo implements IDownloadRepository {
  @override
  Future<int> updateDownloadTaskId(String oldTAskId, String newTaskId) async {
    try {
      var database = await DatabaseManager.getInstance().database;
      var updateCountResult = await database.update(
          DatabaseManager.DB_TABLE_DOWNLOAD, {"taskId": newTaskId},
          where: "taskId", whereArgs: [oldTAskId]);

      return updateCountResult;
    } catch (ex) {
      print("task id update ${ex.toString()}");
      rethrow;
    }
  }

  @override
  Future<bool> isDownloaded(String songId) async {
    try {
      var database = await DatabaseManager.getInstance().database;
      var downloadResult = await database.query(
          DatabaseManager.DB_TABLE_DOWNLOAD,
          where: "fileId=?",
          whereArgs: [songId],
          distinct: true,
          limit: 1);

      return (downloadResult.isNotEmpty);
    } catch (ex) {
      print("query ${ex.toString()}");
      return Future.error(AppException(
          type: AppException.DOWNLOAD_EXCEPTION,
          message: "unable to check downloade"));
    }
  }

  @override
  Future<bool> isPlaylistorAlbumDownloaded(String id) async {
    try {
      var database = await DatabaseManager.getInstance().database;
      var downloadResult = await database.query(
        DatabaseManager.DB_TABLE_DOWNLOAD,
        where: "typeId =?",
        whereArgs: [id],
        distinct: true,
      );

      return (downloadResult.isNotEmpty);
    } catch (ex) {
      print("query ${ex.toString()}");
      return Future.error(AppException(
          type: AppException.DOWNLOAD_EXCEPTION,
          message: "unable to check downloade"));
    }
  }
}
