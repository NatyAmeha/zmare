import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zema/widget/custom_container.dart';
import 'package:zema/widget/custom_image.dart';
import 'package:zema/widget/custom_text.dart';

class LargePlaylistTile extends StatelessWidget {
  const LargePlaylistTile({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        width: 200,
        height: 250,
        padding: 0,
        margin: 0,
        borderRadius: 24,
        child: Stack(
          children: [
            CustomImage(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0rXLxvzsiu1TFgCZW1H5j0QKRTW4SA3iUp-2ykco4teeM8GqQBlBpNxu-ikhhlcDafgc&usqp=CAU",
              width: 200,
              height: 250,
              roundImage: true,
            ),
            Positioned.fill(
                left: 0,
                bottom: 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomContainer(
                    borderRadius: 10,
                    padding: 8,
                    borderColor: Colors.transparent,
                    gradientColor: const [Colors.transparent, Colors.grey],
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          "Daily mix",
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        CustomText(
                          "artist 1 - artist 2",
                          fontSize: 12,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.play_circle),
                            const SizedBox(width: 8),
                            CustomText("Now playing", fontSize: 15)
                          ],
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ));
  }
}
