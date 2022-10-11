import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zmare/viewmodels/browse_viewmodel.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';

class Categorylist extends StatelessWidget {
  List<BrowseCommand>? browseInfo;
  List<String>? title;
  Categorylist({this.browseInfo, this.title});

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
      itemCount: 11,
      padding: const EdgeInsets.all(8),
      scrollDirection: Axis.horizontal,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 16,
          mainAxisSpacing: 8,
          // mainAxisExtent: 100,
          crossAxisCount: 2,
          childAspectRatio: 0.8),
      itemBuilder: (context, index) => CategoryListItem(
        title:
            browseInfo?.elementAt(index).name ?? title?.elementAt(index) ?? "",
        icon: Icons.dashboard,
        // image: browseInfo?.elementAt(index).imagePath,
        gradientColor: [
          colors[(index % colors.length)],
          colors[((index + 1) % colors.length)]
        ],
      ),
    );
  }
}

class CategoryListItem extends StatelessWidget {
  String? title;
  String? subtitle;
  List<Color>? gradientColor;
  IconData icon;
  String? image;
  Function? onclick;
  CategoryListItem({
    this.title,
    this.subtitle,
    this.gradientColor,
    this.icon = Icons.dashboard,
    this.image,
    this.onclick,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      margin: 0,
      color: Colors.grey[200],
      onTap: () {
        onclick?.call();
      },
      gradientColor: gradientColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: 30),
              if (image != null) CustomImage(image, width: 40, height: 40),
              if (subtitle != null)
                CustomText(subtitle!,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    maxLine: 1,
                    overflow: TextOverflow.ellipsis)
            ],
          ),
          const SizedBox(height: 8),
          CustomText(title ?? "Gospel music",
              fontWeight: FontWeight.bold,
              fontSize: 13,
              alignment: TextAlign.start,
              maxLine: 1,
              overflow: TextOverflow.ellipsis)
        ],
      ),
    );
  }
}
