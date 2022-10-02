import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zema/controller/app_controller.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/screens/account_screen.dart';
import 'package:zema/screens/browse_screen.dart';
import 'package:zema/screens/home_screen.dart';
import 'package:zema/widget/custom_image.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/song_widget.dart/play_pause_icon.dart';
import 'package:zema/widget/song_widget.dart/player_card.dart';
import 'package:zema/widget/song_widget.dart/song_list_item.dart';

class MainScreen extends StatefulWidget {
  static const routName = "/";

  MainScreen({super.key});
  var appController = Get.put(AppController());
  var song = Song(title: "Song title name", artistsName: ["Artist name 1"]);

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
            selectPage(),
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
        return AccountScreen();
      default:
        return HomeScreen();
    }
  }
}
