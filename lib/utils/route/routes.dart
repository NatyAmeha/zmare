import 'package:get/get.dart';
import 'package:zmare/screens/account_onboarding_screen.dart';
import 'package:zmare/screens/album_list_screen.dart';
import 'package:zmare/screens/album_screen.dart';
import 'package:zmare/screens/artist_list_screen.dart';
import 'package:zmare/screens/artist_screen.dart';
import 'package:zmare/screens/artist_selection_list.dart';
import 'package:zmare/screens/browse_screen.dart';
import 'package:zmare/screens/category_screen.dart';
import 'package:zmare/screens/downloaded_song_screen.dart';
import 'package:zmare/screens/download_screen.dart';
import 'package:zmare/screens/local_audio_screen.dart';
import 'package:zmare/screens/login_screen.dart';
import 'package:zmare/screens/main_screen.dart';
import 'package:zmare/screens/onboarding_screen.dart';
import 'package:zmare/screens/player_screen.dart';
import 'package:zmare/screens/playlist_screen.dart';
import 'package:zmare/screens/registration_screen.dart';
import 'package:zmare/screens/song_list_screen.dart';
import 'package:zmare/screens/verification_screen.dart';

class RouteUtil {
  static List<GetPage> routes = [
    GetPage(name: MainScreen.routName, page: () => MainScreen()),
    GetPage(name: LocalAudioScreen.routeName, page: () => LocalAudioScreen()),
    GetPage(
        name: PlayerScreen.routeName,
        page: () => PlayerScreen(),
        transition: Transition.downToUp),
    GetPage(name: ArtistScreen.routeName, page: () => ArtistScreen()),
    GetPage(name: PlaylistScreen.routeName, page: () => PlaylistScreen()),
    GetPage(name: BrowseScreen.routeName, page: () => BrowseScreen()),
    GetPage(
        name: CategoryScreen.routeName,
        page: () => CategoryScreen("Category Name")),
    GetPage(name: DownloadScreen.routName, page: () => DownloadScreen()),
    GetPage(
        name: DownloadedSongScreen.routename,
        page: () => DownloadedSongScreen()),
    GetPage(name: SongListScreen.routName, page: () => SongListScreen()),
    GetPage(name: AlbumScreen.routName, page: () => AlbumScreen()),
    GetPage(name: LoginScreen.routeName, page: () => LoginScreen()),
    GetPage(name: AlbumListScreen.routeName, page: () => AlbumListScreen()),
    GetPage(name: ArtistListScreen.routeName, page: () => ArtistListScreen()),
    GetPage(
        name: RegistrationScreen.routeName, page: () => RegistrationScreen()),
    GetPage(
        name: VerificationScreen.routeName, page: () => VerificationScreen()),
    GetPage(name: OnboardingScreen.routName, page: () => OnboardingScreen()),
    GetPage(
        name: AccountOnboardingScreen.routName,
        page: () => AccountOnboardingScreen()),
    GetPage(
        name: ArtistSelectionListScreen.routeName,
        page: () => ArtistSelectionListScreen())
  ];
}
