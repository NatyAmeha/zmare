import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zmare/screens/account_screen.dart';
import 'package:zmare/screens/browse_screen.dart';
import 'package:zmare/screens/home_screen.dart';
import 'package:zmare/screens/local_audio_screen.dart';
import 'package:zmare/utils/route/routes.dart';

class NestedBottomNavigator extends StatelessWidget {
  Key navigatorKey;
  String initialroute;
  NestedBottomNavigator(
      {required this.navigatorKey, required this.initialroute});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: initialroute,
      onGenerateRoute: (settings) {
        print(settings.name);
        if (settings.name == HomeScreen.routName) {
          return GetPageRoute(
            settings: settings,
            routeName: HomeScreen.routName,
            page: () => HomeScreen(),
          );
        } else if (settings.name == BrowseScreen.routeName) {
          return GetPageRoute(
            settings: settings,
            routeName: BrowseScreen.routeName,
            page: () => BrowseScreen(),
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
        } else {
          print("other route");
          return GetPageRoute(
            settings: settings,
            routeName: settings.name,
            page: RouteUtil.routes
                .firstWhere((element) => element.name == settings.name)
                .page,
          );
        }
      },
    );
  }
}
