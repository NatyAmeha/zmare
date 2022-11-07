import 'package:flutter/material.dart';

import 'package:zmare/utils/constants.dart';
import 'package:zmare/widget/custom_text.dart';

class CustomButton extends StatelessWidget {
  ButtonType buttonType;
  String text;
  IconData? icon;
  Color? iconColor;
  Function onPressed;
  bool enabled;

  bool wrapContent;

  double textSize;
  Color? textColor;
  Color? buttonColor;
  CustomButton(this.text,
      {required this.buttonType,
      this.icon,
      this.iconColor,
      this.enabled = true,
      this.wrapContent = false,
      required this.onPressed,
      this.textColor,
      this.buttonColor,
      this.textSize = 14});

  @override
  Widget build(BuildContext context) {
    switch (buttonType) {
      case ButtonType.NORMAL_ELEVATED_BUTTON:
        return ElevatedButton(
          onPressed: enabled
              ? () {
                  onPressed();
                }
              : null,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisSize: wrapContent ? MainAxisSize.min : MainAxisSize.max,
              mainAxisAlignment: icon != null
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: [
                if (icon != null) Icon(icon, color: iconColor),
                // const SizedBox(width: 32),
                CustomText(
                  text,
                  fontSize: textSize,
                ),
                if (icon != null) const SizedBox(width: 16)
              ],
            ),
          ),
        );

      case ButtonType.NORMAL_OUTLINED_BUTTON:
        return OutlinedButton(
            onPressed: enabled
                ? () {
                    onPressed();
                  }
                : null,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisSize: wrapContent ? MainAxisSize.min : MainAxisSize.max,
                mainAxisAlignment: icon != null
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.center,
                children: [
                  if (icon != null) Icon(icon, color: iconColor),
                  CustomText(
                    text,
                    fontSize: textSize,
                  ),
                ],
              ),
            ));

      case ButtonType.TEXT_BUTTON:
        return TextButton(
            onPressed: enabled
                ? () {
                    onPressed();
                  }
                : null,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisSize: wrapContent ? MainAxisSize.min : MainAxisSize.max,
                mainAxisAlignment: icon != null
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.center,
                children: [
                  if (icon != null) Icon(icon, color: iconColor),
                  CustomText(
                    text,
                    fontSize: textSize,
                    color: textColor,
                  ),
                ],
              ),
            ));

      case ButtonType.ROUND_ELEVATED_BUTTON:
        return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
            ),
            onPressed: enabled
                ? () {
                    onPressed();
                  }
                : null,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisSize: wrapContent ? MainAxisSize.min : MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) Icon(icon, color: iconColor),
                  if (icon != null) const SizedBox(width: 16),
                  CustomText(text, fontSize: textSize, color: textColor),
                ],
              ),
            ));

      case ButtonType.ROUND_OUTLINED_BUTTON:
        return OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
            ),
            onPressed: enabled
                ? () {
                    onPressed();
                  }
                : null,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisSize: wrapContent ? MainAxisSize.min : MainAxisSize.max,
                mainAxisAlignment: icon != null
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.center,
                children: [
                  if (icon != null) Icon(icon, color: iconColor),
                  CustomText(
                    text,
                    color: textColor,
                    fontSize: textSize,
                  ),
                ],
              ),
            ));
        ;
      default:
        return TextButton(
            onPressed: enabled
                ? () {
                    onPressed();
                  }
                : null,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisSize: wrapContent ? MainAxisSize.min : MainAxisSize.max,
                mainAxisAlignment: icon != null
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.center,
                children: [
                  if (icon != null) Icon(icon, color: iconColor),
                  CustomText(
                    text,
                    fontSize: textSize,
                  ),
                ],
              ),
            ));
    }
  }
}
