import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectLanguagePage extends StatefulWidget {
  const SelectLanguagePage({super.key});

  @override
  State<SelectLanguagePage> createState() => _SelectLanguagePageState();
}

class _SelectLanguagePageState extends State<SelectLanguagePage> {
  var selectedLanguageIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomImage(
          "assets/images/gospel_music.png",
          height: double.infinity,
          width: double.infinity,
          srcLocation: "assets",
        ),
        CustomContainer(
          height: double.infinity,
          width: double.infinity,
          gradientColor: const [Colors.transparent, Colors.black],
          child: Container(),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                CustomText(
                  AppLocalizations.of(context)!.select_language,
                  fontSize: 24,
                  alignment: TextAlign.center,
                  textStyle: Theme.of(context).textTheme.titleLarge,
                  color: Colors.white,
                ),
                const SizedBox(height: 40),
                buildLanguageCard(0, "Amharic", false, onSelected: () {
                  setState(() async {
                    selectedLanguageIndex = 0;
                    await UIHelper.changeLanguage(AppLanguage.AMHARIC);
                  });
                }),
                const SizedBox(height: 16),
                buildLanguageCard(1, "English", false, onSelected: () {
                  setState(() async {
                    selectedLanguageIndex = 1;
                    await UIHelper.changeLanguage(AppLanguage.ENGLISH);
                  });
                })
              ]),
        ),
      ],
    );
  }

  Widget buildLanguageCard(int index, String text, bool isSelected,
      {Function? onSelected}) {
    return Card(
      child: CustomContainer(
        onTap: () {
          onSelected?.call();
        },
        borderRadius: 4,
        borderColor: selectedLanguageIndex == index
            ? Theme.of(context).colorScheme.primary
            : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(children: [
            selectedLanguageIndex == index
                ? Icon(
                    Icons.check_circle,
                    size: 30,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : const Icon(Icons.circle_outlined, size: 30),
            const SizedBox(width: 16),
            CustomText(text)
          ]),
        ),
      ),
    );
  }
}
