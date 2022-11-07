import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:zmare/screens/account_onboarding_screen.dart';
import 'package:zmare/screens/main_screen.dart';
import 'package:zmare/screens/onboarding/onboarding_page.dart';
import 'package:zmare/screens/onboarding/select_language_page.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/custom_button.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  static const routName = "/onboarding";

  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);
  var currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (page) {
              _currentPageNotifier.value = page;
              setState(() {
                currentPage = page;
              });
            },
            controller: pageController,
            children: [
              SelectLanguagePage(),
              OnboardingPage(
                  title: AppLocalizations.of(context)!.onboarding_one,
                  image: "assets/images/gospel_music.png",
                  description:
                      AppLocalizations.of(context)!.onboarding_one_desc),
              OnboardingPage(
                  title: AppLocalizations.of(context)!.onboarding_two,
                  image: "assets/images/personalize.jpeg",
                  description:
                      AppLocalizations.of(context)!.onboarding_two_desc),
              OnboardingPage(
                  title: AppLocalizations.of(context)!.onboarding_three,
                  image: "assets/images/offline.jpg",
                  description:
                      AppLocalizations.of(context)!.onboarding_three_desc),
              OnboardingPage(
                  title: AppLocalizations.of(context)!.onboarding_four,
                  image: "assets/images/gospel_music.png",
                  description:
                      AppLocalizations.of(context)!.onboarding_four_desc),
            ],
          ),
          // CustomContainer(
          //     child: Container(),
          //     height: double.infinity,
          //     width: double.infinity,
          //     gradientColor: [Colors.transparent, Colors.black]),
          Positioned.fill(
            left: 16,
            right: 16,
            bottom: 16,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CirclePageIndicator(
                        itemCount: 5,
                        currentPageNotifier: _currentPageNotifier,
                      )),
                  const SizedBox(height: 16),
                  CustomButton(
                    currentPage == 4
                        ? AppLocalizations.of(context)!.sign_in
                        : AppLocalizations.of(context)!.continue_text,
                    buttonType: ButtonType.ROUND_ELEVATED_BUTTON,
                    onPressed: () {
                      if (currentPage == 4) {
                        UIHelper.moveToScreen(AccountOnboardingScreen.routName);
                      } else {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 150),
                            curve: Curves.ease);
                      }
                    },
                  ),
                  currentPage == 4
                      ? CustomButton(
                          AppLocalizations.of(context)!.skip,
                          buttonType: ButtonType.TEXT_BUTTON,
                          onPressed: () {
                            UIHelper.removeBackstackAndmoveToScreen(
                                MainScreen.routName);
                          },
                        )
                      : const SizedBox(height: 16)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
