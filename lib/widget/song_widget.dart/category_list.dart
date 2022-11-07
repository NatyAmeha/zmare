import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zmare/viewmodels/browse_viewmodel.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';

class Categorylist extends StatelessWidget {
  List<BrowseCommand> browseInfo;
  List<String>? title;
  Function(BrowseCommand) onselected;
  Categorylist(
      {required this.browseInfo, this.title, required this.onselected});

  var colors = [
    Colors.red,
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.blueGrey,
    Colors.amber,
    Colors.brown,
    Colors.cyanAccent
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: browseInfo.length,
      padding: const EdgeInsets.all(16),
      scrollDirection: Axis.horizontal,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          mainAxisExtent: 120,
          crossAxisCount: 2,
          childAspectRatio: 0.8),
      itemBuilder: (context, index) => CategoryListItem(
        browseInfo: browseInfo[index],
        gradientColor: [
          colors[(index % colors.length)],
          colors[((index + 1) % colors.length)]
        ],
        onclick: (selectedInfo) {
          onselected(selectedInfo);
        },
      ),
    );
  }
}

class CategoryListItem extends StatelessWidget {
  BrowseCommand browseInfo;
  List<Color>? gradientColor;
  Function(BrowseCommand) onclick;
  CategoryListItem({
    required this.browseInfo,
    this.gradientColor,
    required this.onclick,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      margin: 0,
      color: Theme.of(context).backgroundColor,
      onTap: () {
        onclick(browseInfo);
      },
      gradientColor: gradientColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(browseInfo.icon, size: 30),
              if (browseInfo.imagePath != null)
                CustomImage(browseInfo.imagePath, width: 40, height: 40),
              if (browseInfo.subtitle != null)
                CustomText(browseInfo.subtitle!,
                    maxLine: 1, overflow: TextOverflow.ellipsis)
            ],
          ),
          const SizedBox(height: 8),
          CustomText(browseInfo.name ?? "Gospel music",
              textStyle: Theme.of(context).textTheme.titleSmall,
              fontSize: 12,
              alignment: TextAlign.start,
              maxLine: 1,
              overflow: TextOverflow.ellipsis)
        ],
      ),
    );
  }
}
