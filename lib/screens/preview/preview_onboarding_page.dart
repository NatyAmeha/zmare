import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/preview_controller.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/custom_button.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';

class PreviewOnboardingPage extends StatelessWidget {
  static const routeName = "/preview_onboarding";
  PreviewOnboardingPage({super.key});

  var previewController = Get.put(PreviewController());

  @override
  Widget build(BuildContext context) {
    previewController.appController.showPlayerCard(false);
    return Scaffold(
      body: Stack(
        children: [
          CustomImage(
            "assets/images/preview_onboarding.jpg",
            srcLocation: "asset",
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.7,
          ),
          Positioned.fill(
            child: CustomContainer(
              gradientColor: [
                Colors.transparent,
                Theme.of(context).scaffoldBackgroundColor
              ],
              child: Container(),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    "Preview spotlight",
                    textStyle: Theme.of(context).textTheme.displayMedium,
                    alignment: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  CustomText(
                    "Browse new songs, ablums and playlist preivews",
                    textStyle: Theme.of(context).textTheme.displayMedium,
                    alignment: TextAlign.center,
                  ),
                  const SizedBox(height: 80)
                ],
              ),
            ),
          ),
        ],
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: CustomButton(
            "Continue",
            buttonType: ButtonType.ROUND_ELEVATED_BUTTON,
            onPressed: () {
              UIHelper.moveBack();
            },
          ),
        ),
        const SizedBox(height: 80)
      ],
    );
  }
}
