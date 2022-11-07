import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:zmare/controller/user_controller.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/custom_button.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/loading_progressbar.dart';

class VerificationScreen extends StatefulWidget {
  static const routeName = "/verification";

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  var submittedCode = "";

  var args = Get.arguments as Map<String, dynamic>;

  var userController = Get.find<UserController>();

  var enableVerifyButton = false;

  @override
  Widget build(BuildContext context) {
    var verificatioId = args["verificationId"] as String;
    var isPreviouslyLoggedIn = args["isLoggedinBefore"] as bool;
    var title = Get.parameters["title"] ?? "Verify your phone number";
    var subtitle = Get.parameters["subtitle"] ??
        "Code sent to your phone number. Enter the code below";
    var codeLength = int.parse(Get.parameters["code"] ?? '6');

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(title: CustomText("Verification")),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Icon(Icons.verified,
                  size: 60, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 32),
              CustomText(title,
                  fontSize: 22,
                  textStyle: Theme.of(context).textTheme.displayMedium,
                  alignment: TextAlign.center),
              const SizedBox(height: 16),
              CustomText(subtitle,
                  textStyle: Theme.of(context).textTheme.bodyLarge,
                  alignment: TextAlign.center),
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
                      const SizedBox(height: 24),
                      Pinput(
                        length: codeLength,
                        autofocus: true,
                        defaultPinTheme: PinTheme(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ).copyWith(
                            textStyle: const TextStyle(color: Colors.white)),
                        onCompleted: (result) {
                          setState(() {
                            enableVerifyButton = result.length >= 5;
                            submittedCode = result;
                          });
                        },
                      ),
                      const SizedBox(height: 32),
                      CustomButton(
                        "Verify",
                        enabled: enableVerifyButton,
                        buttonType: ButtonType.ROUND_ELEVATED_BUTTON,
                        onPressed: () async {
                          userController.verifySmsCode(verificatioId,
                              submittedCode, isPreviouslyLoggedIn);
                        },
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.all(16),
                  child: LoadingProgressbar(
                    loadingState: userController.isDataLoading,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
