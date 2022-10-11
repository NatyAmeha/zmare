import 'dart:isolate';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/modals/download.dart';
import 'package:zmare/modals/exception.dart';
import 'package:zmare/repo/db/db_repo.dart';
import 'package:zmare/repo/db/download_db_repo.dart';
import 'package:zmare/usecase/download_usecase.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/helper.dart';
import 'package:zmare/viewmodels/download_viewmodel.dart';

class DownloadController extends GetxController {
  final ReceivePort _port = ReceivePort();

  var appController = Get.find<AppController>();

  var _isDataLoading = true.obs;
  get isDataLoading => _isDataLoading.value;

  var _isLoading = false.obs;
  get isLoading => _isLoading.value;

  var _exception = AppException().obs;
  AppException get exception => _exception.value;

  List<DownloadViewmodel>? downloadResult;
  Stream<DownloadProgress>? downloadProgressStream;

  @override
  onInit() {
    _bindBackgroundIsolate();
    super.onInit();
  }

  // getDownloads() async {
  //   try {
  //     _isDataLoading(true);
  //     var downloadUsecase = DownloadUsecase(repositroy: DBRepo());
  //     var result = await downloadUsecase.getDownloads();
  //     downloadResult = result;
  //   } catch (ex) {
  //     print("fetch data error");
  //     print(ex.toString());
  //     _exception(ex as AppException);
  //   } finally {
  //     _isDataLoading(false);
  //   }
  // }

  getAllDownloads() async {
    try {
      _isDataLoading(true);
      var downloadUsecase = DownloadUsecase(repositroy: DownloadRepository());
      var result = await downloadUsecase.getDownloads();
      print(result.map((e) => e.typeName).toList());
      var downloadInfos =
          groupBy(result, (download) => download.typeId).entries.map((entry) {
        var type = DownloadType.SINGLE;
        if (entry.value.first.type == DownloadType.ALBUM) {
          type = DownloadType.ALBUM;
        } else if (type == DownloadType.PLAYLIST) {
          type == DownloadType.PLAYLIST;
        }
        return DownloadViewmodel(
          title: entry.value.first.typeName.toString(),
          subtitle: "${entry.value.length} songs",
          images: entry.value.map((e) => e.image!).toSet().toList(),
          downloads: entry.value,
        );
      }).toList();
      downloadResult = downloadInfos;
    } catch (ex) {
      print("fetch data error");
      print(ex.toString());
      _exception(ex as AppException);
    } finally {
      _isDataLoading(false);
    }
  }

  pauseDownloads(List<String> taskIds) async {
    try {
      _isLoading(true);
      var downloadUsecase = DownloadUsecase(repositroy: DownloadRepository());
      var pauseResult = await downloadUsecase.pauseDownloads(taskIds);
    } catch (ex) {
      print("pause donwload error ${ex.toString()}");
    } finally {
      _isLoading(false);
    }
  }

  resumeDownloads(List<String> taskIds) async {
    try {
      _isLoading(true);
      var downloadUsecase = DownloadUsecase(repositroy: DownloadRepository());
      var pauseResult = await downloadUsecase.resumeDownloads(taskIds);
      await getAllDownloads();
    } catch (ex) {
      print("pause donwload error ${ex.toString()}");
    } finally {
      _isLoading(false);
    }
  }

  removeDownloads(List<Download> downloads) async {
    try {
      _isLoading(true);
      var downloadUsecase = DownloadUsecase(repositroy: DownloadRepository());
      var removeResult = await downloadUsecase.removeDownloads(downloads);
      await getAllDownloads();
    } catch (ex) {
      print("delete donwload error ${ex.toString()}");
    } finally {
      _isLoading(false);
    }
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, "downloader_send_port");
    print("download_prog ${isSuccess}");
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    downloadProgressStream = _port.map((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      var downloadStatus = Helper.converttoDownloadStatus(status);

      print("download_progress ${id}  ${status.value}  ${progress} $data");
      return DownloadProgress(
          id: id, progress: progress, status: downloadStatus);
    }).asBroadcastStream();
  }

  @override
  onClose() {
    _unbindBackgroundIsolate();
    super.onClose();
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }
}
