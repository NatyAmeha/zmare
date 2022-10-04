import 'package:get/get.dart';
import 'package:zema/screens/account_onboarding_screen.dart';
import 'package:zema/screens/album_list_screen.dart';
import 'package:zema/screens/album_screen.dart';
import 'package:zema/screens/artist_list_screen.dart';
import 'package:zema/screens/artist_screen.dart';
import 'package:zema/screens/browse_screen.dart';
import 'package:zema/screens/category_screen.dart';
import 'package:zema/screens/download_screen.dart';
import 'package:zema/screens/local_audio_screen.dart';
import 'package:zema/screens/login_screen.dart';
import 'package:zema/screens/main_screen.dart';
import 'package:zema/screens/onboarding_screen.dart';
import 'package:zema/screens/player_screen.dart';
import 'package:zema/screens/playlist_screen.dart';
import 'package:zema/screens/registration_screen.dart';
import 'package:zema/screens/song_list_screen.dart';
import 'package:zema/screens/verification_screen.dart';

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
        page: () => AccountOnboardingScreen())
  ];
}
