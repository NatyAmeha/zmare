import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:zmare/modals/artist.dart';
import 'package:zmare/modals/playlist.dart';
import 'package:zmare/screens/account_screen.dart';
import 'package:zmare/screens/album_list_screen.dart';
import 'package:zmare/screens/album_screen.dart';
import 'package:zmare/screens/artist/artist_stat_screen.dart';
import 'package:zmare/screens/artist/local_aritst_screen.dart';
import 'package:zmare/screens/artist_list_screen.dart';
import 'package:zmare/screens/artist_screen.dart';
import 'package:zmare/screens/browse_screen.dart';
import 'package:zmare/screens/category_screen.dart';
import 'package:zmare/screens/download_screen.dart';
import 'package:zmare/screens/downloaded_song_screen.dart';
import 'package:zmare/screens/home_screen.dart';
import 'package:zmare/screens/local_audio_screen.dart';
import 'package:zmare/screens/playlist_list_screen.dart';
import 'package:zmare/screens/playlist_screen.dart';
import 'package:zmare/screens/preview/preview_onboarding_page.dart';
import 'package:zmare/screens/preview/preview_screen.dart';
import 'package:zmare/screens/song_list_screen.dart';
import 'package:zmare/utils/route/routes.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/viewmodels/artist_viewmodel.dart';

class NestedBottomNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(UIHelper.bottomNavigatorKeyId),
      initialRoute: HomeScreen.routName,
      onGenerateRoute: (settings) {
        print("route name ${settings.name}");

        if (settings.name == HomeScreen.routName) {
          return GetPageRoute(
            settings: settings,
            routeName: HomeScreen.routName,
            page: () => HomeScreen(),
          );
        } else if (settings.name?.contains("/album/") == true) {
          var names = settings.name?.split("/");

          var id = names?[2];
          return GetPageRoute(
            settings: settings,
            routeName: AlbumScreen.routName,
            page: () => AlbumScreen(
              albumId: id!,
              args: settings.arguments as Map<String, dynamic>,
            ),
          );
        } else if (settings.name == BrowseScreen.routeName) {
          return GetPageRoute(
            settings: settings,
            routeName: BrowseScreen.routeName,
            page: () => BrowseScreen(),
          );
        } else if (settings.name == PreviewScreen.routeName) {
          return GetPageRoute(
            settings: settings,
            routeName: PreviewScreen.routeName,
            page: () => PreviewScreen(),
          );
        } else if (settings.name == LocalAudioScreen.routeName) {
          return GetPageRoute(
            settings: settings,
            routeName: LocalAudioScreen.routeName,
            page: () => LocalAudioScreen(),
          );
        } else if (settings.name == AccountScreen.routName) {
          return GetPageRoute(
            settings: settings,
            routeName: AccountScreen.routName,
            page: () => AccountScreen(),
          );
        } else if (settings.name == CategoryScreen.routeName) {
          return GetPageRoute(
            settings: settings,
            routeName: CategoryScreen.routeName,
            page: () => CategoryScreen(
              args: settings.arguments as Map<String, dynamic>,
            ),
          );
        } else if (settings.name?.contains("/artist/") == true) {
          var names = settings.name?.split("/");

          var id = names?[2];
          return GetPageRoute(
            settings: settings,
            routeName: ArtistScreen.routeName,
            page: () => ArtistScreen(artistId: id!),
          );
        } else if (settings.name == ArtistListScreen.routeName) {
          return GetPageRoute(
            settings: settings,
            routeName: ArtistListScreen.routeName,
            page: () => ArtistListScreen(
                args: settings.arguments as Map<String, dynamic>),
          );
        } else if (settings.name == AlbumListScreen.routeName) {
          return GetPageRoute(
            settings: settings,
            routeName: AlbumListScreen.routeName,
            page: () => AlbumListScreen(
              args: settings.arguments as Map<String, dynamic>,
            ),
          );
        } else if (settings.name?.contains("/playlist/") == true) {
          var playlistId = settings.name!.split("/")[2];
          return GetPageRoute(
            settings: settings,
            routeName: PlaylistScreen.routeName,
            page: () => PlaylistScreen(
              playlistId: playlistId,
              playlistInfo: settings.arguments as Playlist?,
            ),
          );
        } else if (settings.name == PlaylistListScreen.routName) {
          return GetPageRoute(
            settings: settings,
            routeName: PlaylistListScreen.routName,
            page: () => PlaylistListScreen(
              args: settings.arguments as Map<String, dynamic>,
            ),
          );
        } else if (settings.name == SongListScreen.routName) {
          return GetPageRoute(
            settings: settings,
            routeName: SongListScreen.routName,
            page: () => SongListScreen(
              args: settings.arguments as Map<String, dynamic>,
            ),
          );
        } else if (settings.name == DownloadScreen.routName) {
          return GetPageRoute(
            settings: settings,
            routeName: DownloadScreen.routName,
            page: () => DownloadScreen(),
          );
        } else if (settings.name == DownloadedSongScreen.routename) {
          return GetPageRoute(
            settings: settings,
            routeName: DownloadedSongScreen.routename,
            page: () => DownloadedSongScreen(
                args: settings.arguments as Map<String, dynamic>),
          );
        } else if (settings.name == ArtistStatScreen.routeName) {
          return GetPageRoute(
            settings: settings,
            routeName: ArtistStatScreen.routeName,
            page: () => ArtistStatScreen(
                artistInfo: settings.arguments as ArtistViewmodel),
          );
        } else if (settings.name == LoccalArtistScreen.routeName) {
          return GetPageRoute(
            settings: settings,
            routeName: LoccalArtistScreen.routeName,
            page: () =>
                LoccalArtistScreen(artistInfo: settings.arguments as Artist),
          );
        } else if (settings.name == PreviewOnboardingPage.routeName) {
          return GetPageRoute(
            settings: settings,
            routeName: PreviewOnboardingPage.routeName,
            page: () => PreviewOnboardingPage(),
          );
        }

        // } else if (settings.name == BrowseScreen.routeName) {
        //   return GetPageRoute(
        //     settings: settings,
        //     routeName: BrowseScreen.routeName,
        //     page: () => BrowseScreen(),
        //   );
        // } else if (settings.name == LocalAudioScreen.routeName) {
        //   return GetPageRoute(
        //     settings: settings,
        //     routeName: LocalAudioScreen.routeName,
        //     page: () => LocalAudioScreen(),
        //   );
        // } else if (settings.name == AccountScreen.routName) {
        //   return GetPageRoute(
        //     settings: settings,
        //     routeName: AccountScreen.routName,
        //     page: () => AccountScreen(),
        //   );
        // } else {
        //   print("other route");
        //   return GetPageRoute(
        //     settings: settings,
        //     routeName: settings.name,
        //     page: RouteUtil.routes
        //         .firstWhere((element) => element.name == settings.name)
        //         .page,
        //   );
        // }
      },
    );
  }
}
