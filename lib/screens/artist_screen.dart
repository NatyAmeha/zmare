import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zema/controller/artist_controller.dart';
import 'package:zema/modals/album.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/screens/category_screen.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/utils/ui_helper.dart';
import 'package:zema/widget/album_widget/album_list.dart';
import 'package:zema/widget/artist_widget/follow_unfollow_btn.dart';
import 'package:zema/widget/custom_button.dart';
import 'package:zema/widget/custom_carousel.dart';
import 'package:zema/widget/custom_container.dart';
import 'package:zema/widget/custom_image.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/error_page.dart';
import 'package:zema/widget/list_header.dart';
import 'package:zema/widget/loading_progressbar.dart';
import 'package:zema/widget/song_widget.dart/song_list.dart';

class ArtistScreen extends StatelessWidget {
  static const routeName = "/artist/:id";
  ArtistScreen({super.key});

  var artistController = Get.put(ArtistController());

  @override
  Widget build(BuildContext context) {
    var artistId = Get.parameters["id"];
    artistController.getArtist(artistId!);
    return Scaffold(
      body: Obx(
        () => UIHelper.displayContent(
          content: buildContent(),
          showWhen: artistController.artistResult.artist != null,
          exception: artistController.exception,
          isDataLoading: artistController.isDataLoading,
        ),
      ),
    );
  }

  Widget buildContent() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              children: [
                CustomImage(
                  artistController.artistResult.artist?.profileImagePath
                      ?.elementAt(0),
                  // placeholder: "assets/images/artist_placeholder.jpg",
                  width: double.infinity,
                  height: 300,
                ),
                Positioned(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomContainer(
                      // borderColor: Colors.transparent,
                      padding: 16,
                      gradientColor: const [Colors.transparent, Colors.grey],
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (artistController.artistResult.artist !=
                                      null) ...[
                                    CustomText(
                                      artistController
                                              .artistResult.artist?.name ??
                                          "",
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(height: 4),
                                    CustomText(
                                      "${artistController.artistResult.artist?.followersCount} followers",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )
                                  ],
                                ],
                              ),
                              if (artistController.artistResult.artist?.id !=
                                  null)
                                FollowUnfollowArtistBtn(
                                    artistId: artistController
                                        .artistResult.artist!.id!)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: CustomContainer(
              color: Colors.grey,
              padding: 0,
              child: Stack(
                children: [
                  ListTile(
                    // contentPadding: const EdgeInsets.only(top: 32),
                    leading: CustomImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0rXLxvzsiu1TFgCZW1H5j0QKRTW4SA3iUp-2ykco4teeM8GqQBlBpNxu-ikhhlcDafgc&usqp=CAU",
                        height: 70,
                        width: 50,
                        roundImage: true),
                    title: CustomText(
                      "Latest song",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    subtitle: CustomText("Album", fontSize: 15),
                    trailing: IconButton(
                      icon: Icon(Icons.play_circle),
                      onPressed: () {},
                    ),
                  ),
                  Positioned.fill(
                    left: 4,
                    top: 4,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Badge(
                        toAnimate: false,
                        shape: BadgeShape.square,
                        badgeColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        borderRadius: BorderRadius.circular(8),
                        badgeContent: CustomText("Latest", fontSize: 12),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        if (artistController.artistResult.topSongs?.isNotEmpty == true)
          SliverToBoxAdapter(
            child: CustomCarousel(
              widgets: [
                SongList(
                  artistController.artistResult.topSongs!.take(5).toList(),
                  isSliver: false,
                  shrinkWrap: true,
                ),
                if (artistController
                        .artistResult.artist!.singleSongs?.isNotEmpty ==
                    true)
                  SongList(
                    artistController.artistResult.artist!.singleSongs!
                        .map((e) => Song.fromJson(e))
                        .take(5)
                        .toList(),
                    isSliver: false,
                    shrinkWrap: true,
                  )
              ],
              headers: [
                ListHeader(
                  "Top Songs",
                  isSliver: false,
                  bottomPadding: 0,
                  topPadding: 0,
                  showMore: artistController.artistResult.topSongs!.length > 2,
                ),
                if (artistController
                        .artistResult.artist!.singleSongs?.isNotEmpty ==
                    true)
                  ListHeader(
                    "Single Songs",
                    isSliver: false,
                    bottomPadding: 0,
                    topPadding: 0,
                    showMore: artistController
                            .artistResult.artist!.singleSongs!.length >
                        2,
                  )
              ],
              height: 320,
            ),
            // ListHeader("Popular songs", bottomPadding: 16),
            // SongList(artistController.artistResult.topSongs!.take(5).toList()),
          ),
        if (artistController.artistResult.artist?.albums?.isNotEmpty ==
            true) ...[
          ListHeader("Albums"),
          SliverToBoxAdapter(
            child: AlbumList(
              artistController.artistResult.artist!.albums!
                  .map((e) => Album.fromJson(e))
                  .toList(),
              listType: AlbumListType.ALBUM_HORIZONTAL_LIST,
              height: 250,
              width: 200,
            ),
          )
        ],
      ],
    );
  }
}
