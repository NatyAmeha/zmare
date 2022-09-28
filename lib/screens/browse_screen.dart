import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zema/controller/app_controller.dart';
import 'package:zema/modals/album.dart';
import 'package:zema/modals/artist.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/screens/search_screen.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/utils/ui_helper.dart';
import 'package:zema/widget/album_widget/album_list.dart';
import 'package:zema/widget/artist_widget/artist_list.dart';
import 'package:zema/widget/circle_tile.dart';
import 'package:zema/widget/custom_button.dart';
import 'package:zema/widget/custom_carousel.dart';
import 'package:zema/widget/custom_container.dart';
import 'package:zema/widget/custom_tab_view.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/list_header.dart';
import 'package:zema/widget/search_widget.dart';
import 'package:zema/widget/song_widget.dart/category_list.dart';
import 'package:zema/widget/song_widget.dart/song_list.dart';

class BrowseScreen extends StatelessWidget {
  static const routeName = "/browse/:category";
  BrowseScreen({super.key});

  var appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    var category = "GOSPEL";
    print(
        "Browse screen called ${appController.browseResult.artist?.isNotEmpty}");

    if (appController.browseResult.browseCommand == null) {
      appController.getBrowseResult(category);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CustomText("Browse", color: Colors.black),
      ),
      body: Obx(
        () => UIHelper.displayContent(
          showWhen:
              appController.browseResult.browseCommand?.isNotEmpty == true,
          exception: appController.exception,
          isLoading: appController.isDataLoading,
          content: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    CustomContainer(
                      onTap: () {
                        showSearch(
                            context: context, delegate: CustomSearchDeligate());
                      },
                      padding: 16,
                      child: SearchBar(
                          borderRadius: 16,
                          hintText: "Search music, albums and playlist"),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 250,
                      child: Categorylist(
                        browseInfo: appController.browseResult.browseCommand,
                      ),
                    ),
                    CustomCarousel(
                      widgets: [
                        SongList(
                            appController.browseResult.topSongs
                                ?.take(4)
                                .toList(),
                            isSliver: false,
                            shrinkWrap: true),
                        SongList(
                            appController.browseResult.newSongs
                                ?.take(4)
                                .toList(),
                            isSliver: false,
                            shrinkWrap: true),
                      ],
                      headers: [
                        ListHeader("Top Songs",
                            isSliver: false, showMore: false),
                        ListHeader(
                          "New Songs",
                          isSliver: false,
                          showMore: false,
                        )
                      ],
                      height: 400,
                    ),
                  ],
                ),
              ),
              CustomTabView(
                height: 500,
                tabs: const [
                  Tab(text: "Top songs"),
                  Tab(text: "New songs"),
                  Tab(text: "Most liked songs"),
                ],
                contents: [
                  CustomTabContent(
                    SongList(
                        appController.browseResult.topSongs?.take(5).toList(),
                        isSliver: false,
                        shrinkWrap: true),
                  ),
                  CustomTabContent(
                    SongList(
                        appController.browseResult.newSongs?.take(5).toList(),
                        isSliver: false,
                        shrinkWrap: true),
                  ),
                  CustomTabContent(
                    SongList(
                      appController.browseResult.likedSongs?.take(5).toList(),
                      isSliver: false,
                      shrinkWrap: true,
                    ),
                  )
                ],
              ),
              CustomTabView(
                height: 600,
                tabs: const [
                  Tab(text: "Top Albums"),
                  Tab(text: "New Albums"),
                ],
                contents: [
                  if (appController.browseResult.newAlbum?.isNotEmpty == true)
                    CustomTabContent(
                      AlbumList(
                          appController.browseResult.newAlbum!.take(4).toList(),
                          listType: AlbumListType.ALBUM_GRID_LIST,
                          isSliver: false,
                          height: 220,
                          shrinkWrap: true),
                    ),
                  if (appController.browseResult.popularAlbum?.isNotEmpty ==
                      true)
                    CustomTabContent(
                      AlbumList(
                          appController.browseResult.popularAlbum!
                              .take(4)
                              .toList(),
                          listType: AlbumListType.ALBUM_GRID_LIST,
                          isSliver: false,
                          height: 220,
                          shrinkWrap: true),
                    ),
                ],
              ),
              CustomTabView(
                height: 500,
                tabs: const [
                  Tab(text: "Popular artist"),
                  Tab(text: "New Artists "),
                ],
                contents: [
                  if (appController.browseResult.artist?.isNotEmpty == true)
                    CustomTabContent(
                      ArtistList(appController.browseResult.artist!,
                          height: 400,
                          type: ArtistListType.ARTIST_VERTICAL_LIST),
                    ),
                  if (appController.browseResult.artist?.isNotEmpty == true)
                    CustomTabContent(
                      ArtistList(appController.browseResult.artist!,
                          height: 400,
                          type: ArtistListType.ARTIST_VERTICAL_LIST),
                    ),
                ],
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              )
            ],
          ),
        ),
      ),
    );
  }
}
