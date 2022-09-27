import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/widget/custom_button.dart';
import 'package:zema/widget/custom_container.dart';
import 'package:zema/widget/custom_image.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/custom_text_field.dart';
import 'package:zema/widget/loading_progressbar.dart';

class RegistrationScreen extends StatelessWidget {
  static const routeName = "/register";

  @override
  Widget build(BuildContext context) {
    var phoneNumberController = TextEditingController();
    var userNameController = TextEditingController();
    var completePhoneNumber = "";
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: CustomText(
          "Register",
          color: Colors.black,
        ),
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
                    controller: phoneNumberController,
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
                    controller: userNameController,
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
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
