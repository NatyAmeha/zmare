import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zmare/widget/custom_tab_bar.dart';
import 'package:zmare/widget/custom_text.dart';

class CustomTabView extends StatelessWidget {
  List<Widget> tabs;
  List<Widget> contents;
  bool isSliver;
  double height;

  CustomTabView({
    required this.tabs,
    required this.contents,
    this.height = double.infinity,
    this.isSliver = true,
  });

  @override
  Widget build(BuildContext context) {
    if (isSliver) {
      return SliverToBoxAdapter(
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: DefaultTabController(
            initialIndex: 0,
            length: tabs.length,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTabbar(tabs),
                // const SizedBox(height: 16),
                SizedBox(
                  height: height,
                  child: TabBarView(children: contents),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return DefaultTabController(
        initialIndex: 0,
        length: tabs.length,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              tabs: tabs,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Theme.of(context).colorScheme.primary),
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
            ),
            const SizedBox(height: 16),
            Expanded(
                // height: height,
                child: TabBarView(children: contents)),
          ],
        ),
      );
    }
  }
}

class CustomTabContent extends StatelessWidget {
  Widget body;
  Widget? trailing;

  CustomTabContent(this.body, {this.trailing});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        body,
        if (trailing != null) trailing!,
      ],
    );
  }
}
