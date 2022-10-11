import 'dart:async';
import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zmare/modals/exception.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/service/download/download_service.dart';

class FileDownloaderService implements IDownloadService {
  const FileDownloaderService();
  @override
  Future<void> pause(String id) async {
    try {
      await FlutterDownloader.pause(taskId: id);
    } catch (ex) {
      print(ex.toString());
    }
  }

  @override
  Future<void> removeDownload(String id) async {
    try {
      await FlutterDownloader.remove(taskId: id, shouldDeleteContent: true);
    } catch (ex) {
      print(ex.toString());
      return Future.error(AppException(
          type: AppException.DOWNLOAD_EXCEPTION,
          message: "unable to delete download"));
    }
  }

  @override
  Future<String?> resume(String id) async {
    try {
      var result = await FlutterDownloader.resume(taskId: id);
      print("resume update ${result}");
      return result;
    } catch (ex) {
      print(ex.toString());
      return Future.error(AppException(
          type: AppException.DOWNLOAD_EXCEPTION,
          message: "unable to resume download"));
    }
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

  @override
  Stream<int> getDownloadProgress(String taskId) async* {
    var donwloadTasks = await FlutterDownloader.loadTasks();
    var selectedDownloadTask =
        donwloadTasks?.firstWhere((element) => element.taskId == taskId);
    if (selectedDownloadTask != null) {
      var timer = Timer.periodic(Duration(seconds: 1), (timer) {});
    }
  }
}
