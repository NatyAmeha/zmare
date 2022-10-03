import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zema/controller/app_controller.dart';
import 'package:zema/screens/player_screen.dart';
import 'package:zema/utils/ui_helper.dart';
import 'package:zema/widget/custom_image.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/song_widget.dart/play_pause_icon.dart';

class PlayerCard extends StatelessWidget {
  PlayerCard({super.key});

  var appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: appController.player.queueState,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return InkWell(
              onTap: () {
                UIHelper.moveToScreen(PlayerScreen.routeName);
              },
              child: Card(
                elevation: 2,
                margin: const EdgeInsets.all(0),
                child: ListTile(
                  minVerticalPadding: 0,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  leading: CustomImage(
                    snapshot.data?.current?.artUri?.toString(),
                    roundImage: true,
                    width: 50,
                    height: 50,
                  ),
                  title: CustomText(snapshot.data!.current?.title ?? "",
                      fontSize: 15, fontWeight: FontWeight.bold),
                  subtitle: CustomText(snapshot.data!.current?.artist ?? "",
                      fontSize: 12),
                  trailing: PlayPauseIcon(isBuffering: true, size: 40),
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
