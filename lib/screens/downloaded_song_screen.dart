import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zema/controller/app_controller.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/song_widget.dart/song_list.dart';

class DownloadedSongScreen extends StatelessWidget {
  static const routename = "/songs_list";
  var appController = Get.find<AppController>();
  DownloadedSongScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var args = Get.arguments as Map<String, dynamic>;
    var title = args["title"] as String;
    var songs = args["songs"] as List<Song>;
    return Scaffold(
      appBar: AppBar(
        title: CustomText(title),
      ),
      body: SongList(songs, isSliver: false, src: AudioSrcType.DOWNLOAD),
    );
  }
}
