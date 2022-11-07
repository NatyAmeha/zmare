import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/controller/preview_controller.dart';
import 'package:zmare/modals/preview.dart';
import 'package:zmare/screens/preview/preview_page.dart';
import 'package:zmare/utils/ui_helper.dart';

class PreviewScreen extends StatefulWidget {
  static const routeName = "/previews";
  PreviewScreen({super.key});

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  var previewController = Get.put(PreviewController());

  @override
  void deactivate() {
    Future.delayed(Duration.zero, () {
      previewController.appController.showPlayerCard(true);

      previewController.previewPlayer.stop(savetoPreviousQueue: true);
      if (previewController.appController.player.savedQueues.isNotEmpty) {
        previewController.appController.player.loadPreviousQueue();
        previewController.appController.player.play();
      }
    });

    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      previewController.appController.showPlayerCard(false);
      previewController.getPreviews();
    });
    return Scaffold(
      body: Obx(
        () => UIHelper.displayContent(
          showWhen: previewController.previewList?.isNotEmpty == true,
          exception: previewController.exception,
          isDataLoading: previewController.isDataLoading,
          content: PageView.builder(
            pageSnapping: true,
            itemCount: previewController.previewList?.length ?? 0,
            scrollDirection: Axis.vertical,
            onPageChanged: (newPage) {
              if (previewController.previewPlayer.queueState?.currentIndex
                      ?.isGreaterThan(newPage) ==
                  true) {
                previewController.previewPlayer.prev();
              } else {
                previewController.previewPlayer.next();
              }
            },
            itemBuilder: (context, index) =>
                PreviewPage(previewInfo: previewController.previewList![index]),
          ),
        ),
      ),
    );
  }
}
