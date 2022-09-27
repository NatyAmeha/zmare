import 'package:flutter/material.dart';
import 'package:zema/modals/album.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/widget/song_widget.dart/album_list_item.dart';

class AlbumList extends StatelessWidget {
  List<Album> albums;
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
    switch (listType) {
      case AlbumListType.ALBUM_GRID_LIST:
        if (isSliver) {
          return buildSliver();
        } else {
          return buildListview(Axis.vertical);
        }

      case AlbumListType.ALBUM_HORIZONTAL_LIST:
        return buildListview(Axis.horizontal);
    }
  }

  Widget buildListview(Axis direction) {
    return Container(
      height: height,
      child: ListView.builder(
        itemCount: albums.length,
        shrinkWrap: shrinkWrap,
        scrollDirection: direction,
        itemExtent: height,
        itemBuilder: (context, index) =>
            AlbumListItem(albums[index], width: width, height: height),
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
        childCount: albums.length,
        (context, index) =>
            AlbumListItem(albums[index], width: width, height: height),
      ),
    );
  }
}
