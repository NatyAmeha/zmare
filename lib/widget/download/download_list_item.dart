import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/download_controller.dart';
import 'package:zmare/modals/download.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/viewmodels/download_viewmodel.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/download/download_status.dart';
import 'package:zmare/widget/image_collection.dart';
import 'package:zmare/widget/popup_menu_list.dart';

class DownloadListItem extends StatefulWidget {
  DownloadViewmodel downloadInfo;
  Function(List<Download>)? onClick;
  DownloadListItem({required this.downloadInfo, this.onClick});

  @override
  State<DownloadListItem> createState() => _DownloadListItemState();
}

class _DownloadListItemState extends State<DownloadListItem> {
  var downloadController = Get.find<DownloadController>();
  var downloadState = DownloadStatus.IN_PROGRESS;
  var inActiveMenus = <String>[];
  var inActiveIconsIndex = <int>[];

  List<String> get taskIds =>
      widget.downloadInfo.downloads.map((e) => e.taskId!).toList();

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: () {
        widget.onClick?.call(widget.downloadInfo.downloads);
      },
      padding: 16,
      child: Row(
        children: [
          GridImageCollection(widget.downloadInfo.images,
              height: 100, width: 100),
          const SizedBox(width: 16),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(widget.downloadInfo.title,
                  textStyle: Theme.of(context).textTheme.titleMedium,
                  fontWeight: FontWeight.bold),
              const SizedBox(height: 8),
              CustomText(
                widget.downloadInfo.subtitle,
                textStyle: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              DownloadStatusIndicator(
                downloadBatch: widget.downloadInfo.downloads,
                size: 20,
                onStatusUpdate: (st) {
                  Future.delayed(Duration.zero, () {
                    setState(() {
                      var result = getRemovedMenus(st);
                      inActiveMenus = result.values.toList();
                      inActiveIconsIndex = result.keys.toList();
                    });
                  });
                },
              )
            ],
          )),
          const SizedBox(width: 16),
          PopupMenu(
            menuList: {
              "Pause download": () {
                downloadController.pauseDownloads(taskIds);

                setState(() {
                  downloadState = DownloadStatus.PAUSED;
                });
              },
              "Resume download": () {
                downloadController.resumeDownloads(taskIds);
              },
              "Cancel download": () {
                downloadController
                    .removeDownloads(widget.downloadInfo.downloads);
              }
            },
            inActiveMenus: inActiveMenus,
          )
        ],
      ),
    );
  }

  Map<int, String> getRemovedMenus(DownloadStatus status) {
    if (status == DownloadStatus.PAUSED)
      return {0: "Pause download"};
    else if (status == DownloadStatus.IN_PROGRESS)
      return {1: "Resume download"};
    else
      return {0: "Pause download", 1: "Resume download"};
  }
}
