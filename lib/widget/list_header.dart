import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zmare/widget/custom_container.dart';

import 'custom_text.dart';

class ListHeader extends StatelessWidget {
  bool? isSliver;
  String headerText;
  String? subtitle;
  String? actionText;
  double topPadding;
  double bottomPadding;
  double startPadding;
  Widget? child;
  bool showMore;
  double? fontSize;
  Function? onClick;

  ListHeader(
    this.headerText, {
    this.subtitle,
    this.isSliver = true,
    this.child,
    this.fontSize = 22,
    this.topPadding = 24,
    this.bottomPadding = 8,
    this.startPadding = 16,
    this.showMore = false,
    this.actionText = "see more",
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    if (isSliver == true) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(
              left: startPadding,
              top: topPadding,
              bottom: bottomPadding,
              right: startPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      headerText,
                      fontSize: fontSize ?? 19,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 4),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: const TextStyle(fontSize: 15),
                        maxLines: 1,
                      )
                  ],
                ),
              ),
              if (showMore)
                CustomContainer(
                  child: CustomText(
                    "See more",
                    fontSize: 13,
                  ),
                )
            ],
          ),
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                headerText,
                fontSize: fontSize ?? 19,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              if (subtitle != null) CustomText(subtitle!, fontSize: 15)
            ],
          ),
          if (showMore)
            InkWell(
              onTap: () {
                onClick!();
              },
              child: child ??
                  Text(
                    actionText!,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.normal),
                  ),
            ),
        ],
      );
    }
  }
}
