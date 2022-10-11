import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/modals/album.dart';
import 'package:zmare/modals/artist.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/screens/search_screen.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/ad_widget/banner_ad_widget.dart';
import 'package:zmare/widget/album_widget/album_list.dart';
import 'package:zmare/widget/artist_widget/artist_list.dart';
import 'package:zmare/widget/circle_tile.dart';
import 'package:zmare/widget/custom_button.dart';
import 'package:zmare/widget/custom_carousel.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_tab_view.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/list_header.dart';
import 'package:zmare/widget/search_widget.dart';
import 'package:zmare/widget/song_widget.dart/category_list.dart';
import 'package:zmare/widget/song_widget.dart/song_list.dart';

class BrowseScreen extends StatelessWidget {
  static const routeName = "/browse/:category";
  BrowseScreen({super.key});

  var appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    var category = "GOSPEL";
    print(
        "Browse screen called ${appController.browseResult.artist?.isNotEmpty}");

    if (appController.browseResult.browseCommand == null) {
      appController.getBrowseResult(category);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CustomText("Browse", color: Colors.black),
      ),
      body: Obx(
        () => UIHelper.displayContent(
          showWhen:
              appController.browseResult.browseCommand?.isNotEmpty == true,
          exception: appController.exception,
          isDataLoading: appController.isDataLoading,
          content: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    CustomContainer(
                      onTap: () {
                        showSearch(
                            context: context, delegate: CustomSearchDeligate());
                      },
                      padding: 16,
                      child: SearchBar(
                          borderRadius: 16,
                          hintText: "Search music, albums and playlist"),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 210,
                      child: Categorylist(
                        browseInfo: appController.browseResult.browseCommand,
                      ),
                    ),
                  ],
                ),
              ),
              CustomTabView(
                height: 380,
                tabs: const [
                  Tab(text: "Top songs"),
                  Tab(text: "New songs"),
                  Tab(text: "Most liked songs"),
                ],
                contents: [
                  CustomTabContent(
                    SongList(
                        appController.browseResult.topSongs?.take(5).toList(),
                        isSliver: false,
                        showAds: false,
                        shrinkWrap: true),
                  ),
                  CustomTabContent(
                    SongList(
                        appController.browseResult.newSongs?.take(5).toList(),
                        isSliver: false,
                        showAds: false,
                        shrinkWrap: true),
                  ),
                  CustomTabContent(
                    SongList(
                      appController.browseResult.likedSongs?.take(5).toList(),
                      isSliver: false,
                      showAds: false,
                      shrinkWrap: true,
                    ),
                  )
                ],
              ),
              showAdWidget(AdSize.largeBanner),
              CustomTabView(
                height: 600,
                tabs: const [
                  Tab(text: "Top Albums"),
                  Tab(text: "New Albums"),
                ],
                contents: [
                  if (appController.browseResult.newAlbum?.isNotEmpty == true)
                    CustomTabContent(
                      AlbumList(
                          appController.browseResult.newAlbum!.take(4).toList(),
                          listType: AlbumListType.ALBUM_GRID_LIST,
                          isSliver: false,
                          height: 220,
                          shrinkWrap: true),
                    ),
                  if (appController.browseResult.popularAlbum?.isNotEmpty ==
                      true)
                    CustomTabContent(
                      AlbumList(
                          appController.browseResult.popularAlbum!
                              .take(4)
                              .toList(),
                          listType: AlbumListType.ALBUM_GRID_LIST,
                          isSliver: false,
                          height: 220,
                          shrinkWrap: true),
                    ),
                ],
              ),
              showAdWidget(AdSize.fullBanner),
              CustomTabView(
                height: 500,
                tabs: const [
                  Tab(text: "Popular artist"),
                  Tab(text: "New Artists "),
                ],
                contents: [
                  if (appController.browseResult.artist?.isNotEmpty == true)
                    CustomTabContent(
                      ArtistList(appController.browseResult.artist!,
                          height: 400,
                          type: ArtistListType.ARTIST_VERTICAL_LIST),
                    ),
                  if (appController.browseResult.artist?.isNotEmpty == true)
                    CustomTabContent(
                      ArtistList(appController.browseResult.artist!,
                          height: 400,
                          type: ArtistListType.ARTIST_VERTICAL_LIST),
                    ),
                ],
              ),
              showAdWidget(AdSize.fullBanner),
              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showAdWidget(AdSize adsize) {
    return SliverToBoxAdapter(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: BannerAdWidget(adSize: adsize)));
  }
}
