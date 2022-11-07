import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zmare/widget/custom_container.dart';

import 'custom_text.dart';

class ListHeader extends StatelessWidget {
  bool? isSliver;
  String headerText;
  String? subtitle;
  double topPadding;
  double bottomPadding;
  double startPadding;
  bool showMore;
  Widget? trailing;
  double? fontSize;
  Function? onClick;

  ListHeader(
    this.headerText, {
    this.subtitle,
    this.isSliver = true,
    this.showMore = false,
    this.trailing = const Icon(Icons.arrow_forward),
    this.fontSize = 21,
    this.topPadding = 24,
    this.bottomPadding = 8,
    this.startPadding = 16,
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
                      textStyle: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    if (subtitle != null)
                      CustomText(
                        subtitle!,
                        textStyle: Theme.of(context).textTheme.bodyLarge,
                        maxLine: 1,
                      )
                  ],
                ),
              ),
              if (showMore)
                InkWell(
                    onTap: () {
                      onClick!();
                    },
                    child: trailing),
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(
            left: startPadding,
            top: topPadding,
            bottom: bottomPadding,
            right: startPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  headerText,
                  textStyle: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                if (subtitle != null)
                  CustomText(
                    subtitle!,
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                  )
              ],
            ),
            if (showMore)
              InkWell(
                  onTap: () {
                    onClick!();
                  },
                  child: trailing),
          ],
        ),
      );
    }
  }
}
