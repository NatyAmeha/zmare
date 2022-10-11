import 'dart:ffi';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:zmare/controller/player_controller.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/screens/download_screen.dart';
import 'package:zmare/screens/song_list_screen.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/ad_widget/banner_ad_widget.dart';

import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/image_courousel.dart';
import 'package:zmare/widget/song_widget.dart/play_pause_icon.dart';
import 'package:zmare/widget/song_widget.dart/player_control_icon.dart';
import 'package:zmare/widget/song_widget.dart/song_list.dart';

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
    var carouselController = CarouselController();
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
                      if (snapshot.data != null)
                        buildPlayerCarousel(
                            snapshot.data!.queues!,
                            widget.playerController.appController.player
                                .playbackSrc!,
                            initialPage: snapshot.data!.currentIndex,
                            controller: carouselController),
                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(snapshot.data?.current?.title ?? "",
                                    fontSize: 19, fontWeight: FontWeight.bold),
                                const SizedBox(height: 4),
                                CustomText(snapshot.data?.current?.artist ?? "",
                                    fontSize: 14)
                              ],
                            ),
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
                                    widget.playerController.appController.player
                                        .prev();
                                    carouselController.previousPage(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.ease);
                                  }),
                              PlayPauseIcon(isPlaying: true, isBuffering: true),
                              PlayerControlIcon(
                                  icon: Icons.skip_next,
                                  size: 40,
                                  onclick: () {
                                    widget.playerController.appController.player
                                        .next();
                                    carouselController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.ease);
                                  }),
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
                                  scrollQueueList(
                                      dragController,
                                      scrollController,
                                      snapshot.data?.currentIndex ?? 0,
                                      70);
                                },
                                padding: 12,
                                color: Colors.grey[200],
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
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
                                              maxLine: 1,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.bold)
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon:
                                            const Icon(Icons.keyboard_arrow_up))
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              if (snapshot.data!.queues?.isNotEmpty == true)
                                buildQueueList(
                                    snapshot.data!.queues!,
                                    scrollController,
                                    widget.playerController.appController.player
                                        .playbackSrc),
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

  Widget buildPlayerCarousel(List<MediaItem> queues, AudioSrcType audioSrc,
      {int? initialPage, required CarouselController controller}) {
    // controller.jumpToPage(initialPage ?? 0);
    print("page change ${initialPage}");

    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Stack(
        children: [
          ImageCarousel(
            initialPage: initialPage ?? 0,
            controller: controller,
            images: audioSrc == AudioSrcType.LOCAL_STORAGE
                ? null
                : queues.map((e) => e.artUri.toString()).toList(),
            carouselItems: audioSrc == AudioSrcType.LOCAL_STORAGE
                ? queues
                    .map((e) => QueryArtworkWidget(
                          id: int.parse(e.id),
                          type: ArtworkType.AUDIO,
                          artworkWidth: double.infinity,
                          artworkHeight:
                              MediaQuery.of(context).size.height * 0.4,
                        ))
                    .toList()
                : null,
            autoScroll: false,
            infiniteScroll: false,
            showIndicator: false,
            height: MediaQuery.of(context).size.height * 0.4,
            onPageChanged: (page) {
              widget.playerController.appController.player
                  .seek(Duration.zero, index: page);
            },
          ),
          Positioned(
              left: 8,
              right: 8,
              child: BannerAdWidget(
                adSize: AdSize.largeBanner,
              ))
        ],
      ),
    );
  }

  Widget buildQueueList(List<MediaItem> queues,
      ScrollController scrollController, AudioSrcType? srcType) {
    var songListFromQueue = queues
        .map((e) => Song(
              id: e.id,
              title: e.title,
              songFilePath: e.extras!["songFile"],
              artistsName: e.artist?.split(","),
              album: e.album,
              thumbnailPath: e.artUri.toString(),
            ))
        .toList();
    return Expanded(
      child: SongList(
        songListFromQueue,
        isSliver: false,
        controller: scrollController,
        isReorderable: true,
        src: srcType ?? AudioSrcType.NETWORK,
      ),
    );
  }

  scrollQueueList(DraggableScrollableController controller,
      ScrollController listScrollController, int index, double listItemHeight) {
    Future.delayed(Duration.zero, () {
      controller.animateTo(isQueueScrolled ? 0.105 : 1.0,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
      isQueueScrolled = !isQueueScrolled;
      scrollinQueueList(listScrollController, index, listItemHeight);
    });
  }

  scrollinQueueList(
      ScrollController scrollController, int index, double listItemHeight) {
    Future.delayed(const Duration(seconds: 1), () {
      scrollController.animateTo((index + 1) * listItemHeight,
          duration: const Duration(milliseconds: 200), curve: Curves.ease);
    });
  }
}
