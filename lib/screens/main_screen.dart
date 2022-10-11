import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/screens/account_screen.dart';
import 'package:zmare/screens/browse_screen.dart';
import 'package:zmare/screens/home_screen.dart';
import 'package:zmare/screens/local_audio_screen.dart';
import 'package:zmare/widget/bottom_navigator.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/song_widget.dart/play_pause_icon.dart';
import 'package:zmare/widget/song_widget.dart/player_card.dart';
import 'package:zmare/widget/song_widget.dart/song_list_item.dart';

class MainScreen extends StatefulWidget {
  static const routName = "/";

  MainScreen({super.key});
  var appController = Get.put(AppController());
  var song = Song(title: "Song title name", artistsName: ["Artist name 1"]);

  var navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var selectedPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // selectP(),
            selectPage(),
            // displayB(HomeScreen(), 0),
            // displayB(BrowseScreen(), 1),
            // displayB(LocalAudioScreen(), 2),
            // displayB(AccountScreen(), 3),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: PlayerCard(),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Browse"),
          BottomNavigationBarItem(icon: Icon(Icons.storage), label: "Local"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "My Account"),
        ],
        currentIndex: selectedPageIndex,
        elevation: 1,
        iconSize: 30,
        selectedFontSize: 15,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (newIndex) {
          setState(() {
            selectedPageIndex = newIndex;
          });
        },
      ),
    );
  }

  Widget selectPage() {
    switch (selectedPageIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return BrowseScreen();
      case 2:
        return LocalAudioScreen();
      case 3:
        return AccountScreen();
      default:
        return HomeScreen();
    }
  }

  selectP() {
    var pages = [
      displayBody(0, HomeScreen.routName, widget.navigatorKeys[0]),
      displayBody(1, BrowseScreen.routeName, widget.navigatorKeys[1]),
      displayBody(2, LocalAudioScreen.routeName, widget.navigatorKeys[2]),
      displayBody(3, AccountScreen.routName, widget.navigatorKeys[3])
    ];
    return pages[selectedPageIndex];
  }

  Widget displayB(Widget body, int pageIndex) {
    return Offstage(offstage: selectedPageIndex != pageIndex, child: body);
  }

  Widget displayBody(int pageIndex, String initialRoute, Key navigatorKey) {
    return Visibility(
      visible: selectedPageIndex == pageIndex,
      child: NestedBottomNavigator(
          navigatorKey: navigatorKey, initialroute: initialRoute),
    );
  }
}
