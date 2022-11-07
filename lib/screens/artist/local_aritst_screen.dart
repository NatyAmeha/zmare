import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/artist_controller.dart';
import 'package:zmare/modals/artist.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/song_widget.dart/song_list.dart';

class LoccalArtistScreen extends StatelessWidget {
  static const routeName = "/local_artist";
  Artist artistInfo;
  LoccalArtistScreen({required this.artistInfo});
  var artistController = Get.put(ArtistController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      artistController.getArtistInfoFromLocal(artistInfo);
    });
    return Scaffold(
      appBar: AppBar(title: CustomText(artistInfo.name ?? "")),
      body: Obx(
        () => UIHelper.displayContent(
          showWhen: artistController.localArtistResult != null,
          exception: artistController.exception,
          isDataLoading: artistController.isDataLoading,
          content: SongList(
            artistController.localArtistResult?.singleSongs?.cast<Song>(),
            isSliver: false,
            src: AudioSrcType.LOCAL_STORAGE,
            adIndexs: UIHelper.selectAdIndex(
                artistController.localArtistResult?.singleSongs?.length ?? 0),
          ),
        ),
      ),
    );
  }
}
