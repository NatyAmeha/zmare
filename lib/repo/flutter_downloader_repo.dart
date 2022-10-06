import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:zema/modals/download.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/repo/repository.dart';
import 'package:zema/service/download/download_service.dart';
import 'package:zema/service/download/file_downloader.service.dart';

abstract class IDownloadRepo extends IRepositroy<Download> {}

class FlutterDownloaderRepo implements IDownloadRepo {
  final IDownloadService downloadService;
  const FlutterDownloaderRepo({
    this.downloadService = const FileDownloaderService(),
  });

  @override
  Future<R> create<R, S>(String path, S body,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      var result = await downloadService.start(body as List<Song>, path);
      return result as R;
    } catch (ex) {
      rethrow;
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
    var downloadTasks = await FlutterDownloader.loadTasks();
    var downloadResult = downloadTasks
        ?.map(
          (task) => Download(
            location: task.savedDir,
            url: task.url,
            date: DateTime.fromMillisecondsSinceEpoch(task.timeCreated),
          ),
        )
        .toList();
    return downloadResult as List<R>;
  }

  @override
  Future<R> update<R, S>(String path,
      {S? body, Map<String, dynamic>? queryParameters}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
