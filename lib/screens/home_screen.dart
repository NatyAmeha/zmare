import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/modals/album.dart';
import 'package:zmare/modals/artist.dart';
import 'package:zmare/modals/user.dart';
import 'package:zmare/screens/album_list_screen.dart';
import 'package:zmare/screens/browse_screen.dart';
import 'package:zmare/screens/player_screen.dart';
import 'package:zmare/screens/playlist_list_screen.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/viewmodels/menu_viewmodel.dart';
import 'package:zmare/widget/ad_widget/banner_ad_widget.dart';
import 'package:zmare/widget/album_widget/album_list.dart';
import 'package:zmare/widget/artist_widget/artist_list.dart';
import 'package:zmare/widget/circle_tile.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/error_page.dart';
import 'package:zmare/widget/image_courousel.dart';
import 'package:zmare/widget/list_header.dart';
import 'package:zmare/widget/loading_progressbar.dart';
import 'package:zmare/widget/loading_widget/home_shimmer.dart';
import 'package:zmare/widget/playlist_widget/large_playlist_list_item.dart';
import 'package:zmare/widget/playlist_widget/playlist_list.dart';
import 'package:zmare/widget/screen_header.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../modals/song.dart';

class HomeScreen extends StatelessWidget {
  static const routName = "/home";

  var appController = Get.find<AppController>();

  HomeScreen({super.key});

  var images = [
    "https://i.pinimg.com/736x/8a/b8/7b/8ab87bd6999d659eb282fbed00895d86--last-fm-album-cover.jpg",
    "https://imusician.imgix.net/images/how-to-make-an-album-cover.jpg?auto=compress&w=1200&h=630&fit=crop"
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return UIHelper.displayContent(
            content: buildPage(context),
            showWhen: appController.homeResult != null,
            exception: appController.exception,
            isDataLoading: appController.isDataLoading,
            loadingWidget: const HomeShimmer());
      },
    );
  }

  Widget buildPage(BuildContext context) {
    return CustomScrollView(
      slivers: [
        buildHeader(context),
        if (appController.homeResult?.popularArtist?.isNotEmpty == true) ...[
          ListHeader(AppLocalizations.of(context)!.artist_you_like,
              topPadding: 32),
          SliverToBoxAdapter(
              child: ArtistList(
            appController.homeResult!.popularArtist!,
          )),
        ],
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: BannerAdWidget(
              adSize: AdSize.leaderboard,
            ),
          ),
        ),
        if (appController.albumsCollection?.isNotEmpty == true) ...[
          ListHeader(
            AppLocalizations.of(context)!.recommended_album,
            showMore: (appController.albumsCollection?.length ?? 0) > 6,
            onClick: () {
              UIHelper.moveToScreen(AlbumListScreen.routeName,
                  arguments: {"albums": appController.albumsCollection},
                  navigatorId: UIHelper.bottomNavigatorKeyId);
            },
          ),
          AlbumList(appController.albumsCollection?.take(6).toList(),
              isSliver: true, primary: false, height: 250),
        ],
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: BannerAdWidget(
              adSize: AdSize.leaderboard,
            ),
          ),
        ),
        if (appController.homeResult?.topCharts?.isNotEmpty == true) ...[
          ListHeader(
            AppLocalizations.of(context)!.featured_playlist,
            bottomPadding: 0,
          ),
          SliverToBoxAdapter(
            child: PlaylistList(
              appController.homeResult!.topCharts,
              listType: PlaylistListType.GRID,
              shrinkWrap: true,
              primary: false,
              height: 300,
            ),
          )
        ],
        const SliverToBoxAdapter(child: SizedBox(height: 150))
      ],
    );
  }

  Widget buildHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: CustomContainer(
        padding: 0,
        margin: 0,
        gradientColor: [
          Colors.blueGrey,
          Theme.of(context).scaffoldBackgroundColor,
          Theme.of(context).scaffoldBackgroundColor,
        ],
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ScreenHeaderDart(),
              if (appController.homeResult?.recentActivity?.isNotEmpty == true)
                CircleTileList(
                  image: appController.recentActivityImages,
                  circleRadius: 50,
                  id: appController.homeResult!.recentActivity!
                      .map((e) => e.id ?? "")
                      .toList(),
                  height: 125,
                  onclick: (id, index) {
                    selectRecentActivities(
                        appController.homeResult!.recentActivity![index]);
                  },
                ),
              if (appController.homeResult?.recentActivity?.isNotEmpty == true)
                ListHeader(
                  AppLocalizations.of(context)!.for_you,
                  subtitle: AppLocalizations.of(context)!.made_for_you,
                  bottomPadding: 16,
                  topPadding: 16,
                  isSliver: false,
                  startPadding: 16,
                ),
              PlaylistList(appController.playlistCollection,
                  listType: PlaylistListType.HORIZONTAL),
            ],
          ),
        ),
      ),
    );
  }

  selectRecentActivities(RecentActivity recentActivity) {
    print("clicked ${RecentActivityTypes.PLAYLIST.name}");
    if (recentActivity.type == RecentActivityTypes.ALBUM.name) {
      UIHelper.moveToScreen("/album/${recentActivity.id}",
          arguments: {
            "src": AudioSrcType.NETWORK,
          },
          navigatorId: UIHelper.bottomNavigatorKeyId);
    } else if (recentActivity.type == RecentActivityTypes.ARTIST.name) {
      UIHelper.moveToScreen("/artist/${recentActivity.id}",
          navigatorId: UIHelper.bottomNavigatorKeyId);
    } else if (recentActivity.type == RecentActivityTypes.PLAYLIST.name) {
      print("clicked ${recentActivity.type}");
      UIHelper.moveToScreen(
        "/playlist/${recentActivity.id}",
        navigatorId: UIHelper.bottomNavigatorKeyId,
      );
    }
  }
}
