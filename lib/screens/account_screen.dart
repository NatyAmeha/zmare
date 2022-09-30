import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zema/controller/app_controller.dart';
import 'package:zema/controller/user_controller.dart';
import 'package:zema/modals/library.dart';
import 'package:zema/screens/account_onboarding_screen.dart';
import 'package:zema/screens/album_list_screen.dart';
import 'package:zema/screens/album_screen.dart';
import 'package:zema/screens/artist_list_screen.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/utils/ui_helper.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/error_page.dart';
import 'package:zema/widget/loading_progressbar.dart';
import 'package:zema/widget/song_widget.dart/category_list.dart';

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
                  title: CustomText("Account"),
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
                    child: ListTile(
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
                      subtitle: CustomText("Manage account", fontSize: 13),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
