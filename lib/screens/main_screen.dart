import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/screens/account_screen.dart';
import 'package:zmare/screens/browse_screen.dart';
import 'package:zmare/screens/home_screen.dart';
import 'package:zmare/screens/local_audio_screen.dart';
import 'package:zmare/screens/preview/preview_screen.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/bottom_navigator.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/song_widget.dart/play_pause_icon.dart';
import 'package:zmare/widget/song_widget.dart/player_card.dart';
import 'package:zmare/widget/song_widget.dart/song_list_item.dart';

class MainScreen extends StatelessWidget {
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

  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor));
    return WillPopScope(
      onWillPop: handleSystemBack,
      child: Scaffold(
        body: Stack(
          children: [
            // selectP(),

            // selectPage(),
            // displayB(HomeScreen(), 0),
            // displayB(BrowseScreen(), 1),
            // displayB(LocalAudioScreen(), 2),
            // displayB(AccountScreen(), 3),

            NestedBottomNavigator(),

            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: PlayerCard(),
              ),
            ),
            // const Positioned.fill(
            //   child: Align(
            //     alignment: Alignment.bottomCenter,
            //     child: Divider(
            //       endIndent: 0,
            //       height: 0,
            //     ),
            //   ),
            // )
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            // backgroundColor: Theme.of(context).bottomAppBarColor,

            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.explore), label: "Browse"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.preview), label: "Preview"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.storage), label: "Local"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Account"),
            ],
            currentIndex: appController.selectedBottomPageIndex.value,
            elevation: 5,
            iconSize: 30,
            selectedFontSize: 15,
            type: BottomNavigationBarType.fixed,
            // selectedItemColor: Theme.of(context).primaryColor,
            onTap: (newIndex) {
              // setState(() {
              //   selectedPageIndex = newIndex;
              // });
              selectPage(newIndex);
            },
          ),
        ),
      ),
    );
  }

  Future<bool> handleSystemBack() async {
    var bottomNavigator = Get.nestedKey(UIHelper.bottomNavigatorKeyId);
    if (bottomNavigator?.currentState?.canPop() == true) {
      bottomNavigator!.currentState!.pop(bottomNavigator.currentContext);
      return false;
    } else {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
      return true;
    }
  }

  selectPage(int index) {
    switch (index) {
      case 0:
        UIHelper.removeBackstackAndmoveToScreen(HomeScreen.routName,
            navigatorId: UIHelper.bottomNavigatorKeyId);
        break;
      case 1:
        UIHelper.removeBackstackAndmoveToScreen(BrowseScreen.routeName,
            navigatorId: UIHelper.bottomNavigatorKeyId);
        break;
      case 2:
        UIHelper.removeBackstackAndmoveToScreen(PreviewScreen.routeName,
            navigatorId: UIHelper.bottomNavigatorKeyId);
        break;
      case 3:
        UIHelper.removeBackstackAndmoveToScreen(LocalAudioScreen.routeName,
            navigatorId: UIHelper.bottomNavigatorKeyId);
        break;
      case 4:
        UIHelper.removeBackstackAndmoveToScreen(AccountScreen.routName,
            navigatorId: UIHelper.bottomNavigatorKeyId);
        break;
      default:
        return HomeScreen();
    }
    appController.selectedBottomPageIndex(index);
  }
}
