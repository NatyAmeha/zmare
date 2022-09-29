import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/utils/ui_helper.dart';
import 'package:zema/widget/custom_button.dart';
import 'package:zema/widget/custom_image.dart';
import 'package:zema/widget/custom_text.dart';

class VerificationScreen extends StatelessWidget {
  static const routeName = "/verification";
  var submittedCode = "";
  @override
  Widget build(BuildContext context) {
    var title = Get.parameters["title"] ?? "Verify your phone number";
    var subtitle = Get.parameters["subtitle"] ??
        "Code sent to your phone number. Enter the code below";
    var codeLength = int.parse(Get.parameters["code"] ?? '6');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomImage("assets/images/verification.jpg",
                  srcLocation: "assets", width: double.infinity, height: 150),
            ),
            const SizedBox(height: 32),
            CustomText(title, fontSize: 19, fontWeight: FontWeight.bold),
            const SizedBox(height: 16),
            CustomText(subtitle, fontSize: 15),
            const SizedBox(height: 24),
            Card(
              margin: const EdgeInsets.all(0),
              elevation: 10,
              child: Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Pinput(
                      length: codeLength,

                      errorText: "the code is not correct",
                      // androidSmsAutofillMethod:
                      //     AndroidSmsAutofillMethod.smsUserConsentApi,
                      autofocus: true,
                      onCompleted: (result) {
                        submittedCode = result;
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomText("The code  is no correct", color: Colors.red),
                    const SizedBox(height: 32),
                    CustomButton(
                      "Verify",
                      buttonType: ButtonType.NORMAL_ELEVATED_BUTTON,
                      onPressed: () async {
                        UIHelper.moveBack(result: submittedCode);
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
