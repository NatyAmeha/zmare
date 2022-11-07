import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/modals/album.dart';
import 'package:zmare/modals/exception.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/viewmodels/browse_viewmodel.dart';
import 'package:zmare/widget/album_widget/album_list.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/error_page.dart';
import 'package:zmare/widget/list_header.dart';
import 'package:zmare/widget/playlist_widget/large_playlist_list_item.dart';
import 'package:zmare/widget/playlist_widget/playlist_list.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = "/category";
  Map<String, dynamic>? args;
  CategoryScreen({this.args});

  var appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    var browseInfo = args?["browseInfo"] as BrowseCommand?;
    Future.delayed(Duration.zero, () {
      appController.browseByTags(browseInfo!.tags);
    });

    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => UIHelper.displayContent(
              showWhen: appController.browseByTagResult != null,
              exception: appController.exception,
              isDataLoading: appController.isDataLoading,
              content: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 250,
                    centerTitle: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: CustomText(browseInfo!.name!),
                      expandedTitleScale: 2,
                      collapseMode: CollapseMode.pin,
                      background: CustomContainer(
                        gradientColor: const [Colors.red, Colors.blue],
                        child: Container(),
                      ),
                    ),
                  ),
                  if (appController.browseByTagResult?.playlist?.isNotEmpty ==
                      true) ...[
                    ListHeader("Playlists"),
                    PlaylistList(
                      appController.browseByTagResult?.playlist,
                      listType: PlaylistListType.GRID,
                      isSliver: true,
                      height: 300,
                    ),
                  ]
                ],
              ),
            ),
          ),
          Obx(() {
            if (appController.isEmptyScree.value) {
              return ErrorPage(
                  showIcon: false,
                  exception: AppException(
                      title: "${appController.exception.title}",
                      message: "No Playlist found"));
            } else
              return SizedBox();
          })
        ],
      ),
    );
  }
}
