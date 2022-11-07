import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';

class OnboardingPage extends StatelessWidget {
  String image;
  String title;
  String description;
  OnboardingPage(
      {required this.title, required this.image, required this.description});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomImage(
          image,
          height: double.infinity,
          width: double.infinity,
          srcLocation: "assets",
        ),
        CustomContainer(
          height: double.infinity,
          width: double.infinity,
          gradientColor: const [Colors.transparent, Colors.black, Colors.black],
          child: Container(),
        ),
        SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(height: 50),
            CustomText("Zmare",
                textStyle: Theme.of(context).textTheme.headline5,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                alignment: TextAlign.center),
            // SizedBox(height: MediaQuery.of(context).size.height * 0.5),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomText(title,
                  textStyle: Theme.of(context).textTheme.displayMedium,
                  alignment: TextAlign.center),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomText(description,
                  textStyle: Theme.of(context).textTheme.titleLarge,
                  alignment: TextAlign.center),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.4),
          ]),
        ),
      ],
    );
  }
}
