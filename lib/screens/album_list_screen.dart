import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zema/controller/album_controller.dart';
import 'package:zema/modals/album.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/utils/ui_helper.dart';
import 'package:zema/widget/album_widget/album_list.dart';
import 'package:zema/widget/custom_text.dart';

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
          ? AlbumList(albums, isSliver: false, height: double.infinity)
          : Obx(
              () => UIHelper.displayContent(
                showWhen: true,
                exception: albumController.exception,
                isDataLoading: albumController.isDataLoading,
                content: AlbumList(albumController.albumList, isSliver: false),
              ),
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
