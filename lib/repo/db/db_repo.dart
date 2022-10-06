import 'package:sqflite/sqflite.dart';
import 'package:zema/modals/download.dart';
import 'package:zema/modals/exception.dart';
import 'package:zema/repo/db/db_manager.dart';
import 'package:zema/repo/flutter_downloader_repo.dart';
import 'package:zema/repo/repository.dart';

class DBRepo implements IRepositroy {
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
  Future<bool> delete(String path, {Map<String, dynamic>? queryParameters}) {
    // TODO: implement delete
    throw UnimplementedError();
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
            var b = moreDownloadINfo.first;

            var additionalDownloadInfo = moreDownloadINfo
                .firstWhere((element) => element.name == e.name);
            // print("info ${b.location}");
            e.location = additionalDownloadInfo.location;
            e.url = additionalDownloadInfo.url;
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
      {S? body, Map<String, dynamic>? queryParameters}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
