import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zema/widget/list_header.dart';

class CustomCarousel extends StatefulWidget {
  List<Widget>? headers;
  List<Widget> widgets;
  double height;
  CustomCarousel({
    required this.widgets,
    this.headers,
    required this.height,
  });

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  var viewPort = 0.9;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: false,
              enableInfiniteScroll: false,
              padEnds: false,
              viewportFraction: viewPort,
              height: widget.height - 20,
              pageSnapping: true,
              onPageChanged: (index, reason) {
                setState(() {
                  viewPort = index == 0 ? 0.9 : 1;
                });
              },
            ),
            items: widget.widgets
                .asMap()
                .map(
                  (index, e) => MapEntry(
                    index,
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.headers?.isNotEmpty == true)
                          widget.headers![index],
                        const SizedBox(
                          height: 0,
                        ),
                        widget.widgets[index],
                      ],
                    ),
                  ),
                )
                .values
                .toList(),
          )
        ],
      ),
    );
  }
}
