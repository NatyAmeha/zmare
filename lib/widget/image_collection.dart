import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';

class GridImageCollection extends StatelessWidget {
  List<String> images;
  double width;
  double height;
  GridImageCollection(
    this.images, {
    this.width = double.infinity,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: (images.length == 1)
          ? CustomImage(images[0],
              width: width, height: height, roundImage: true)
          : StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: [
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 2,
                  child: CustomImage(images[0],
                      width: double.infinity,
                      height: double.infinity,
                      roundImage: true),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: images.length == 2 ? 2 : 1,
                  child: CustomImage(images[1],
                      width: double.infinity,
                      height: double.infinity,
                      roundImage: true),
                ),
                StaggeredGridTile.count(
                  crossAxisCellCount: 1,
                  mainAxisCellCount: 1,
                  child: Stack(
                    children: [
                      CustomImage(
                        images[2],
                        width: double.infinity,
                        height: double.infinity,
                        roundImage: true,
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: CustomContainer(
                              width: 60,
                              color: Colors.grey[200],
                              borderRadius: 40,
                              child: CustomText(
                                "+${images.length - 3}",
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}

class CircleImageCollection extends StatelessWidget {
  List<String> image;
  double radius;
  CircleImageCollection({
    required this.image,
    required this.radius,
  });

  double padding = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: image.map(
        (e) {
          var widget = Padding(
            padding: EdgeInsets.only(left: padding),
            child:
                CircleAvatar(radius: radius, backgroundImage: NetworkImage(e)),
          );
          padding += (radius * 2) - radius;
          return widget;
        },
      ).toList(),
    );
  }
}
