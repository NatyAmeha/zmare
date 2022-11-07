import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/screens/account_onboarding_screen.dart';
import 'package:zmare/screens/artist_screen.dart';
import 'package:zmare/screens/download_screen.dart';
import 'package:zmare/screens/onboarding/onboarding_screen.dart';
import 'package:zmare/screens/playlist_screen.dart';
import 'package:zmare/screens/setting_screen.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/custom_button.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScreenHeaderDart extends StatelessWidget {
  ScreenHeaderDart({super.key});
  var appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(AppLocalizations.of(context)!.welcome,
                      textStyle: Theme.of(context).textTheme.titleMedium,
                      fontSize:
                          appController.loggedInUser.value.username == null
                              ? 22
                              : 15),
                  appController.loggedInUser.value.username != null
                      ? InkWell(
                          onTap: () {
                            UIHelper.moveToScreen(OnboardingScreen.routName);
                          },
                          child: CustomText(
                            appController.loggedInUser.value.username!,
                            textStyle: Theme.of(context).textTheme.titleLarge,
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            UIHelper.moveToScreen(
                                AccountOnboardingScreen.routName);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: CustomText(
                              "Sign in for better experiance",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                ],
              ),
              // const SizedBox(width: 16),
            ],
          ),
          InkWell(
              onTap: () {
                UIHelper.moveToScreen(SettingScreen.routeName);
              },
              child: const Icon(Icons.settings, size: 25)),
        ],
      ),
    );
  }
}
