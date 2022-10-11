import 'package:sqflite/sqflite.dart';
import 'package:zmare/modals/download.dart';
import 'package:zmare/modals/exception.dart';
import 'package:zmare/repo/db/db_manager.dart';
import 'package:zmare/repo/flutter_downloader_repo.dart';
import 'package:zmare/repo/repository.dart';

class DBRepo implements IRepositroy {
  // path parameter is database table name for db_repo
  @override
  Future<R> create<R, S>(String path, S body,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      switch (S) {
        case Download:
          var database = await DatabaseManager.getInstance().database;
          var result = await database.insert(path, (body as Download).toJson());
          print("create result $result");
          return result as R;

        default:
          return Future.error(AppException(message: "No matching type found"));
      }
    } catch (ex) {
      print("db insert error ${ex.toString()}");
      return Future.error(
          AppException(message: "Unable to add data to database"));
    }
  }

  @override
  Future<bool> delete(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      var database = await DatabaseManager.getInstance().database;
      var result = await database
          .delete(path, where: "id = ?", whereArgs: [queryParameters!["id"]]);

      print("delete result $result");
      return result > 0;
    } catch (ex) {
      print("db delete error${ex.toString()}");
      return Future.error(
          AppException(message: "Unable to delete data from database"));
    }
  }

  @override
  Future<R?> get<R>(String path, {Map<String, dynamic>? queryParameters}) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<List<R>> getAll<R>(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      switch (R) {
        case Download:
          var database = await DatabaseManager.getInstance().database;
          var result = await database.query(path);
          var flutterDownloader = const FlutterDownloaderRepo();
          var moreDownloadINfo = await flutterDownloader.getAll<Download>("");
          var downloadResult = result.map((e) => Download.fromJson(e)).toList();
          for (var e in downloadResult) {
            var additionalDownloadInfo = moreDownloadINfo
                .firstWhere((element) => element.name == e.name);
            // print("info ${b.location}");
            e.location = additionalDownloadInfo.location;
            e.url = additionalDownloadInfo.url;
            e.status = additionalDownloadInfo.status;
            e.progress = additionalDownloadInfo.progress;

            e.date = additionalDownloadInfo.date;
          }

          return downloadResult.cast<R>();

        default:
          return Future.error(AppException(message: "No matching type found"));
      }
    } catch (ex) {
      print("db fetch error${ex.toString()}");
      return Future.error(
          AppException(message: "Unable to add data to database"));
    }
  }

  @override
  Future<R> update<R, S>(String path,
      {S? body, Map<String, dynamic>? queryParameters}) async {
    try {
      var result;
      var database = await DatabaseManager.getInstance().database;
      switch (S) {
        case Download:
          // return number of updated rows
          result = await database.update(path, (S as Download).toJson(),
              where: "id = ?", whereArgs: [queryParameters!["id"]]);
          break;
        default:
          return Future.error(AppException(
              type: AppException.DATABASE_EXCEPTION, message: "Type mismatch"));
      }
      return result as R;
    } catch (ex) {
      print(ex.toString());
      rethrow;
    }
  }
}
