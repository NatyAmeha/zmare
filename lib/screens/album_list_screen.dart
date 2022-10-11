import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:zmare/controller/album_controller.dart';
import 'package:zmare/modals/album.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/ad_widget/banner_ad_widget.dart';
import 'package:zmare/widget/album_widget/album_list.dart';
import 'package:zmare/widget/custom_text.dart';

class AlbumListScreen extends StatelessWidget {
  static const routeName = "/album_list";
  var albumController = Get.put(AlbumController());

  AlbumListScreen();

  @override
  Widget build(BuildContext context) {
    // array of AlbumListDatatype , list of Album
    var args = Get.arguments as List<dynamic>;
    var type = args.elementAt(0) as AlbumListDataType;
    var albums = args.length > 1 ? args[1] as List<Album> : null;

    getAlbumList(type);
    return Scaffold(
      appBar: AppBar(
          title: CustomText("Albums", color: Colors.black),
          backgroundColor: Colors.white),
      body: albums?.isNotEmpty == true
          ? Column(
              children: [
                BannerAdWidget(adSize: AdSize.banner),
                Expanded(
                    child: AlbumList(albums,
                        isSliver: false, height: double.infinity)),
              ],
            )
          : Obx(
              () => UIHelper.displayContent(
                  showWhen: true,
                  exception: albumController.exception,
                  isDataLoading: albumController.isDataLoading,
                  content: Column(
                    children: [
                      BannerAdWidget(adSize: AdSize.banner),
                      Expanded(
                        child: AlbumList(albumController.albumList,
                            isSliver: false),
                      ),
                    ],
                  )),
            ),
    );
  }

  getAlbumList(AlbumListDataType type) {
    switch (type) {
      case AlbumListDataType.USER_FAVORITE_ALBUM_LIST:
        albumController.getUserFavoriteAlbums();
        break;
      default:
        break;
    }
  }
}
