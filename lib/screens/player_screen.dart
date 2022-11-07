import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:zmare/controller/player_controller.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/screens/download_screen.dart';
import 'package:zmare/screens/local_audio_screen.dart';
import 'package:zmare/screens/queue_list_screen.dart';
import 'package:zmare/screens/song_list_screen.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/ad_widget/banner_ad_widget.dart';

import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/image_courousel.dart';
import 'package:zmare/widget/popup_menu_list.dart';
import 'package:zmare/widget/song_widget.dart/play_pause_icon.dart';
import 'package:zmare/widget/song_widget.dart/player_control_icon.dart';
import 'package:zmare/widget/song_widget.dart/song_list.dart';

class PlayerScreen extends StatelessWidget {
  static const routeName = "/player";

  PlayerScreen({super.key});

  var isQueueScrolled = false;

  var playerController = Get.put(PlayerController());
  var currentPage = 0;

  @override
  Widget build(BuildContext context) {
    var queueInfo = playerController.appController.player.queueState;
    var carouselController = CarouselController();
    return Obx(
      () => Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: playerController.selectedColor,
            title: CustomText("Now playing",
                fontSize: 16, fontWeight: FontWeight.bold),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.keyboard_arrow_down, size: 30),
              onPressed: () {
                UIHelper.moveBack();
              },
            ),
            actions: [
              if (playerController.appController.player.playbackSrc ==
                  AudioSrcType.NETWORK)
                Obx(
                  () => PopupMenu(
                    menuList: {
                      "Download song": () {
                        var songInfo = playerController.appController.player
                            .getCurrentSongInfo();
                        playerController.downloadSong(songInfo);
                      },
                      "Remove from Downloads": () {
                        var songInfo = playerController.appController.player
                            .getCurrentSongInfo();
                        playerController.removeDownloadedSong(songInfo);
                      },
                      "Go to album": () {
                        print(
                            "album info ${playerController.appController.player.queueState?.current?.album}");
                      },
                      "Go to artist": () async {
                        var artistId = playerController
                            .appController.player.queueState?.current?.artist
                            ?.split(",");
                        var artistNames = playerController.appController.player
                            .queueState?.current?.extras?["artistNames"]
                            ?.split(",") as List<String>?;
                        print("artist id $artistId");
                        if (artistId?.isNotEmpty == true &&
                            artistNames?.isNotEmpty == true) {
                          Future.delayed(Duration.zero, () {
                            UIHelper.moveToArtistScreen(
                              artistId!,
                              artistNames ?? [],
                            );
                          });
                        }
                      },
                    },
                    inActiveMenus: [
                      playerController.isSongDownloaded
                          ? "Download song"
                          : "Remove from Downloads"
                    ],
                  ),
                )
            ],
          ),
          persistentFooterButtons: [BannerAdWidget(adSize: AdSize.fullBanner)],
          body: CustomContainer(
            padding: 0,
            margin: 0,
            borderRadius: 0,
            gradientColor: [
              playerController.selectedColor,
              Theme.of(context).scaffoldBackgroundColor
            ],
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //  Art work and song info
                    const SizedBox(height: 16),
                    if (queueInfo?.queues != null)
                      buildPlayerCarousel(context, queueInfo!.queues!,
                          playerController.appController.player.playbackSrc!,
                          initialPage: queueInfo.currentIndex,
                          controller: carouselController),
                    const SizedBox(height: 24),

                    // title and subtitle
                    StreamBuilder(
                        stream: playerController
                            .appController.player.queueStateStream,
                        builder: (context, snapshot) {
                          print("data changed ${snapshot.data?.currentIndex}");
                          if (snapshot.data != null) {
                            carouselController.animateToPage(
                                snapshot.data?.currentIndex ?? 0,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.ease);
                            playerController.trackSongLikeStatus(
                                snapshot.data!.current!.id);
                            playerController.trackSongDownloadStatus(
                                snapshot.data!.current!.id);
                            playerController.changePlayerbackgroundColor(
                                snapshot.data?.current?.artUri.toString());
                          }

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        snapshot.data?.current?.title ?? "",
                                        maxLine: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      const SizedBox(height: 4),
                                      CustomText(
                                          snapshot.data?.current
                                                  ?.extras?["artistNames"] ??
                                              "",
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium)
                                    ],
                                  ),
                                ),
                                if (playerController
                                        .appController.player.playbackSrc ==
                                    AudioSrcType.NETWORK)
                                  Obx(
                                    () => playerController.isSongLiked
                                        ? IconButton(
                                            onPressed: () async {
                                              var snackController = UIHelper
                                                  .showLoadingSnackbar();
                                              await playerController.unLikeSong(
                                                  snapshot.data!.current!.id);
                                              snackController.close(
                                                  withAnimations: true);
                                            },
                                            icon: const Icon(Icons.favorite,
                                                size: 30),
                                          )
                                        : IconButton(
                                            onPressed: () async {
                                              var snackController = UIHelper
                                                  .showLoadingSnackbar();
                                              await playerController.likeSong(
                                                  snapshot.data!.current!.id);
                                              snackController.close(
                                                  withAnimations: true);
                                            },
                                            icon: const Icon(
                                                Icons.favorite_outline,
                                                size: 30),
                                          ),
                                  )
                              ],
                            ),
                          );
                        }),
                    const SizedBox(height: 40),
                    // player controller
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: StreamBuilder(
                        stream: playerController.appController.player.position,
                        builder: (context, positionSnapshot) {
                          return StreamBuilder(
                            stream: playerController
                                .appController.player.totalDurationStream,
                            builder: (context, durationSnapshot) {
                              return ProgressBar(
                                progress:
                                    positionSnapshot.data ?? Duration.zero,
                                total: durationSnapshot.data ?? Duration.zero,
                                timeLabelPadding: 8,
                                progressBarColor:
                                    Theme.of(context).colorScheme.primary,
                                thumbColor:
                                    Theme.of(context).colorScheme.primary,
                                onSeek: (position) {
                                  playerController.appController.player
                                      .seek(position);
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          PlayerControlIcon(
                              icon: Icons.library_music,
                              onclick: () {
                                Get.toNamed(QueueListScreen.routeName,
                                    arguments: {
                                      "selectedColor":
                                          playerController.selectedColor,
                                      "selectedIndex": playerController
                                          .appController
                                          .player
                                          .queueState
                                          ?.currentIndex,
                                    });
                              }),
                          PlayerControlIcon(
                              icon: Icons.skip_previous,
                              size: 50,
                              onclick: () async {
                                playerController.appController.player.prev();
                              }),
                          PlayPauseIcon(
                            overrideDisplayBeheviour: true,
                            size: 90,
                            color: Theme.of(context).iconTheme.color ??
                                Colors.black,
                          ),
                          PlayerControlIcon(
                              icon: Icons.skip_next,
                              size: 50,
                              onclick: () async {
                                playerController.appController.player.next();
                                // carouselController.nextPage(
                                //     duration: const Duration(milliseconds: 200),
                                //     curve: Curves.ease);
                              }),
                          PlayerControlIcon(
                              icon: Icons.shuffle, onclick: () {}),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget buildPlayerCarousel(
      BuildContext context, List<MediaItem> queues, AudioSrcType audioSrc,
      {int? initialPage, required CarouselController controller}) {
    // controller.jumpToPage(initialPage ?? 0);
    print("page change ${initialPage}");

    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: ImageCarousel(
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
                      artworkHeight: MediaQuery.of(context).size.height * 0.4,
                      nullArtworkWidget: CustomImage(
                        null,
                        roundImage: true,
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: double.infinity,
                      ),
                    ))
                .toList()
            : null,
        autoScroll: false,
        infiniteScroll: false,
        showIndicator: false,
        height: MediaQuery.of(context).size.height * 0.4,
        onPageChanged: (page) async {
          print("data page changes");
          playerController.appController.player
              .seek(Duration.zero, index: page);
        },
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
        showAds: false,
        isSliver: false,
        primary: false,
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
