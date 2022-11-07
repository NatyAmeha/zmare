import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/song_widget.dart/song_list.dart';
import 'package:zmare/widget/song_widget.dart/song_list_item.dart';

class QueueListScreen extends StatelessWidget {
  QueueListScreen({super.key});
  static const routeName = "/queue";
  var appController = Get.find<AppController>();
  var scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var args = Get.arguments as Map<String, dynamic>;
    var selectedIndex = args["selectedIndex"] as int? ?? 0;
    var color = args["selectedColor"] as Color;
    print("selected index $selectedIndex");
    Future.delayed(Duration(milliseconds: 100), () {
      scrollController.animateTo((selectedIndex + 1) * 65,
          duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    });

    return Scaffold(
      appBar: AppBar(
        title: CustomText("Queue List"),
      ),
      body: CustomContainer(
        padding: 0,
        // gradientColor: [Theme.of(context).scaffoldBackgroundColor, color],
        child: StreamBuilder(
          stream: appController.player.queueStateStream,
          builder: (context, snapshot) {
            if (snapshot.data?.queues?.isNotEmpty == true) {
              var songListFromQueue = snapshot.data!.queues!
                  .map((e) => Song(
                        id: e.id,
                        title: e.title,
                        songFilePath: e.extras!["songFile"],
                        artistsName: e.extras?["artistNames"].split(","),
                        album: e.album,
                        thumbnailPath: e.artUri.toString(),
                      ))
                  .toSet()
                  .toList();
              return SongList(
                songListFromQueue.toList(),
                controller: scrollController,
                showAds: false,
                isSliver: false,
                primary: false,
                isDismissable: true,
                isReorderable: true,
                src: appController.player.playbackSrc ?? AudioSrcType.NETWORK,
                onDismissed: (songInfo, index) {
                  appController.removeFromQueue(index);
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
