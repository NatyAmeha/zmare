import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/controller/user_controller.dart';
import 'package:zmare/modals/library.dart';
import 'package:zmare/screens/account_onboarding_screen.dart';
import 'package:zmare/screens/album_list_screen.dart';
import 'package:zmare/screens/album_screen.dart';
import 'package:zmare/screens/artist_list_screen.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/ad_widget/banner_ad_widget.dart';
import 'package:zmare/widget/custom_button.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/error_page.dart';
import 'package:zmare/widget/loading_progressbar.dart';
import 'package:zmare/widget/song_widget.dart/category_list.dart';

class AccountScreen extends StatelessWidget {
  static const routName = "/account";

  var appController = Get.find<AppController>();

  AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (appController.libraryResult == null) appController.getAllUserLibrary();
    return Scaffold(
      body: Obx(
        () => UIHelper.displayContent(
          showWhen: true,
          isDataLoading: appController.isDataLoading,
          exception: appController.exception,
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: CustomText(
                    "Account",
                    color: Colors.black,
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.black),
                    onPressed: () {
                      UIHelper.moveToScreen(AccountOnboardingScreen.routName);
                    },
                  ),
                  backgroundColor: Colors.white,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 32),
                    child: appController.loggedInUser.value.id == null
                        ? CustomContainer(
                            padding: 12,
                            margin: 0,
                            color: Colors.grey[200],
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomText(
                                      "Sign in to personalize your experiance"),
                                ),
                                CustomButton("Sign in",
                                    buttonType:
                                        ButtonType.ROUND_ELEVATED_BUTTON,
                                    wrapContent: true, onPressed: () {
                                  UIHelper.moveToScreen(
                                      AccountOnboardingScreen.routName);
                                })
                              ],
                            ))
                        : ListTile(
                            minLeadingWidth: 60,
                            leading: const CircleAvatar(
                              backgroundImage: NetworkImage(
                                "https://d1csarkz8obe9u.cloudfront.net/themedlandingpages/tlp_hero_album-covers-d12ef0296af80b58363dc0deef077ecc-1552649680.jpg",
                              ),
                              radius: 30,
                            ),
                            title: CustomText(
                                appController.loggedInUserResult.username ?? "",
                                fontSize: 19,
                                fontWeight: FontWeight.bold),
                            subtitle:
                                CustomText("Manage account", fontSize: 13),
                            trailing: const Icon(Icons.arrow_forward_ios),
                          ),
                  ),
                ),
                SliverGrid.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2,
                  children: [
                    CategoryListItem(
                      title: "Liked songs",
                      subtitle:
                          "${appController.libraryResult?.likedSong?.length ?? 0}",
                      icon: Icons.favorite,
                    ),
                    CategoryListItem(
                      title: "Favorite Albums",
                      subtitle:
                          "${appController.libraryResult?.likedAlbums?.length ?? 0}",
                      icon: Icons.album,
                      onclick: () {
                        UIHelper.moveToScreen(AlbumListScreen.routeName,
                            arguments: [
                              AlbumListDataType.USER_FAVORITE_ALBUM_LIST
                            ]);
                      },
                    ),
                    CategoryListItem(
                      title: "Favorite Artists",
                      subtitle:
                          "${appController.libraryResult?.followedArtists?.length ?? 0}",
                      icon: Icons.playlist_play,
                      onclick: () {
                        UIHelper.moveToScreen(
                          ArtistListScreen.routeName,
                          arguments: [
                            ArtistListDataType.USER_FAVORITE_ARTIST_LIST
                          ],
                        );
                      },
                    ),
                    CategoryListItem(
                      title: "Your Playlists",
                      subtitle:
                          "${appController.libraryResult?.likedPlaylist?.length ?? 0}",
                      icon: Icons.playlist_play,
                    ),
                    CategoryListItem(
                      title: "Downloads",
                      subtitle: "12",
                      icon: Icons.download,
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
      ),
    );
  }
}
