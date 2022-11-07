import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/repo/shared_pref_repo.dart';
import 'package:zmare/screens/artist_selection_list.dart';

import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/custom_text.dart';

class SettingScreen extends StatefulWidget {
  static const routeName = "/setting";
  SettingScreen({super.key});

  var appcontroller = Get.find<AppController>();

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText("Settings")),
      body: ListView(children: [
        SettingsGroup(title: "General", children: [
          SelectionSettingTile("display", "Display", Icons.dark_mode,
              {0: "Default", 1: "Light", 2: "Dark"}, 0, (selectedIndex) {
            if (selectedIndex == 0) {
              UIHelper.changeAppTheme(isDarkTheme: null);
            } else if (selectedIndex == 1) {
              UIHelper.changeAppTheme(isDarkTheme: false);
            } else if (selectedIndex == 2) {
              UIHelper.changeAppTheme(isDarkTheme: true);
            }
          }),
          SelectionSettingTile(Constants.LANGUAGE, "Language", Icons.language,
              {0: "English", 1: "አማርኛ"}, 0, (selectedIndex) {
            if (selectedIndex == 0) {
              UIHelper.changeLanguage(AppLanguage.ENGLISH);
            } else {
              UIHelper.changeLanguage(AppLanguage.AMHARIC);
            }
          }),
          simpleSetting("key", "Notification", "Change notificatino setting",
              Icons.notifications, () async {
            await openAppSettings();
          })
        ]),
        SettingsGroup(title: "Playback", children: [
          SwitchSetting(Constants.GAPLESS_pLAYBACK, "Gapless playback",
              Icons.gamepad, false, (p0) async {
            var prefRepo = const SharedPreferenceRepository();
            await prefRepo.create<bool, bool>(Constants.GAPLESS_pLAYBACK, p0);
          }),
          simpleSetting("key", "Improve recommendation",
              "Pick artists and tags you like", Icons.notifications, () async {
            UIHelper.moveToScreen(ArtistSelectionListScreen.routeName);
          })
        ]),
        const SizedBox(height: 16),
        SettingsGroup(title: "Account", children: [
          const SizedBox(height: 16),
          simpleSetting("key", "Logout", "", Icons.logout, () async {
            widget.appcontroller.logout();
          })
        ])
      ]),
    );
  }

  Widget SwitchSetting(String key, String title, IconData leading,
      bool defaultValue, Function(bool) onselected) {
    return SwitchSettingsTile(
      title: title,
      settingKey: key,
      defaultValue: defaultValue,
      leading: Icon(leading),
      onChange: (selectedValue) {
        onselected(selectedValue);
      },
    );
  }

  Widget SelectionSettingTile(String key, String title, IconData leading,
      Map<int, String> options, int defaultValue, Function(int) onSelected) {
    return RadioModalSettingsTile(
        title: title,
        leading: Icon(leading),
        settingKey: key,
        selected: defaultValue,
        values: options,
        onChange: (value) {
          onSelected(value);
        });
  }

  Widget simpleSetting(String key, String title, String subtitle,
      IconData leading, Function onSelected) {
    return SimpleSettingsTile(
      title: title,
      subtitle: subtitle,
      leading: Icon(leading),
      onTap: () {
        onSelected();
      },
    );
  }
}
