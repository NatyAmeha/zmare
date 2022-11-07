import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:zmare/controller/user_controller.dart';
import 'package:zmare/modals/user.dart';
import 'package:zmare/screens/artist_selection_list.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/custom_button.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/custom_text_field.dart';
import 'package:zmare/widget/loading_progressbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = "/register";

  var phoneNumberController = TextEditingController();
  var userNameController = TextEditingController();

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var userController = Get.find<UserController>();
  String completePhoneNumber = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[500],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            UIHelper.moveBack();
          },
        ),
        title: CustomText(AppLocalizations.of(context)!.register),
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
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).scaffoldBackgroundColor
            ],
            child: Container(),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  CustomImage(
                    "assets/images/app_icon.png",
                    srcLocation: "asset",
                    width: 70,
                    height: 70,
                  ),
                  const SizedBox(height: 24),
                  CustomText(AppLocalizations.of(context)!.register_with_phone,
                      textStyle: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 32),
                  IntlPhoneField(
                    autofocus: false,
                    disableLengthCheck: true,
                    controller: widget.phoneNumberController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey,
                      labelText: AppLocalizations.of(context)!.phone_number,
                      border:
                          const OutlineInputBorder(borderSide: BorderSide()),
                    ),
                    initialCountryCode: 'ET',
                    onChanged: (phone) {
                      setState(() {
                        completePhoneNumber = phone.completeNumber;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    label: AppLocalizations.of(context)!.name,
                    autoFocus: false,
                    controller: widget.userNameController,
                    onchanged: (value) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: CustomButton(
                      enabled: widget.userNameController.text.isNotEmpty &&
                          completePhoneNumber.length >= 10,
                      AppLocalizations.of(context)!.register,
                      buttonType: ButtonType.ROUND_ELEVATED_BUTTON,
                      onPressed: () async {
                        var user = User(
                          username: widget.userNameController.text,
                          phoneNumber: completePhoneNumber,
                          category: ["GOSPEL"],
                        );
                        userController.userInfo = user;
                        userController.sendCode(false);
                      },
                    ),
                  ),
                ],
              ),
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
