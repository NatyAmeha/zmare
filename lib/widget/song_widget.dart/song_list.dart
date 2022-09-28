import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/widget/song_widget.dart/song_list_item.dart';

class SongList extends StatefulWidget {
  List<Song>? songs;
  bool isSliver;
  bool shrinkWrap;
  bool isReorderable;
  ScrollController? controller;
  Widget? header;
  SongList(this.songs,
      {this.isSliver = true,
      this.controller,
      this.shrinkWrap = false,
      this.isReorderable = false,
      this.header});

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  @override
  Widget build(BuildContext context) {
    return widget.songs?.isNotEmpty == true
        ? widget.isSliver
            ? SliverList(
                delegate: SliverChildBuilderDelegate(
                childCount: widget.songs!.length,
                (context, index) =>
                    SongListItem(index: index, widget.songs![index]),
              ))
            : (widget.isReorderable
                ? ReorderableList(
                    controller: widget.controller,
                    itemCount: widget.header != null
                        ? widget.songs!.length + 1
                        : widget.songs!.length,
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        if (newIndex > oldIndex) newIndex--;
                        var item = widget.songs!.removeAt(oldIndex);
                        widget.songs!.insert(newIndex, item);
                      });
                    },
                    itemBuilder: (context, index) {
                      return SongListItem(
                        key: Key("${index}"),
                        widget.songs![index],
                        showDrag: true,
                        showMore: false,
                      );
                    },
                  )
                : ListView.separated(
                    controller: widget.controller,
                    itemCount: widget.songs!.length,
                    shrinkWrap: widget.shrinkWrap,
                    separatorBuilder: (contexxt, index) =>
                        const SizedBox(height: 0),
                    itemBuilder: (context, index) => SongListItem(
                      index: index,
                      widget.songs![index],
                    ),
                  ))
        : Container();
  }
}
