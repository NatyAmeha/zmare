import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomImage extends StatelessWidget {
  String? image;
  double width;
  double height;
  String placeholder;
  BoxFit? fit;
  String? srcLocation;
  bool? roundImage;
  double borderRadius;
  CustomImage(this.image,
      {this.width = 100,
      this.height = 100,
      this.placeholder = "assets/images/music_placeholder.png",
      this.fit = BoxFit.cover,
      this.roundImage = false,
      this.borderRadius = 8,
      this.srcLocation = "network"});

  @override
  Widget build(BuildContext context) {
    // load image based from network or asset based on the src variable
    if (srcLocation == "network") {
      return roundImage == true
          ? ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: FadeInImage.assetNetwork(
                image: image ?? placeholder,
                placeholder: placeholder,
                placeholderFit: BoxFit.cover,
                width: width,
                height: height,
                fit: fit,
                imageErrorBuilder: (context, exception, stack) =>
                    Image.asset(placeholder, width: width, height: height),
              ),
            )
          : FadeInImage.assetNetwork(
              image: image ?? placeholder,
              placeholder: placeholder,
              width: width,
              height: height,
              imageErrorBuilder: (context, exception, stack) =>
                  Image.asset(placeholder),
              fit: fit,
            );
    } else {
      return roundImage == true
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                image ?? placeholder,
                width: width,
                height: height,
                fit: fit,
                errorBuilder: (context, error, stackTrace) =>
                    Image.asset(placeholder),
              ))
          : Image.asset(
              image ?? placeholder,
              width: width,
              height: height,
              fit: fit,
              errorBuilder: (context, exception, stack) =>
                  Image.asset(placeholder),
            );
    }
  }
}
