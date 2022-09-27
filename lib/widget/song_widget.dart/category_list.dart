import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zema/widget/custom_container.dart';
import 'package:zema/widget/custom_text.dart';

class Categorylist extends StatelessWidget {
  const Categorylist({super.key});

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
              title: "Gospel music",
              icon: Icons.dashboard,
              gradientColor: const [Colors.red, Colors.blue],
            ));
  }
}

class CategoryListItem extends StatelessWidget {
  String? title;
  String? subtitle;
  List<Color>? gradientColor;
  IconData icon;
  CategoryListItem({
    this.title,
    this.subtitle,
    this.gradientColor,
    this.icon = Icons.dashboard,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      margin: 0,
      color: Colors.grey[200],
      onTap: () {},
      gradientColor: gradientColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: 30),
              if (subtitle != null)
                CustomText(subtitle!, fontSize: 17, fontWeight: FontWeight.bold)
            ],
          ),
          const SizedBox(height: 8),
          CustomText(
            title ?? "Gospel music",
            fontWeight: FontWeight.bold,
            fontSize: 13,
            alignment: TextAlign.start,
          )
        ],
      ),
    );
  }
}
