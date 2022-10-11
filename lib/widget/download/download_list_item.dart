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
                  fontSize: 17, fontWeight: FontWeight.bold),
              const SizedBox(height: 8),
              CustomText(widget.downloadInfo.subtitle, fontSize: 15),
              const SizedBox(height: 8),
              DownloadStatusIndicator(
                downloadBatch: widget.downloadInfo.downloads,
                size: 20,
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
            iconList: const [Icons.pause, Icons.play_arrow, Icons.close],
          )
        ],
      ),
    );
  }
}
