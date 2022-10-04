import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'custom_image.dart';

class ImageCarousel extends StatefulWidget {
  List<String>? images;
  double height;
  bool autoScroll;
  bool showIndicator;
  bool infiniteScroll;
  int initialPage;
  CarouselController controller;
  List<Widget>? carouselItems;
  Function(int)? onPageChanged;

  ImageCarousel({
    required this.images,
    required this.controller,
    this.height = 400,
    this.autoScroll = true,
    this.showIndicator = true,
    this.infiniteScroll = true,
    this.onPageChanged,
    this.initialPage = 0,
    this.carouselItems,
  });

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: widget.autoScroll,
            aspectRatio: 1 / 1,
            height: widget.height,
            viewportFraction: 1,
            initialPage: widget.initialPage,
            reverse: false,
            enableInfiniteScroll: widget.infiniteScroll,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                selectedPageIndex = index;
                widget.onPageChanged?.call(index);
              });
            },
          ),
          items: widget.images?.isNotEmpty == true
              ? widget.images!
                  .map(
                    (e) => Container(
                      padding: const EdgeInsets.all(1),
                      child: CustomImage(e,
                          fit: BoxFit.fitWidth,
                          height: widget.height,
                          roundImage: true,
                          width: double.infinity),
                    ),
                  )
                  .toList()
              : widget.carouselItems,
          carouselController: widget.controller,
        ),
        if (widget.showIndicator && widget.images?.isNotEmpty == true)
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: carouselIndicator(
                  widget.images!, widget.controller!, selectedPageIndex),
            ),
          )
      ],
    );
  }

  Widget carouselIndicator(
      List<String> imageList, CarouselController controller, int selectedPage) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: imageList
          .map((e) => GestureDetector(
              onTap: () => controller.animateToPage(imageList.indexOf(e)),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (imageList.indexOf(e) == selectedPage
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(
                            imageList.indexOf(e) == selectedPage ? 0.9 : 0.4)),
              )))
          .toList(),
    );
  }
}
