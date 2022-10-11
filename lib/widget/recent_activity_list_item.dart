import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_image.dart';

class RecentActivityListItem extends StatelessWidget {
  String image;
  double height;
  double width;
  RecentActivityListItem({
    required this.image,
    this.height = 100,
    this.width = 100,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      borderRadius: width / 2,
      child: CustomImage(image),
      height: height,
      width: width,
    );
  }
}
