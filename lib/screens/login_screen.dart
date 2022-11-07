import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:zmare/modals/user.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/custom_button.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/loading_progressbar.dart';

import '../controller/user_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";
  LoginScreen({super.key});

  var phoneNumberController = TextEditingController();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var userController = Get.find<UserController>();
  String completePhoneNumber = "";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor));
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            UIHelper.moveBack();
          },
        ),
        title: CustomText(AppLocalizations.of(context)!.login),
      ),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                CustomImage(
                  "assets/images/app_icon.png",
                  srcLocation: "asset",
                  width: 90,
                  height: 90,
                ),
                const SizedBox(height: 32),
                CustomText(
                  AppLocalizations.of(context)!.sign_in_with_phone,
                  textStyle: Theme.of(context).textTheme.titleLarge,
                  color: Colors.white,
                ),
                const SizedBox(height: 32),
                IntlPhoneField(
                  autofocus: false,
                  disableLengthCheck: true,
                  controller: widget.phoneNumberController,
                  decoration: InputDecoration(
                    // fillColor: Colors.grey,
                    labelText: AppLocalizations.of(context)!.phone_number,
                    border: const OutlineInputBorder(borderSide: BorderSide()),
                  ),
                  initialCountryCode: 'ET',
                  onChanged: (phone) {
                    completePhoneNumber = phone.completeNumber;
                  },
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: CustomButton(
                    AppLocalizations.of(context)!.login,
                    enabled: completePhoneNumber.length >= 10,
                    buttonType: ButtonType.ROUND_ELEVATED_BUTTON,
                    onPressed: () async {
                      var user = User(
                        phoneNumber: completePhoneNumber,
                      );
                      userController.userInfo = user;
                      // userController.signupWithPhone(true, []);
                      userController.sendCode(true);
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Obx(
                () => LoadingProgressbar(
                    loadingState: userController.isDataLoading),
              ),
            ),
          )
        ],
      ),
    );
  }
}
