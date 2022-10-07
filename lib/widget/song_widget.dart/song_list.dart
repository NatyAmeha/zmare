import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zema/controller/app_controller.dart';
import 'package:zema/modals/song.dart';
import 'package:zema/utils/constants.dart';
import 'package:zema/widget/song_widget.dart/song_list_item.dart';

class SongList extends StatefulWidget {
  List<Song>? songs;
  bool isSliver;
  bool shrinkWrap;
  bool isReorderable;
  ListSelectionState selectionState;

  ScrollController? controller;
  AudioSrcType src;

  Widget? header;
  Function(Song)? onClick;
  Function(Song)? onMoreClicked;
  SongList(
    this.songs, {
    this.isSliver = true,
    this.controller,
    this.shrinkWrap = false,
    this.isReorderable = false,
    this.header,
    this.selectionState = ListSelectionState.SINGLE_SELECTION,
    this.src = AudioSrcType.NETWORK,
    this.onClick,
    this.onMoreClicked,
  });

  var appController = Get.find<AppController>();

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  var selectedSongIds = <String>[];
  @override
  Widget build(BuildContext context) {
    return widget.songs?.isNotEmpty == true
        ? widget.isSliver
            ? StreamBuilder(
                stream: widget.appController.player.queueState,
                builder: (context, snapshot) {
                  return SliverList(
                      delegate: SliverChildBuilderDelegate(
                    childCount: widget.songs!.length,
                    (context, index) => SongListItem(
                      index: index,
                      isSelected:
                          snapshot.data?.current?.id == widget.songs![index].id,
                      widget.songs![index],
                      src: widget.src,
                      onTap: () {
                        widget.onClick?.call(widget.songs![index]) ??
                            widget.appController.startPlayingAudioFile(
                                widget.songs!,
                                index: index,
                                src: widget.src);
                      },
                      onMoreclicked: (Song) {
                        widget.onMoreClicked?.call(Song);
                      },
                    ),
                  ));
                })
            : (widget.isReorderable
                ? StreamBuilder(
                    stream: widget.appController.player.queueState,
                    builder: (context, snapshot) {
                      return ReorderableList(
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
                            isSelected: snapshot.data?.current?.id ==
                                widget.songs![index].id,
                            src: widget.src,
                            onTap: () {
                              widget.onClick?.call(widget.songs![index]) ??
                                  widget.appController.startPlayingAudioFile(
                                      widget.songs!,
                                      index: index,
                                      src: widget.src);
                            },
                            onMoreclicked: (Song) {
                              widget.onMoreClicked?.call(Song);
                            },
                          );
                        },
                      );
                    })
                : StreamBuilder(
                    stream: widget.appController.player.queueState,
                    builder: (context, snapshot) {
                      return ListView.separated(
                        controller: widget.controller,
                        itemCount: widget.songs!.length,
                        shrinkWrap: widget.shrinkWrap,
                        separatorBuilder: (contexxt, index) =>
                            const SizedBox(height: 0),
                        itemBuilder: (context, index) => SongListItem(
                          index: index,
                          widget.songs![index],
                          src: widget.src,
                          selectionState: widget.selectionState,
                          selectedSongIds: selectedSongIds,
                          isSelected: snapshot.data?.current?.id ==
                              widget.songs![index].id,
                          onTap: () {
                            widget.onClick?.call(widget.songs![index]) ??
                                widget.appController.startPlayingAudioFile(
                                    widget.songs!,
                                    index: index,
                                    src: widget.src);
                          },
                          onMoreclicked: (Song) {
                            widget.onMoreClicked?.call(Song);
                          },
                          onMultiSelection: (songInfo) {
                            print("on multi selection called");
                            setState(() {
                              if (widget.selectionState !=
                                  ListSelectionState.MULTI_SELECTION) {
                                widget.selectionState =
                                    ListSelectionState.MULTI_SELECTION;
                              }
                              addOrRemoveSongId(songInfo.id!);
                            });
                          },
                        ),
                      );
                    },
                  ))
        : Container();
  }

  addOrRemoveSongId(String id) {
    if (selectedSongIds.contains(id) == true) {
      selectedSongIds.remove(id);
    } else {
      selectedSongIds.add(id);
    }
    print(selectedSongIds.length);
  }
}
