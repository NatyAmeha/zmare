import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/widget/custom_button.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/image_collection.dart';

class AlbumPlayListHeader extends StatelessWidget {
  List<String> images;
  String title;
  Widget? subtitle;
  String actionText;
  Function? onActionClick;
  double size;
  AlbumPlayListHeader({
    required this.images,
    required this.title,
    this.subtitle,
    this.size = 300,
    required this.actionText,
    this.onActionClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size + 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GridImageCollection(
            images,
            height: size,
            width: size,
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomText(
              title,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              maxLine: 2,
              alignment: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 16),
          CustomButton(actionText, buttonType: ButtonType.ROUND_ELEVATED_BUTTON,
              onPressed: () {
            onActionClick?.call();
          }),
          if (subtitle != null) ...[
            const SizedBox(height: 16),
            subtitle!,
          ]
        ],
      ),
    );
  }
}
