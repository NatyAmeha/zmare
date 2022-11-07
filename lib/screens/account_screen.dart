import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nil/nil.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/controller/user_controller.dart';
import 'package:zmare/modals/library.dart';
import 'package:zmare/screens/account_onboarding_screen.dart';
import 'package:zmare/screens/album_list_screen.dart';
import 'package:zmare/screens/album_screen.dart';
import 'package:zmare/screens/artist_list_screen.dart';
import 'package:zmare/screens/download_screen.dart';
import 'package:zmare/screens/playlist_list_screen.dart';
import 'package:zmare/screens/setting_screen.dart';
import 'package:zmare/screens/song_list_screen.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/viewmodels/browse_viewmodel.dart';
import 'package:zmare/widget/ad_widget/banner_ad_widget.dart';
import 'package:zmare/widget/custom_button.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/error_page.dart';
import 'package:zmare/widget/loading_progressbar.dart';
import 'package:zmare/widget/song_widget.dart/category_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountScreen extends StatelessWidget {
  static const routName = "/account";

  var appController = Get.find<AppController>();

  AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (appController.libraryResult == null)
        appController.getAllUserLibrary();
    });
    return Scaffold(
      body: Obx(
        () => UIHelper.displayContent(
          showWhen: true,
          isDataLoading: appController.isDataLoading,
          exception: appController.exception,
          content: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 180,
                title: CustomText(
                  AppLocalizations.of(context)!.my_account,
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {},
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        UIHelper.moveToScreen(SettingScreen.routeName);
                      },
                      icon: const Icon(Icons.settings, size: 25))
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      Positioned.fill(
                        child: CustomContainer(gradientColor: [
                          Colors.blueGrey,
                          Theme.of(context).scaffoldBackgroundColor,
                        ], child: const Nil()),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 32),
                            child: appController.loggedInUser.value.id == null
                                ? Card(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: CustomContainer(
                                        padding: 12,
                                        margin: 0,
                                        color:
                                            Theme.of(context).backgroundColor,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: CustomText(
                                                  AppLocalizations.of(context)!
                                                      .sign_in_description),
                                            ),
                                            CustomButton(
                                                AppLocalizations.of(context)!
                                                    .sign_in,
                                                buttonType: ButtonType
                                                    .ROUND_ELEVATED_BUTTON,
                                                wrapContent: true,
                                                onPressed: () {
                                              UIHelper.moveToScreen(
                                                  AccountOnboardingScreen
                                                      .routName);
                                            })
                                          ],
                                        )),
                                  )
                                : ListTile(
                                    onTap: () {},
                                    minLeadingWidth: 60,
                                    leading: CircleAvatar(
                                      backgroundImage: appController
                                                  .loggedInUserResult
                                                  .profileImagePath !=
                                              null
                                          ? NetworkImage(appController
                                              .loggedInUserResult
                                              .profileImagePath!)
                                          : null,
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                      radius: 30,
                                    ),
                                    title: CustomText(
                                      appController
                                              .loggedInUserResult.username ??
                                          "",
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    subtitle: CustomText(
                                      AppLocalizations.of(context)!
                                          .manage_account,
                                      textStyle:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    trailing:
                                        const Icon(Icons.arrow_forward_ios),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverGrid.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: CategoryListItem(
                      browseInfo: BrowseCommand(
                        name: AppLocalizations.of(context)!.liked_songs,
                        subtitle:
                            "${appController.libraryResult?.likedSong?.length ?? 0}",
                        icon: Icons.favorite,
                      ),
                      onclick: (_) {
                        UIHelper.moveToScreen(SongListScreen.routName,
                            arguments: {
                              "type": SongListDatatype.USER_FAVORITE_SONGS
                            },
                            navigatorId: UIHelper.bottomNavigatorKeyId);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: CategoryListItem(
                      browseInfo: BrowseCommand(
                        name: AppLocalizations.of(context)!.favorite_albums,
                        subtitle:
                            "${appController.libraryResult?.likedAlbums?.length ?? 0}",
                        icon: Icons.album,
                      ),
                      onclick: (_) {
                        UIHelper.moveToScreen(AlbumListScreen.routeName,
                            arguments: {
                              "type": AlbumListDataType.USER_FAVORITE_ALBUM_LIST
                            },
                            navigatorId: UIHelper.bottomNavigatorKeyId);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: CategoryListItem(
                        browseInfo: BrowseCommand(
                          name: AppLocalizations.of(context)!.favorite_artists,
                          subtitle:
                              "${appController.libraryResult?.followedArtists?.length ?? 0}",
                          icon: Icons.playlist_play,
                        ),
                        onclick: (_) {
                          UIHelper.moveToScreen(ArtistListScreen.routeName,
                              arguments: {
                                "type":
                                    ArtistListDataType.USER_FAVORITE_ARTIST_LIST
                              },
                              navigatorId: UIHelper.bottomNavigatorKeyId);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: CategoryListItem(
                      browseInfo: BrowseCommand(
                        name: AppLocalizations.of(context)!.your_playlist,
                        subtitle:
                            "${appController.libraryResult?.likedPlaylist?.length ?? 0}",
                        icon: Icons.playlist_play,
                      ),
                      onclick: (_) {
                        UIHelper.moveToScreen(PlaylistListScreen.routName,
                            arguments: {
                              "type":
                                  PlaylistListDatatype.USER_FAVORITE_PLAYLIST
                            },
                            navigatorId: UIHelper.bottomNavigatorKeyId);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: CategoryListItem(
                      browseInfo: BrowseCommand(
                        name: AppLocalizations.of(context)!.downloads,
                        subtitle: "",
                        icon: Icons.download,
                      ),
                      onclick: (_) {
                        UIHelper.moveToScreen(DownloadScreen.routName,
                            navigatorId: UIHelper.bottomNavigatorKeyId);
                      },
                    ),
                  )
                ],
              ),
              SliverToBoxAdapter(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: BannerAdWidget(adSize: AdSize.leaderboard)))
            ],
          ),
        ),
      ),
    );
  }
}
