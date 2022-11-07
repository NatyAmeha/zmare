import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zmare/widget/list_header.dart';

class CustomCarousel extends StatefulWidget {
  List<Widget>? headers;
  List<Widget> widgets;
  double height;

  late double viewPort;
  CustomCarousel({
    required this.widgets,
    this.headers,
    required this.height,
  }) {
    viewPort = widgets.length == 1 ? 1.0 : 0.9;
  }

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: const EdgeInsets.all(0),
      child: CarouselSlider(
          options: CarouselOptions(
            autoPlay: false,
            enableInfiniteScroll: false,
            padEnds: false,
            viewportFraction: widget.viewPort,
            height: widget.height,
            pageSnapping: true,
            onPageChanged: (index, reason) {
              setState(() {
                widget.viewPort = index == 0 ? 0.9 : 1;
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
                      widget.widgets[index],
                    ],
                  ),
                ),
              )
              .values
              .toList()),
    );
  }
}
