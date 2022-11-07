import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/viewmodels/search_viewmodel.dart';
import 'package:zmare/widget/album_widget/album_list.dart';
import 'package:zmare/widget/artist_widget/artist_list.dart';
import 'package:zmare/widget/custom_button.dart';
import 'package:zmare/widget/custom_tab_bar.dart';
import 'package:zmare/widget/custom_tab_view.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/list_header.dart';
import 'package:zmare/widget/song_widget.dart/song_list.dart';

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
      if (widget.appController.searhResult == null) {
        widget.appController.getSearchResult(widget.query);
      }
    });

    return Obx(
      () => UIHelper.displayContent(
        showWhen: widget.appController.searhResult != null,
        exception: widget.appController.exception,
        isDataLoading: widget.appController.isDataLoading,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TabBar(
              labelColor: Theme.of(context).colorScheme.primary,
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
                      child: SongList(widget.appController.searhResult?.songs,
                          adIndexs: UIHelper.selectAdIndex(
                              widget.appController.searhResult?.songs?.length ??
                                  0),
                          isSliver: false)),
                  Expanded(
                      child: AlbumList(
                    widget.appController.searhResult?.albums,
                    height: 250,
                  )),
                  Expanded(
                      child: ArtistList(
                    widget.appController.searhResult?.artists,
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
            widget.appController.searhResult?.songs?.isNotEmpty == true
                ? SongList(
                    widget.appController.searhResult?.songs?.take(5).toList(),
                    showAds: false,
                    isSliver: false,
                    shrinkWrap: true)
                : Center(
                    child: CustomText(
                    "No Album found",
                    color: Colors.black,
                  )),
            trailing: widget.appController.searhResult?.songs?.length
                        .isGreaterThan(5) ==
                    true
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: CustomButton(
                      "See more songs",
                      textSize: 13,
                      textColor: Colors.black,
                      buttonType: ButtonType.NORMAL_OUTLINED_BUTTON,
                      onPressed: () {
                        _tabController.index = 1;
                      },
                    ),
                  )
                : null,
          ),
        ),
        ListHeader("Albums"),
        SliverToBoxAdapter(
          child: CustomTabContent(
            widget.appController.searhResult?.albums?.isNotEmpty == true
                ? AlbumList(
                    widget.appController.searhResult?.albums?.take(4).toList(),
                    primary: false,
                    height: 250,
                    shrinkWrap: true)
                : Center(child: CustomText("No Album found")),
            trailing: widget.appController.searhResult?.albums?.length
                        .isGreaterThan(4) ==
                    true
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: CustomButton(
                      "See more Albums",
                      textSize: 13,
                      buttonType: ButtonType.NORMAL_OUTLINED_BUTTON,
                      onPressed: () {
                        _tabController.index = 2;
                      },
                    ),
                  )
                : null,
          ),
        ),
        ListHeader("Artists"),
        SliverToBoxAdapter(
          child: CustomTabContent(
            widget.appController.searhResult?.artists?.isNotEmpty == true
                ? ArtistList(
                    widget.appController.searhResult?.artists?.take(5).toList(),
                    type: ArtistListType.ARTIST_GRID_LIST,
                    shrinkWrap: true,
                    primary: false,
                  )
                : Center(child: CustomText("No Artist found")),
            trailing: widget.appController.searhResult?.artists?.length
                        .isGreaterThan(6) ==
                    true
                ? CustomButton(
                    "See more",
                    textSize: 13,
                    buttonType: ButtonType.TEXT_BUTTON,
                    onPressed: () {
                      _tabController.index = 3;
                    },
                  )
                : null,
          ),
        ),
        const SliverToBoxAdapter(child: const SizedBox(height: 80))
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
