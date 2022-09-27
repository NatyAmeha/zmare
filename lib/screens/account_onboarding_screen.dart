import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/widget/custom_button.dart';
import 'package:zema/widget/custom_image.dart';
import 'package:zema/widget/custom_text.dart';

class AccountOnboardingScreen extends StatelessWidget {
  static const routName = "/onboarding";

  const AccountOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(children: [
          CustomImage(null, width: 100, height: 100),
          const SizedBox(height: 24),
          CustomText("Zema"),
          Spacer(),
          CustomButton("Register",
              buttonType: ButtonType.ROUND_ELEVATED_BUTTON, onPressed: () {}),
          const SizedBox(height: 16),
          CustomButton("Continue with facebook",
              buttonType: ButtonType.ROUND_ELEVATED_BUTTON, onPressed: () {}),
          const SizedBox(height: 16),
          CustomButton("Login",
              buttonType: ButtonType.ROUND_ELEVATED_BUTTON, onPressed: () {}),
        ]),
      ),
    );
  }
}
