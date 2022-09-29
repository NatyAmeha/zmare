import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:zema/modals/user.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/utils/ui_helper.dart';
import 'package:zema/widget/custom_button.dart';
import 'package:zema/widget/custom_image.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/loading_progressbar.dart';

import '../controller/user_controller.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";
  LoginScreen({super.key});

  var phoneNumberController = TextEditingController();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            UIHelper.moveBack();
          },
        ),
        title: CustomText("Login", color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomImage(
                    "assets/images/music_placeholder.png",
                    srcLocation: "assets",
                    width: 130,
                    height: 130,
                  ),
                  const SizedBox(height: 24),
                  CustomText("Login with your phone",
                      fontSize: 19, fontWeight: FontWeight.bold),
                  const SizedBox(height: 32),
                  IntlPhoneField(
                    autofocus: false,
                    disableLengthCheck: true,
                    controller: widget.phoneNumberController,
                    decoration: const InputDecoration(
                      fillColor: Colors.grey,
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(borderSide: BorderSide()),
                    ),
                    initialCountryCode: 'ET',
                    onChanged: (phone) {},
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                    "Login",
                    buttonType: ButtonType.NORMAL_ELEVATED_BUTTON,
                    onPressed: () async {
                      var user = User(
                        phoneNumber: widget.phoneNumberController.text,
                      );
                      userController.sendCode(user);
                    },
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: LoadingProgressbar(
                    loadingState: userController.isDataLoading),
              ),
            )
          ],
        ),
      ),
    );
  }
}
