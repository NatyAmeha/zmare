import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zema/modals/exception.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/service/download/download_service.dart';

class FileDownloaderService implements IDownloadService {
  const FileDownloaderService();
  @override
  Future<void> pause(List<String> id) {
    // TODO: implement pause
    throw UnimplementedError();
  }

  @override
  Future<void> removeDownloads(List<String> id) {
    // TODO: implement removeDownloads
    throw UnimplementedError();
  }

  @override
  Future<void> resume(List<String> id) {
    // TODO: implement resume
    throw UnimplementedError();
  }

  @override
  Future<List<String?>> start(List<Song> songs, String path) async {
    try {
      var taskIds = <String?>[];
      await Future.forEach(songs, (song) async {
        var dir = await getExternalStorageDirectory();
        var filePath = "${dir?.path}";
        var saveDir = Directory(filePath);
        var dirSave = await saveDir.create(recursive: true);

        var taskId = await FlutterDownloader.enqueue(
            url: song.songFilePath!,
            fileName: song.title,
            savedDir: filePath,
            showNotification: true,
            openFileFromNotification: true);
        taskIds.add(taskId);
      });
      return taskIds;
    } catch (ex) {
      print(ex.toString());
      return Future.error(AppException(
          type: AppException.DOWNLOAD_EXCEPTION,
          message: "Unable to start download"));
    }
  }

  @override
  Future<void> stop(List<String> id) {
    // TODO: implement stop
    throw UnimplementedError();
  }

  @override
  Future<String?> startSingle(Song song, String path) async {
    var dir = await getExternalStorageDirectory();
    var filePath = "${dir?.path}";
    // var saveDir = Directory(filePath);
    // var dirSave = await saveDir.create(recursive: true);

    var taskId = await FlutterDownloader.enqueue(
        url: song.songFilePath!,
        fileName: song.title,
        savedDir: filePath,
        showNotification: true,
        openFileFromNotification: true);
    return taskId;
  }
}
