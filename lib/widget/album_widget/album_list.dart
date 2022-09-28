import 'package:flutter/material.dart';
import 'package:zema/modals/album.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/widget/song_widget.dart/album_list_item.dart';

class AlbumList extends StatelessWidget {
  List<Album>? albums;
  AlbumListType listType;
  double width;
  double height;
  bool isSliver;
  bool shrinkWrap;

  AlbumList(
    this.albums, {
    this.listType = AlbumListType.ALBUM_GRID_LIST,
    this.width = double.infinity,
    this.height = 300,
    this.isSliver = true,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    if (albums?.isNotEmpty == true) {
      switch (listType) {
        case AlbumListType.ALBUM_GRID_LIST:
          if (isSliver) {
            return buildSliver();
          } else {
            return GridView.builder(
              itemCount: albums!.length,
              shrinkWrap: shrinkWrap,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  mainAxisExtent: height),
              itemBuilder: (context, index) =>
                  AlbumListItem(albums![index], width: width, height: height),
            );
          }

        case AlbumListType.ALBUM_HORIZONTAL_LIST:
          return buildListview(Axis.horizontal);
      }
    } else {
      return Container();
    }
  }

  Widget buildListview(Axis direction) {
    return Container(
      height: height,
      child: ListView.separated(
        itemCount: albums!.length,
        separatorBuilder: (context, item) => direction == Axis.horizontal
            ? const SizedBox(width: 8)
            : const SizedBox(height: 8),
        shrinkWrap: shrinkWrap,
        scrollDirection: direction,
        padding: const EdgeInsets.all(8),
        // itemExtent: height,
        itemBuilder: (context, index) =>
            AlbumListItem(albums![index], width: width, height: height),
      ),
    );
  }

  Widget buildSliver() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          mainAxisExtent: height),
      delegate: SliverChildBuilderDelegate(
        childCount: albums!.length,
        (context, index) =>
            AlbumListItem(albums![index], width: width, height: height),
      ),
    );
  }
}
