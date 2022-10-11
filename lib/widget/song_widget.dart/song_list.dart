import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/modals/song.dart';
import 'package:zmare/service/ad/admob_helper.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/widget/ad_widget/banner_ad_widget.dart';
import 'package:zmare/widget/ad_widget/native_ad_widget.dart';
import 'package:zmare/widget/song_widget.dart/song_list_item.dart';

class SongList extends StatefulWidget {
  List<Song>? songs;
  bool isSliver;
  bool shrinkWrap;
  bool isReorderable;
  ListSelectionState selectionState;

  ScrollController? controller;
  AudioSrcType src;
  bool showAds;
  AdSize adSize;
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
    this.showAds = true,
    this.adSize = AdSize.banner,
    this.onClick,
    this.onMoreClicked,
  });

  var appController = Get.find<AppController>();

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  var selectedSongIds = <String>[];
  NativeAd? _nativeAd;
  int firstAdDisplayIndex = 2;
  int get additionalIndex => widget.showAds ? 2 : 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.songs?.length.isGreaterThan(0) == true)
    //   additionalIndex += widget.songs!.length ~/ 10;
    print(additionalIndex);
    return widget.songs?.isNotEmpty == true
        ? widget.isSliver
            ? StreamBuilder(
                stream: widget.appController.player.queueState,
                builder: (context, snapshot) {
                  return SliverList(
                      delegate: SliverChildBuilderDelegate(
                          childCount: widget.songs!.length + additionalIndex,
                          (context, index) {
                    // return Container();
                    return showSongListItem(
                      index,
                      firstAdDisplayIndex,
                      snapshot.data?.current?.id ==
                          widget
                              .songs![
                                  getProperIndex(index, firstAdDisplayIndex)]
                              .id,
                    );
                  }));
                })
            : (widget.isReorderable
                ? StreamBuilder(
                    stream: widget.appController.player.queueState,
                    builder: (context, snapshot) {
                      return ReorderableList(
                        controller: widget.controller,
                        itemCount: widget.header != null
                            ? widget.songs!.length + additionalIndex + 1
                            : widget.songs!.length + additionalIndex,
                        onReorder: (oldIndex, newIndex) {
                          setState(() {
                            if (newIndex > oldIndex) newIndex--;
                            var item = widget.songs!.removeAt(oldIndex);
                            widget.songs!.insert(newIndex, item);
                          });
                        },
                        itemBuilder: (context, index) {
                          return showSongListItem(
                            index,
                            firstAdDisplayIndex,
                            snapshot.data?.current?.id ==
                                widget
                                    .songs![getProperIndex(
                                        index, firstAdDisplayIndex)]
                                    .id,
                          );
                        },
                      );
                    })
                : StreamBuilder(
                    stream: widget.appController.player.queueState,
                    builder: (context, snapshot) {
                      return ListView.separated(
                          controller: widget.controller,
                          itemCount: widget.songs!.length + additionalIndex,
                          shrinkWrap: widget.shrinkWrap,
                          separatorBuilder: (contexxt, index) =>
                              const SizedBox(height: 0),
                          itemBuilder: (context, index) {
                            return showSongListItem(
                              index,
                              firstAdDisplayIndex,
                              snapshot.data?.current?.id ==
                                  widget
                                      .songs![getProperIndex(
                                          index, firstAdDisplayIndex)]
                                      .id,
                            );
                          });
                    },
                  ))
        : Container();
  }

  @override
  dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  var inn = 1;
  int getProperIndex(int index, int adIndex) {
    // var i = index;
    // print("$index");
    // if (i % 10 == 3) {
    //   inn += 1;
    // }
    // // print("$index ${inn}");
    // return index - inn;
    if (index > widget.songs!.length) {
      return index - 2;
    } else if (index > adIndex) {
      return index - 1;
    } else
      return index;
  }

  Widget showSongListItem(int index, int firstAdIndex, bool isSelected) {
    print("index $index");
    if (widget.showAds &&
        (index == firstAdIndex || (index == widget.songs!.length))) {
      print("native ad ${_nativeAd?.factoryId}");
      return BannerAdWidget(
        adSize: widget.adSize,
      );
    } else {
      return SongListItem(
        key: Key("$index"),
        index: getProperIndex(index, firstAdIndex),
        isSelected: isSelected,
        widget.songs![getProperIndex(index, firstAdIndex)],
        src: widget.src,
        onTap: () {
          widget.onClick
                  ?.call(widget.songs![getProperIndex(index, firstAdIndex)]) ??
              widget.appController.startPlayingAudioFile(widget.songs!,
                  index: getProperIndex(index, firstAdIndex), src: widget.src);
        },
        onMoreclicked: (Song) {
          widget.onMoreClicked?.call(Song);
        },
        onMultiSelection: (songInfo) {
          print("on multi selection called");
          setState(() {
            if (widget.selectionState != ListSelectionState.MULTI_SELECTION) {
              widget.selectionState = ListSelectionState.MULTI_SELECTION;
            }
            addOrRemoveSongId(songInfo.id!);
          });
        },
      );
    }
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
