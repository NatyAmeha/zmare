import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:zema/controller/user_controller.dart';
import 'package:zema/modals/user.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/utils/ui_helper.dart';
import 'package:zema/widget/custom_button.dart';
import 'package:zema/widget/custom_container.dart';
import 'package:zema/widget/custom_image.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/custom_text_field.dart';
import 'package:zema/widget/loading_progressbar.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = "/register";

  var phoneNumberController = TextEditingController();
  var userNameController = TextEditingController();

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    var completePhoneNumber = "";
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            UIHelper.moveBack();
          },
        ),
        title: CustomText("Register", color: Colors.black),
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
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(height: 24),
                  CustomText("Register with your phone",
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
                  const SizedBox(height: 24),
                  CustomTextField(
                    label: "Name",
                    autoFocus: false,
                    controller: widget.userNameController,
                    onchanged: (value) {},
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: LoadingProgressbar(loadingState: false),
              ),
            )
          ],
        ),
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: CustomButton(
            "Register",
            buttonType: ButtonType.NORMAL_ELEVATED_BUTTON,
            onPressed: () async {
              var user = User(
                username: widget.userNameController.text,
                phoneNumber: widget.phoneNumberController.text,
                category: ["GOSPEL"],
              );

              userController.sendCode(user);
            },
          ),
        ),
      ],
    );
  }
}
