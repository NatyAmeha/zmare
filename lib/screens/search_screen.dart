import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zema/controller/app_controller.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/utils/ui_helper.dart';
import 'package:zema/viewmodels/search_viewmodel.dart';
import 'package:zema/widget/album_widget/album_list.dart';
import 'package:zema/widget/artist_widget/artist_list.dart';
import 'package:zema/widget/custom_button.dart';
import 'package:zema/widget/custom_tab_bar.dart';
import 'package:zema/widget/custom_tab_view.dart';
import 'package:zema/widget/custom_text.dart';
import 'package:zema/widget/list_header.dart';
import 'package:zema/widget/song_widget.dart/song_list.dart';

class SearchScreen extends StatefulWidget {
  var appController = Get.find<AppController>();
  String query;
  SearchScreen({
    required this.query,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 4, vsync: this);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      widget.appController.getSearchResult(widget.query);
    });

    return Obx(
      () => UIHelper.displayContent(
        showWhen: widget.appController.searhResult.artists?.isNotEmpty == true,
        exception: widget.appController.exception,
        isDataLoading: widget.appController.isDataLoading,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[400],
              controller: _tabController,
              isScrollable: true,
              tabs: const [
                Tab(text: "All"),
                Tab(text: "Songs"),
                Tab(text: "Albums"),
                Tab(text: "Artist")
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Expanded(child: buildAllPage()),
                  Expanded(
                      child: SongList(widget.appController.searhResult.songs,
                          isSliver: false)),
                  Expanded(
                      child: AlbumList(widget.appController.searhResult.albums,
                          isSliver: false)),
                  Expanded(
                      child: ArtistList(
                    widget.appController.searhResult.artists,
                    type: ArtistListType.ARTIST_GRID_LIST,
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAllPage() {
    return CustomScrollView(
      slivers: [
        ListHeader("Songs"),
        SliverToBoxAdapter(
          child: CustomTabContent(
            widget.appController.searhResult.songs?.isNotEmpty == true
                ? SongList(
                    widget.appController.searhResult.songs?.take(5).toList(),
                    isSliver: false,
                    shrinkWrap: true)
                : Center(
                    child: CustomText(
                    "No Album found",
                    color: Colors.black,
                  )),
            trailing: widget.appController.searhResult.songs?.length
                        .isGreaterThan(5) ==
                    true
                ? CustomButton(
                    "See more",
                    textSize: 13,
                    buttonType: ButtonType.TEXT_BUTTON,
                    textColor: Colors.black,
                    onPressed: () {
                      _tabController.index = 1;
                    },
                  )
                : null,
          ),
        ),
        ListHeader("Albums"),
        SliverToBoxAdapter(
          child: CustomTabContent(
            widget.appController.searhResult.albums?.isNotEmpty == true
                ? AlbumList(
                    widget.appController.searhResult.albums?.take(4).toList(),
                    isSliver: false,
                    shrinkWrap: true)
                : Center(child: CustomText("No Album found")),
            trailing: widget.appController.searhResult.albums?.length
                        .isGreaterThan(4) ==
                    true
                ? CustomButton(
                    "See more",
                    textSize: 13,
                    buttonType: ButtonType.TEXT_BUTTON,
                    textColor: Colors.black,
                    onPressed: () {
                      _tabController.index = 2;
                    },
                  )
                : null,
          ),
        ),
        ListHeader("Artists"),
        SliverToBoxAdapter(
          child: CustomTabContent(
            widget.appController.searhResult.artists?.isNotEmpty == true
                ? ArtistList(
                    widget.appController.searhResult.artists?.take(5).toList(),
                    type: ArtistListType.ARTIST_GRID_LIST,
                    shrinkWrap: true,
                  )
                : Center(child: CustomText("No Artist found")),
            trailing: widget.appController.searhResult.artists?.length
                        .isGreaterThan(6) ==
                    true
                ? CustomButton(
                    "See more",
                    textSize: 13,
                    buttonType: ButtonType.TEXT_BUTTON,
                    textColor: Colors.black,
                    onPressed: () {
                      _tabController.index = 3;
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}

class CustomSearchDeligate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
      icon: Icon(Icons.close),
      onPressed: () {
        query = "";
      },
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    var queryText = query;
    return SearchScreen(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
