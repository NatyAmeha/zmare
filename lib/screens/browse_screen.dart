import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/modals/album.dart';
import 'package:zmare/modals/artist.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/screens/album_list_screen.dart';
import 'package:zmare/screens/artist_list_screen.dart';
import 'package:zmare/screens/category_screen.dart';
import 'package:zmare/screens/search_screen.dart';
import 'package:zmare/screens/setting_screen.dart';
import 'package:zmare/screens/song_list_screen.dart';
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
import 'package:zmare/widget/screen_header.dart';
import 'package:zmare/widget/search_widget.dart';
import 'package:zmare/widget/song_widget.dart/category_list.dart';
import 'package:zmare/widget/song_widget.dart/song_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BrowseScreen extends StatelessWidget {
  static const routeName = "/browse/:category";
  BrowseScreen({super.key});

  var appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    var category = "GOSPEL";

    Future.delayed(Duration.zero, () {
      if (appController.browseResult.browseCommand == null) {
        appController.getBrowseResult();
      }
    });

    return Scaffold(
      body: Obx(
        () => UIHelper.displayContent(
          showWhen:
              appController.browseResult.browseCommand?.isNotEmpty == true,
          exception: appController.exception,
          isDataLoading: appController.isDataLoading,
          content: CustomScrollView(
            primary: true,
            slivers: [
              // SliverToBoxAdapter(
              //   child:
              // ),
              SliverToBoxAdapter(
                child: CustomContainer(
                  padding: 0,
                  gradientColor: [
                    Colors.blueGrey,
                    Theme.of(context).scaffoldBackgroundColor,
                    Theme.of(context).scaffoldBackgroundColor
                  ],
                  child: SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                AppLocalizations.of(context)!.browse,
                                textStyle:
                                    Theme.of(context).textTheme.titleLarge,
                              ),
                              IconButton(
                                  onPressed: () {
                                    UIHelper.moveToScreen(
                                        SettingScreen.routeName);
                                  },
                                  icon: const Icon(Icons.settings))
                            ],
                          ),
                        ),
                        CustomContainer(
                          onTap: () {
                            showSearch(
                                context: context,
                                delegate: CustomSearchDeligate());
                          },
                          padding: 16,
                          child: SearchBar(
                              borderRadius: 16,
                              hintText:
                                  AppLocalizations.of(context)!.search_text),
                        ),
                        // const SizedBox(height: 8),
                        SizedBox(
                          height: 230,
                          child: Categorylist(
                            browseInfo: Constants.browseCommand,
                            onselected: (selectedInfo) {
                              print("onselected");
                              UIHelper.moveToScreen(CategoryScreen.routeName,
                                  arguments: {"browseInfo": selectedInfo},
                                  navigatorId: UIHelper.bottomNavigatorKeyId);
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
              showAdWidget(AdSize.largeBanner),
              CustomTabView(
                height: 430,
                tabs: [
                  Tab(text: AppLocalizations.of(context)!.top_songs),
                  Tab(text: AppLocalizations.of(context)!.new_songs),
                  Tab(text: AppLocalizations.of(context)!.most_liked_song),
                ],
                contents: [
                  CustomTabContent(
                    SongList(
                      appController.browseResult.topSongs?.take(5).toList(),
                      isSliver: false,
                      showAds: false,
                      primary: false,
                      shrinkWrap: true,
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomButton(
                        "See more top songs",
                        textSize: 15,
                        buttonType: ButtonType.NORMAL_OUTLINED_BUTTON,
                        wrapContent: false,
                        onPressed: () {
                          UIHelper.moveToScreen(
                            SongListScreen.routName,
                            arguments: {
                              "type": SongListDatatype.FROM_PREVIOUS_PAGE,
                              "songs": appController.browseResult.topSongs
                            },
                            navigatorId: UIHelper.bottomNavigatorKeyId,
                          );
                        },
                      ),
                    ),
                  ),
                  CustomTabContent(
                    SongList(
                        appController.browseResult.newSongs?.take(5).toList(),
                        isSliver: false,
                        primary: false,
                        showAds: false,
                        shrinkWrap: true),
                    trailing: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomButton(
                        "See more new songs",
                        textSize: 15,
                        buttonType: ButtonType.NORMAL_OUTLINED_BUTTON,
                        wrapContent: false,
                        onPressed: () {
                          UIHelper.moveToScreen(SongListScreen.routName,
                              arguments: {
                                "type": SongListDatatype.FROM_PREVIOUS_PAGE,
                                "songs": appController.browseResult.newSongs
                              },
                              navigatorId: UIHelper.bottomNavigatorKeyId);
                        },
                      ),
                    ),
                  ),
                  CustomTabContent(
                    SongList(
                      appController.browseResult.likedSongs?.take(5).toList(),
                      isSliver: false,
                      showAds: false,
                      primary: false,
                      shrinkWrap: true,
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomButton(
                        "See more songs",
                        textSize: 15,
                        buttonType: ButtonType.NORMAL_OUTLINED_BUTTON,
                        wrapContent: false,
                        onPressed: () {
                          UIHelper.moveToScreen(SongListScreen.routName,
                              arguments: {
                                "type": SongListDatatype.FROM_PREVIOUS_PAGE,
                                "songs": appController.browseResult.likedSongs
                              },
                              navigatorId: UIHelper.bottomNavigatorKeyId);
                        },
                      ),
                    ),
                  )
                ],
              ),

              CustomTabView(
                height: 580,
                tabs: [
                  Tab(text: AppLocalizations.of(context)!.top_albums),
                  Tab(text: AppLocalizations.of(context)!.new_albums),
                ],
                contents: [
                  if (appController.browseResult.newAlbum?.isNotEmpty == true)
                    CustomTabContent(
                      AlbumList(
                          appController.browseResult.newAlbum!.take(4).toList(),
                          listType: AlbumListType.ALBUM_GRID_LIST,
                          primary: false,
                          height: 250,
                          shrinkWrap: true),
                      trailing: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: CustomButton(
                          "See more new albums",
                          textSize: 15,
                          buttonType: ButtonType.NORMAL_OUTLINED_BUTTON,
                          wrapContent: false,
                          onPressed: () {
                            UIHelper.moveToScreen(AlbumListScreen.routeName,
                                arguments: {
                                  "albums": appController.browseResult.newAlbum
                                },
                                navigatorId: UIHelper.bottomNavigatorKeyId);
                          },
                        ),
                      ),
                    ),
                  if (appController.browseResult.popularAlbum?.isNotEmpty ==
                      true)
                    CustomTabContent(
                      AlbumList(
                          appController.browseResult.popularAlbum!
                              .take(4)
                              .toList(),
                          listType: AlbumListType.ALBUM_GRID_LIST,
                          primary: false,
                          height: 220,
                          shrinkWrap: true),
                      trailing: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: CustomButton(
                          "See more",
                          textSize: 15,
                          buttonType: ButtonType.NORMAL_OUTLINED_BUTTON,
                          wrapContent: false,
                          onPressed: () {
                            UIHelper.moveToScreen(AlbumListScreen.routeName,
                                arguments: {
                                  "albums":
                                      appController.browseResult.popularAlbum
                                },
                                navigatorId: UIHelper.bottomNavigatorKeyId);
                          },
                        ),
                      ),
                    ),
                ],
              ),
              showAdWidget(AdSize.fullBanner),
              CustomTabView(
                height: 500,
                tabs: [
                  Tab(text: AppLocalizations.of(context)!.popular_artists),
                  Tab(text: AppLocalizations.of(context)!.new_artists),
                ],
                contents: [
                  if (appController.browseResult.artist?.isNotEmpty == true)
                    CustomTabContent(
                      ArtistList(
                          appController.browseResult.artist!.take(4).toList(),
                          height: 400,
                          primary: false,
                          type: ArtistListType.ARTIST_VERTICAL_LIST),
                      trailing: CustomButton(
                        "See more artists",
                        textSize: 15,
                        buttonType: ButtonType.TEXT_BUTTON,
                        wrapContent: true,
                        onPressed: () {
                          UIHelper.moveToScreen(ArtistListScreen.routeName,
                              arguments: {
                                "artists": appController.browseResult.artist
                              },
                              navigatorId: UIHelper.bottomNavigatorKeyId);
                        },
                      ),
                    ),
                  if (appController.browseResult.artist?.isNotEmpty == true)
                    CustomTabContent(
                      ArtistList(
                          appController.browseResult.artist!.take(4).toList(),
                          height: 400,
                          primary: false,
                          type: ArtistListType.ARTIST_VERTICAL_LIST),
                      trailing: CustomButton(
                        "See more artists",
                        textSize: 15,
                        buttonType: ButtonType.TEXT_BUTTON,
                        wrapContent: true,
                        onPressed: () {
                          UIHelper.moveToScreen(ArtistListScreen.routeName,
                              arguments: {
                                "artists": appController.browseResult.artist
                              },
                              navigatorId: UIHelper.bottomNavigatorKeyId);
                        },
                      ),
                    ),
                ],
              ),

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
