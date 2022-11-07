import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/artist_controller.dart';
import 'package:zmare/modals/artist.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/artist_widget/artist_list.dart';
import 'package:zmare/widget/custom_text.dart';

import '../controller/album_controller.dart';

class ArtistListScreen extends StatelessWidget {
  static const routeName = "/artist_list";

  Map<String, dynamic>? args;
  ArtistListScreen({super.key, this.args});

  var artistController = Get.put(ArtistController());
  @override
  Widget build(BuildContext context) {
    // array of AlbumListDatatype , list of Album

    var type = args?["type"] as ArtistListDataType?;
    var artists = args?["artists"] as List<Artist>?;
    if (type != null) {
      Future.delayed(Duration.zero, () {
        getArtistList(type);
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: CustomText("Artists"),
      ),
      body: artists?.isNotEmpty == true
          ? ArtistList(artists, type: ArtistListType.ARTIST_GRID_LIST)
          : Obx(
              () => UIHelper.displayContent(
                showWhen: artistController.artistList != null,
                exception: artistController.exception,
                isDataLoading: artistController.isDataLoading,
                content: ArtistList(artistController.artistList,
                    type: ArtistListType.ARTIST_GRID_LIST),
              ),
            ),
    );
  }

  getArtistList(ArtistListDataType type) {
    switch (type) {
      case ArtistListDataType.USER_FAVORITE_ARTIST_LIST:
        artistController.getUserFavoriteArtists();
        break;

      default:
        break;
    }
  }
}
