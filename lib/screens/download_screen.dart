import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zema/controller/app_controller.dart';
import 'package:zema/controller/download_controller.dart';
import 'package:zema/screens/downloaded_song_screen.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/utils/extension.dart';
import 'package:zema/utils/ui_helper.dart';
import 'package:zema/viewmodels/download_viewmodel.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/download/download_list_item.dart';
import 'package:zema/widget/download/download_status.dart';
import 'package:zema/widget/error_page.dart';

class DownloadScreen extends StatelessWidget {
  static const routName = "/downloads";

  var downloadController = Get.put(DownloadController());

  @override
  Widget build(BuildContext context) {
    downloadController.getAllDownloads();
    return Scaffold(
      appBar: AppBar(title: CustomText("Downloads")),
      body: Obx(
        () => UIHelper.displayContent(
          showWhen: true,
          exception: downloadController.exception,
          isDataLoading: downloadController.isDataLoading,
          content: buildPage(),
        ),
      ),
    );
  }

  Widget buildPage() {
    return downloadController.downloadResult?.isNotEmpty == true
        ? ListView.builder(
            itemCount: downloadController.downloadResult!.length,
            itemBuilder: (context, index) => DownloadListItem(
              downloadInfo: downloadController.downloadResult![index],
              onClick: (downloads) {
                var songs = downloads.map((e) => e.toSongInfo()).toList();

                UIHelper.moveToScreen(DownloadedSongScreen.routename,
                    arguments: {
                      "title": downloadController.downloadResult![index].title,
                      "songs": songs
                    });
              },
            ),
          )
        : ErrorPage(
            message:
                "Your downloaded songs, albums and playlist collected here",
            icon: Icons.hourglass_empty_outlined,
            title: "No download found",
            actionText: "Start download",
          );
  }
}
