import 'dart:ffi';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zema/controller/player_controller.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/screens/download_screen.dart';
import 'package:zema/screens/song_list_screen.dart';
import 'package:zema/utils/ui_helper.dart';

import 'package:zema/widget/custom_container.dart';
import 'package:zema/widget/custom_image.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/image_courousel.dart';
import 'package:zema/widget/song_widget.dart/play_pause_icon.dart';
import 'package:zema/widget/song_widget.dart/player_control_icon.dart';
import 'package:zema/widget/song_widget.dart/song_list.dart';

class PlayerScreen extends StatefulWidget {
  static const routeName = "/player";

  var playerController = Get.put(PlayerController());
  PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  var isQueueScrolled = false;

  @override
  Widget build(BuildContext context) {
    var dragController = DraggableScrollableController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: CustomText("Now playing",
            fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          onPressed: () {
            UIHelper.moveBack();
          },
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: StreamBuilder(
        stream: widget.playerController.appController.player.queueState,
        builder: ((context, snapshot) => Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //  Art work and song info
                      const SizedBox(height: 8),
                      ImageCarousel(
                        images: snapshot.data?.queues
                                ?.map((e) => e.artUri!.toString())
                                .toList() ??
                            [],
                        autoScroll: false,
                        infiniteScroll: false,
                        showIndicator: false,
                        height: MediaQuery.of(context).size.height * 0.4,
                        onPageChanged: (page) {
                          widget.playerController.appController.player
                              .seek(Duration.zero, index: page);
                        },
                      ),
                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(snapshot.data?.current?.title ?? "",
                                  fontSize: 19, fontWeight: FontWeight.bold),
                              const SizedBox(height: 4),
                              CustomText(snapshot.data?.current?.artist ?? "",
                                  fontSize: 14)
                            ],
                          ),
                          IconButton(
                              onPressed: () {},
                              icon:
                                  const Icon(Icons.favorite_outline, size: 25))
                        ],
                      ),
                      const SizedBox(height: 40),
                      // player controller
                      StreamBuilder(
                        stream: widget
                            .playerController.appController.player.position,
                        builder: (context, positionSnapshot) {
                          return StreamBuilder(
                            stream: widget.playerController.appController.player
                                .totalDuration,
                            builder: (context, durationSnapshot) {
                              return ProgressBar(
                                progress:
                                    positionSnapshot.data ?? Duration.zero,
                                total: durationSnapshot.data ?? Duration.zero,
                                onSeek: (position) {
                                  widget.playerController.appController.player
                                      .seek(position);
                                },
                              );
                            },
                          );
                        },
                      ),

                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              PlayerControlIcon(
                                  icon: Icons.loop,
                                  onclick: () {
                                    Get.toNamed(DownloadScreen.routName);
                                  }),
                              PlayerControlIcon(
                                  icon: Icons.skip_previous,
                                  size: 40,
                                  onclick: () {
                                    Get.to(SongListScreen(showFilter: true));
                                  }),
                              PlayPauseIcon(isPlaying: true, isBuffering: true),
                              PlayerControlIcon(
                                  icon: Icons.skip_next,
                                  size: 40,
                                  onclick: () {}),
                              PlayerControlIcon(
                                  icon: Icons.shuffle, onclick: () {}),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: (MediaQuery.of(context).size.height * 0.1),
                      )
                    ],
                  ),
                ),
                Positioned.fill(
                  child: DraggableScrollableSheet(
                      controller: dragController,
                      initialChildSize: 0.105,
                      maxChildSize: 1.0,
                      minChildSize: 0.105,
                      builder: (context, scrollController) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 0),
                          color: Colors.white,
                          margin: const EdgeInsets.all(0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomContainer(
                                onTap: () {
                                  Future.delayed(Duration.zero, () {
                                    dragController.animateTo(
                                        isQueueScrolled ? 0.105 : 1.0,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.ease);
                                    isQueueScrolled = !isQueueScrolled;
                                    Future.delayed(Duration(seconds: 1), () {
                                      print(snapshot.data?.currentIndex);
                                      scrollController.animateTo(
                                          snapshot.data?.currentIndex
                                                  ?.toDouble() ??
                                              scrollController
                                                  .position.maxScrollExtent,
                                          duration:
                                              const Duration(milliseconds: 200),
                                          curve: Curves.ease);
                                    });
                                  });
                                  // scrollController.jumpTo(1200);
                                },
                                padding: 12,
                                color: Colors.grey[200],
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText("Up next", fontSize: 10),
                                        const SizedBox(height: 4),
                                        CustomText(
                                            snapshot.data?.queues
                                                    ?.elementAt((snapshot.data
                                                                ?.currentIndex ??
                                                            0) +
                                                        1)
                                                    .title ??
                                                "End of queue",
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon:
                                            const Icon(Icons.keyboard_arrow_up))
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Expanded(
                                child: ReorderableList(
                                  controller: scrollController,
                                  itemCount: snapshot.data?.queues?.length ?? 0,
                                  onReorder: (oldIndex, newIndex) {
                                    setState(() {
                                      // if (newIndex > oldIndex) newIndex--;
                                      // var item = widget.songs!.removeAt(oldIndex);
                                      // widget.songs!.insert(newIndex, item);
                                    });
                                  },
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      key:
                                          Key(snapshot.data!.queues![index].id),
                                      leading: CustomImage(
                                          snapshot.data?.queues![index].artUri
                                              .toString(),
                                          height: 50,
                                          width: 50,
                                          roundImage: true),
                                      title: CustomText(
                                        snapshot.data?.queues![index].title ??
                                            "",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        maxLine: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        child: CustomText(
                                            snapshot.data?.queues![index]
                                                    .artist ??
                                                "",
                                            fontSize: 13,
                                            maxLine: 1,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                )
              ],
            )),
      ),
    );
  }
}
