import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zema/widget/custom_text.dart';

class CustomTabView extends StatelessWidget {
  List<Widget> tabs;
  List<Widget> contents;
  bool isSliver;
  double height;

  CustomTabView({
    required this.tabs,
    required this.contents,
    this.height = 400,
    this.isSliver = true,
  });

  @override
  Widget build(BuildContext context) {
    if (isSliver) {
      return SliverToBoxAdapter(
        child: Container(
          child: DefaultTabController(
            initialIndex: 0,
            length: tabs.length,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TabBar(
                  tabs: tabs,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.blue),
                  unselectedLabelColor: Colors.black,
                  isScrollable: true,
                  labelColor: Colors.white,
                ),
                const SizedBox(height: 16),
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
          children: [
            TabBar(
              tabs: tabs,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.blue),
              unselectedLabelColor: Colors.black,
              isScrollable: true,
              labelColor: Colors.white,
            ),
            const SizedBox(height: 16),
            SizedBox(height: height, child: TabBarView(children: contents)),
          ],
        ),
      );
    }
  }
}