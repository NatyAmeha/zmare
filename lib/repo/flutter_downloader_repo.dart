import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:zmare/modals/download.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/repo/repository.dart';
import 'package:zmare/service/download/download_service.dart';
import 'package:zmare/service/download/file_downloader.service.dart';
import 'package:zmare/utils/helper.dart';

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
    var b = downloadTasks?.elementAt(1).filename;
    var downloadResult = downloadTasks
        ?.map(
          (e) => Download(
            name: e.filename,
            progress: e.progress,
            status: Helper.converttoDownloadStatus(e.status),
            location: "${e.savedDir}/${e.filename}",
            url: e.url,
            date: DateTime.fromMillisecondsSinceEpoch(e.timeCreated),
          ),
        )
        .toList();
    print("plain result ${downloadResult?.map((e) => e.location)}");
    return downloadResult as List<R>;
  }

  @override
  Future<R> update<R, S>(String path,
      {S? body, Map<String, dynamic>? queryParameters}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
