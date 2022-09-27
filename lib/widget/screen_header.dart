import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zema/screens/artist_screen.dart';
import 'package:zema/screens/playlist_screen.dart';
import 'package:zema/widget/custom_text.dart';

class ScreenHeaderDart extends StatelessWidget {
  const ScreenHeaderDart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  Get.toNamed(PlaylistScreen.routeName);
                },
                child: const CircleAvatar(
                  radius: 15,
                  child: Icon(Icons.person, size: 20),
                ),
              ),
              const SizedBox(width: 16),
              CustomText(
                "Welcome Natnael",
                fontSize: 22,
                fontWeight: FontWeight.bold,
              )
            ],
          ),
          InkWell(
              onTap: () {
                Get.toNamed(ArtistScreen.routeName);
              },
              child: const Icon(Icons.settings)),
        ],
      ),
    );
  }
}
