import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zema/controller/app_controller.dart';
import 'package:zema/modals/exception.dart';
import 'package:zema/screens/account_onboarding_screen.dart';
import 'package:zema/screens/registration_screen.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/widget/custom_button.dart';
import 'package:zema/widget/custom_text.dart';

class ErrorPage extends StatelessWidget {
  var appController = Get.find<AppController>();

  String title;
  AppException? exception;
  IconData icon;
  String? message;
  String actionText;
  Function? action;

  ErrorPage({
    this.title = "Error occured",
    this.exception,
    this.icon = Icons.error_outline_outlined,
    this.message,
    this.actionText = "try again",
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    String btnText;
    String errorMessage;
    Function onClick;
    switch (exception?.type) {
      case AppException.UNAUTORIZED_EXCEPTION:
        btnText = "Sign in";
        errorMessage = "You need to sign in to continue to the app";
        onClick = () {
          Get.toNamed(AccountOnboardingScreen.routName);
        };
        break;
      case AppException.NOT_FOUND_EXCEPTION:
        btnText = "Go back";
        errorMessage = "Unable to find what you are looking";
        onClick = () {
          Get.back();
        };
        break;
      case AppException.SERVER_EXCEPTION:
        btnText = "Try again";
        errorMessage = "Server error ${exception?.message}";
        onClick = () {
          Get.back();
        };
        break;
      default:
        btnText = actionText;
        errorMessage = message ?? exception?.message ?? "";
        onClick = () {
          action?.call();
        };
        break;
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 100,
          ),
          const SizedBox(
            height: 24,
          ),
          CustomText(
            title,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: CustomText(
              errorMessage,
              alignment: TextAlign.center,
            ),
          ),
          // if (message != null || exception?.message != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
            child: CustomButton(
              btnText,
              buttonType: ButtonType.ROUND_ELEVATED_BUTTON,
              wrapContent: true,
              icon: Icons.try_sms_star,
              onPressed: () {
                onClick();
              },
            ),
          ),
        ],
      ),
    );
  }
}
