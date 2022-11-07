import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:zmare/controller/artist_controller.dart';
import 'package:zmare/modals/album.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/screens/artist/artist_stat_screen.dart';
import 'package:zmare/screens/category_screen.dart';
import 'package:zmare/screens/song_list_screen.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/viewmodels/artist_viewmodel.dart';
import 'package:zmare/widget/ad_widget/banner_ad_widget.dart';
import 'package:zmare/widget/album_widget/album_list.dart';
import 'package:zmare/widget/artist_widget/follow_unfollow_btn.dart';
import 'package:zmare/widget/custom_button.dart';
import 'package:zmare/widget/custom_carousel.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/error_page.dart';
import 'package:zmare/widget/list_header.dart';
import 'package:zmare/widget/loading_progressbar.dart';
import 'package:zmare/widget/song_widget.dart/song_list.dart';

class ArtistScreen extends StatelessWidget {
  static const routeName = "/artist/:id";
  String? artistId;
  ArtistScreen({super.key, this.artistId});

  var artistController = Get.put(ArtistController());
  var scrollController = ScrollController();
  var args = Get.arguments as Map<String, dynamic>?;

  @override
  Widget build(BuildContext context) {
    print("ARtist screen called");
    artistController.artistResult = null;
    var id = artistId ?? Get.parameters["id"] ?? "";
    Future.delayed(Duration.zero, () {
      artistController.getArtist(id);
    });
    return Scaffold(
      body: Obx(
        () => UIHelper.displayContent(
          content: buildContent(context),
          showWhen: artistController.artistResult != null,
          exception: artistController.exception,
          isDataLoading: artistController.isDataLoading,
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          title: CustomText(artistController.artistResult?.artist?.name ?? ""),
          expandedHeight: 300,
          pinned: true,
          excludeHeaderSemantics: true,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: Stack(
              children: [
                CustomImage(
                  artistController.artistResult?.artist?.profileImagePath
                      ?.elementAt(0),
                  // placeholder: "assets/images/artist_placeholder.jpg",
                  width: double.infinity,
                  height: 300,
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomContainer(
                          gradientColor: [
                            Colors.transparent,
                            Colors.grey,
                            Theme.of(context).scaffoldBackgroundColor,
                          ],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (artistController.artistResult?.artist !=
                                      null) ...[
                                    CustomText(
                                      artistController
                                              .artistResult?.artist?.name ??
                                          "",
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(height: 4),
                                    CustomText(
                                        "${artistController.artistResult?.artist?.followersCount} followers",
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge)
                                  ],
                                ],
                              ),
                              if (artistController.artistResult?.artist?.id !=
                                  null)
                                FollowUnfollowArtistBtn(
                                    artistId: artistController
                                        .artistResult!.artist!.id!)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        if (artistController.artistResult != null) ...[
          displayLatest(artistController.artistResult!, context),
          buildSongCarousel(context)
        ],
        if (artistController.albums?.isNotEmpty == true) ...[
          ListHeader(
            "Albums",
            bottomPadding: 0,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                AlbumList(
                  artistController.albums!,
                  listType: AlbumListType.ALBUM_HORIZONTAL_LIST,
                  height: 250,
                  width: 200,
                ),
                BannerAdWidget(adSize: AdSize.largeBanner)
              ],
            ),
          ),
        ],
        if (artistController.artistResult != null)
          SliverToBoxAdapter(
            child: buildRankWidget(artistController.artistResult!, context),
          ),
        const SliverToBoxAdapter(child: SizedBox(height: 80))
      ],
    );
  }

  Widget displayLatest(ArtistViewmodel artistInfo, BuildContext context) {
    var title = "";
    var subTitle = "";
    String? image = "";
    artistController.singleSongs!.sort((song1, song2) =>
        song2.dateCreated!.compareTo(song1.dateCreated ?? DateTime.now()));
    artistController.albums!.sort((album1, album2) =>
        album2.dateCreated!.compareTo(album1.dateCreated ?? DateTime.now()));
    var showLatest = false;
    // if((artistController.singleSongs?.isEmpty == true) && )
    if ((artistController.singleSongs?.isEmpty == true) ||
        (artistController.albums?.first.dateCreated?.isAfter(
                artistController.singleSongs?.first.dateCreated ??
                    DateTime.now()) ==
            true)) {
      var latestAlbum = artistController.albums?.first;
      print("latest album ${latestAlbum?.name} , ${latestAlbum?.id}");
      title = latestAlbum?.name ?? "";
      subTitle = "Album";
      image = latestAlbum?.artWork;
    } else if ((artistController.albums?.isEmpty == true) ||
        (artistController.singleSongs?.first.dateCreated?.isAfter(
                artistController.albums?.first.dateCreated ?? DateTime.now()) ==
            true)) {
      var latestSingle = artistController.singleSongs?.first;
      title = latestSingle?.title ?? "";
      subTitle = "Single";
      image = latestSingle?.thumbnailPath;
    }
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomContainer(
          color: Theme.of(context).backgroundColor,
          borderRadius: 10,
          padding: 4,
          child: Stack(
            children: [
              ListTile(
                // contentPadding: const EdgeInsets.only(top: 32),
                leading:
                    CustomImage(image, height: 70, width: 50, roundImage: true),
                title: CustomText(
                  title,
                  fontSize: 20,
                  maxLine: 1,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold,
                ),
                subtitle: CustomText(subTitle, fontSize: 15),

                onTap: () {
                  if (subTitle == "Single") {
                    UIHelper.moveToScreen(SongListScreen.routName,
                        arguments: {
                          "type": SongListDatatype.FROM_PREVIOUS_PAGE,
                          "songs": [artistController.singleSongs!.first]
                        },
                        navigatorId: UIHelper.bottomNavigatorKeyId);
                  } else {
                    UIHelper.moveToScreen(
                        "/album/${artistController.albums!.first.id!}",
                        arguments: {"src": AudioSrcType.NETWORK},
                        navigatorId: UIHelper.bottomNavigatorKeyId);
                  }
                },
              ),
              Positioned.fill(
                right: 8,
                top: 8,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Badge(
                    toAnimate: false,
                    shape: BadgeShape.square,
                    badgeColor: Theme.of(context).primaryColor,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    borderRadius: BorderRadius.circular(8),
                    badgeContent: CustomText(
                      "Latest",
                      textStyle: Theme.of(context).textTheme.caption,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSongCarousel(BuildContext context) {
    return SliverToBoxAdapter(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            CustomCarousel(
              widgets: [
                if (artistController.artistResult?.topSongs?.isNotEmpty == true)
                  SongList(
                    artistController.artistResult?.topSongs!
                        .toSet()
                        .take(5)
                        .toList(),
                    isSliver: false,
                    primary: false,
                    shrinkWrap: true,
                    showAds: false,
                  ),
                if (artistController.singleSongs?.isNotEmpty == true)
                  SongList(
                    artistController.singleSongs!.toSet().take(5).toList(),
                    isSliver: false,
                    primary: false,
                    shrinkWrap: true,
                    showAds: false,
                  )
              ],
              headers: [
                ListHeader(
                  "Top Songs",
                  isSliver: false,
                  bottomPadding: 8,
                  topPadding: 0,
                  showMore: artistController.artistResult?.topSongs!.length
                          .isGreaterThan(2) ==
                      true,
                  onClick: () {
                    UIHelper.moveToScreen(SongListScreen.routName,
                        arguments: {
                          "type": SongListDatatype.FROM_PREVIOUS_PAGE,
                          "songs": artistController.artistResult?.topSongs
                        },
                        navigatorId: UIHelper.bottomNavigatorKeyId);
                  },
                ),
                if (artistController
                        .artistResult?.artist!.singleSongs?.isNotEmpty ==
                    true)
                  ListHeader(
                    "Single Songs",
                    isSliver: false,
                    bottomPadding: 8,
                    topPadding: 0,
                    showMore: artistController
                            .artistResult?.artist!.singleSongs!.length
                            .isGreaterThan(2) ==
                        true,
                    onClick: () {
                      UIHelper.moveToScreen(SongListScreen.routName,
                          arguments: {
                            "type": SongListDatatype.FROM_PREVIOUS_PAGE,
                            "songs": artistController.singleSongs
                          },
                          navigatorId: UIHelper.bottomNavigatorKeyId);
                    },
                  )
              ],
              height: 300,
            ),
            BannerAdWidget(adSize: AdSize.fullBanner)
          ],
        ),
      ),
      // ListHeader("Popular songs", bottomPadding: 16),
      // SongList(artistController.artistResult.topSongs!.take(5).toList()),
    );
  }

  Widget buildRankWidget(ArtistViewmodel artistInfo, BuildContext context) {
    String rank;
    if (artistInfo.rank == 1)
      rank = "st";
    else if (artistInfo.rank == 2)
      rank = "nd";
    else if (artistInfo.rank == 3)
      rank = "rd";
    else {
      rank = "th";
    }

    return CustomContainer(
        margin: 16,
        onTap: () {
          UIHelper.moveToScreen(ArtistStatScreen.routeName,
              arguments: artistInfo,
              navigatorId: UIHelper.bottomNavigatorKeyId);
        },
        color: Theme.of(context).backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText("Rank",
                    textStyle: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: CustomText("${artistInfo.rank}         This month",
                          textStyle: Theme.of(context).textTheme.titleLarge),
                    ),
                    Positioned(
                        left: 24, top: 0, child: CustomText(rank, fontSize: 10))
                  ],
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                UIHelper.moveToScreen(ArtistStatScreen.routeName,
                    navigatorId: UIHelper.bottomNavigatorKeyId);
              },
              icon: const Icon(Icons.arrow_forward_ios, size: 30),
            )
          ],
        ));
  }
}
