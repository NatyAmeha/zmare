import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/download_controller.dart';
import 'package:zmare/modals/download.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/widget/custom_text.dart';

class DownloadStatusIndicator extends StatelessWidget {
  var downloadController = Get.find<DownloadController>();
  List<int>? incompleteDownloads;

  double size;
  List<Download> downloadBatch;

  DownloadStatusIndicator({required this.downloadBatch, this.size = 30}) {
    incompleteDownloads = downloadBatch
        .map((e) => e.progress ?? 0)
        .where((pr) => pr < 100)
        .toList();
  }
  List<String?> get ids => downloadBatch.map((e) => e.taskId).toList();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: downloadController.downloadProgressStream,
        initialData: buildInitial(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Row(
              children: [
                if (computeStatus(snapshot.data!) == DownloadStatus.NOT_STARTED)
                  const Icon(Icons.download, color: Colors.blue),
                if (computeStatus(snapshot.data!) == DownloadStatus.FAILED)
                  const Icon(Icons.error_outline, color: Colors.red),
                if (computeStatus(snapshot.data!) == DownloadStatus.COMPLETED)
                  const Icon(Icons.download_done_sharp, color: Colors.blue),
                if (computeStatus(snapshot.data!) == DownloadStatus.PAUSED)
                  const Icon(Icons.pause, color: Colors.blue),
                if (computeStatus(snapshot.data!) == DownloadStatus.IN_PROGRESS)
                  SizedBox(
                    height: size,
                    width: size,
                    child: CircularProgressIndicator.adaptive(
                      value: (computeProgress(snapshot.data!)) / 100,
                      strokeWidth: 3,
                      backgroundColor: Colors.grey,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
                const SizedBox(width: 8),
                if (computeStatus(snapshot.data!) == DownloadStatus.COMPLETED)
                  CustomText("completed", fontSize: 11),
                if (computeStatus(snapshot.data!) == DownloadStatus.PAUSED)
                  CustomText("Paused", fontSize: 11),
                if (computeStatus(snapshot.data!) == DownloadStatus.IN_PROGRESS)
                  CustomText("${(computeProgress(snapshot.data!))}%",
                      fontSize: 11),
              ],
            );
          } else {
            return Container();
          }
        });
  }

  DownloadProgress buildInitial() {
    var statuses = downloadBatch.map((e) => e.status);
    print(statuses);
    DownloadStatus status;
    if (statuses.contains(DownloadStatus.PAUSED))
      status = DownloadStatus.PAUSED;
    else if (statuses.contains(DownloadStatus.FAILED))
      status = DownloadStatus.FAILED;
    else if (statuses.contains(DownloadStatus.COMPLETED))
      status = DownloadStatus.COMPLETED;
    else
      status = DownloadStatus.NOT_STARTED;
    return DownloadProgress(progress: 0, status: status);
  }

  DownloadStatus computeStatus(DownloadProgress status) {
    if (ids.contains(status.id)) {
      var newStatus = status.status;
      return newStatus;
    } else {
      return buildInitial().status;
    }
  }

  int computeProgress(DownloadProgress status) {
    var progress = incompleteDownloads?.sum ?? 0;
    if (ids.contains(status.id)) {
      progress += (status.progress);
    }
    return progress ~/ (incompleteDownloads?.length ?? 1);
  }
}
