import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/viewmodels/menu_viewmodel.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/song_widget.dart/song_list.dart';

class DownloadedSongScreen extends StatefulWidget {
  static const routename = "/songs_list";
  Map<String, dynamic> args;
  DownloadedSongScreen({super.key, required this.args});

  @override
  State<DownloadedSongScreen> createState() => _DownloadedSongScreenState();
}

class _DownloadedSongScreenState extends State<DownloadedSongScreen> {
  late String title;
  late List<Song> songs;
  var appController = Get.find<AppController>();

  @override
  void initState() {
    title = widget.args["title"] as String;
    songs = widget.args["songs"] as List<Song>;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(title),
      ),
      body: SongList(
        songs,
        isSliver: false,
        src: AudioSrcType.DOWNLOAD,
        showAds: songs.length >= 5,
        adIndexs: UIHelper.selectAdIndex(songs.length),
        onClick: (song, index, selectedAction) {
          if (selectedAction == MenuViewmodel.MENU_TYPE_REMOVE_DOWNLOAD_SONG) {
            setState(() {
              songs.removeWhere((element) => element.id == song.id);
            });
          } else {
            appController.startPlayingAudioFile(songs,
                index: index, src: AudioSrcType.DOWNLOAD);
          }
        },
      ),
    );
  }
}
