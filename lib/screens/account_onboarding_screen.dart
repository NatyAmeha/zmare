import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/user_controller.dart';
import 'package:zmare/screens/registration_screen.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/custom_button.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/loading_progressbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountOnboardingScreen extends StatelessWidget {
  static const routName = "/signinoption";

  AccountOnboardingScreen({super.key});

  var userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor));
    return Scaffold(
      body: Stack(
        children: [
          CustomImage(
            "assets/images/offline.jpg",
            height: double.infinity,
            width: double.infinity,
            srcLocation: "assets",
          ),
          CustomContainer(
            height: double.infinity,
            width: double.infinity,
            gradientColor: [
              Colors.transparent,
              Theme.of(context).scaffoldBackgroundColor
            ],
            child: Container(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              CustomImage(
                "assets/images/app_icon.png",
                srcLocation: "asset",
                width: 70,
                height: 70,
              ),
              const SizedBox(height: 16),
              CustomText("Zmare App",
                  textStyle: Theme.of(context).textTheme.headline6,
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              CustomText(
                AppLocalizations.of(context)!.welcome,
                textStyle: Theme.of(context).textTheme.headline6,
                fontSize: 28,
              ),
              const SizedBox(height: 16),
              CustomText(
                AppLocalizations.of(context)!.onboarding_two,
                fontSize: 20,
                textStyle: Theme.of(context).textTheme.bodyLarge,
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: CustomButton(
                    AppLocalizations.of(context)!.continue_with_phone,
                    icon: Icons.phone,
                    textColor: Colors.black,
                    buttonType: ButtonType.ROUND_ELEVATED_BUTTON,
                    onPressed: () {
                  UIHelper.moveToLoginOrRegister();
                }),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: CustomButton(
                    AppLocalizations.of(context)!.continue_with_facebook,
                    icon: Icons.facebook,
                    buttonColor: Colors.blueAccent,
                    buttonType: ButtonType.ROUND_ELEVATED_BUTTON,
                    onPressed: () async {
                  await userController.continueWithFacebook();
                }),
              )
            ],
          ),
          Obx(() =>
              LoadingProgressbar(loadingState: userController.isDataLoading))
        ],
      ),
    );
  }
}
