import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zema/controller/player_controller.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/screens/download_screen.dart';
import 'package:zema/screens/song_list_screen.dart';

import 'package:zema/widget/custom_container.dart';
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
  var images = [
    "https://i.pinimg.com/736x/8a/b8/7b/8ab87bd6999d659eb282fbed00895d86--last-fm-album-cover.jpg",
    "https://imusician.imgix.net/images/how-to-make-an-album-cover.jpg?auto=compress&w=1200&h=630&fit=crop"
  ];

  var songLists = [
    Song(title: "Song title 1", artistsName: ["Artist title 1"]),
    Song(title: "song no 2", artistsName: ["artist 2"]),
    Song(title: "short song title", artistsName: ["singers name info"]),
    Song(title: "Long Song and artist title", artistsName: ["Artist title 1"]),
    Song(title: "gospel playlist", artistsName: ["Long artist name and info"]),
    Song(title: "Long song with album info", artistsName: ["Artist title 1"]),
  ];

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
          onPressed: () {},
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //  Art work and song info
                const SizedBox(height: 8),
                ImageCarousel(
                    images: images,
                    autoScroll: false,
                    infiniteScroll: false,
                    showIndicator: false,
                    height: MediaQuery.of(context).size.height * 0.4),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText("Song short title",
                            fontSize: 19, fontWeight: FontWeight.bold),
                        const SizedBox(height: 4),
                        CustomText("Artist Name", fontSize: 14)
                      ],
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_outline, size: 25))
                  ],
                ),

                // player controller

                Slider.adaptive(
                    divisions: 5,
                    value: 43,
                    onChanged: (newValue) {},
                    max: 100),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText("1:01", fontSize: 10),
                    CustomText("5:59", fontSize: 10),
                  ],
                ),
                Spacer(),
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
                            icon: Icons.skip_next, size: 40, onclick: () {}),
                        PlayerControlIcon(icon: Icons.shuffle, onclick: () {}),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
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
                            });
                            // scrollController.jumpTo(1200);
                          },
                          padding: 12,
                          color: Colors.grey[200],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText("Up next", fontSize: 10),
                                  const SizedBox(height: 4),
                                  CustomText("Next Song Name",
                                      fontSize: 16, fontWeight: FontWeight.bold)
                                ],
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.keyboard_arrow_up))
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: SongList(
                            songLists,
                            controller: scrollController,
                            isSliver: false,
                            isReorderable: true,
                          ),
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
