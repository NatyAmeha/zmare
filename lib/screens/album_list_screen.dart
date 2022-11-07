import 'dart:ffi';

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
  Map<String, dynamic>? args;

  AlbumListScreen({this.args});
  var albumController = Get.put(AlbumController());

  @override
  Widget build(BuildContext context) {
    // array of AlbumListDatatype , list of Album

    var type = args?["type"] as AlbumListDataType?;
    var albums = args?["albums"] as List<Album>?;

    getAlbumList(type);
    return Scaffold(
      appBar: AppBar(
        title: CustomText("Albums"),
      ),
      body: albums?.isNotEmpty == true
          ? Column(
              children: [
                BannerAdWidget(adSize: AdSize.banner),
                Expanded(
                    child: AlbumList(
                  albums,
                  height: 250,
                )),
              ],
            )
          : Obx(
              () => UIHelper.displayContent(
                  showWhen: albumController.albumList != null,
                  exception: albumController.exception,
                  isDataLoading: albumController.isDataLoading,
                  content: Column(
                    children: [
                      BannerAdWidget(adSize: AdSize.fullBanner),
                      Expanded(
                        child: AlbumList(
                          albumController.albumList,
                          height: 250,
                        ),
                      ),
                    ],
                  )),
            ),
      persistentFooterButtons: [
        BannerAdWidget(adSize: AdSize.fullBanner),
      ],
    );
  }

  getAlbumList(AlbumListDataType? type) {
    if (type != null) {
      switch (type) {
        case AlbumListDataType.USER_FAVORITE_ALBUM_LIST:
          albumController.getUserFavoriteAlbums();
          break;
        default:
          break;
      }
    }
  }
}
