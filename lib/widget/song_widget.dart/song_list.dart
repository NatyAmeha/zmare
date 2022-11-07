import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nil/nil.dart';
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
  bool isDismissable;
  ListSelectionState selectionState;
  Function(Song)? onMutliSelection;
  ScrollController? controller;
  AudioSrcType src;
  bool showAds;
  bool primary;
  AdSize adSize;
  Widget? header;
  List<int> adIndexs;
  List<String> selectedSongIds;
  Function(Song, int, int?)? onClick;
  Function(Song)? onLongClick;
  Function(Song, int)? onDismissed;
  Function(Song)? onMoreClicked;
  SongList(
    this.songs, {
    this.isSliver = true,
    this.controller,
    this.shrinkWrap = false,
    this.isReorderable = false,
    this.isDismissable = false,
    this.header,
    this.primary = true,
    this.selectionState = ListSelectionState.SINGLE_SELECTION,
    this.selectedSongIds = const [],
    this.src = AudioSrcType.NETWORK,
    this.showAds = true,
    this.adIndexs = const [3, 5, 7],
    this.adSize = AdSize.banner,
    this.onClick,
    this.onLongClick,
    this.onDismissed,
    this.onMoreClicked,
  });

  var appController = Get.find<AppController>();

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  NativeAd? _nativeAd;

  int get additionalIndex => widget.showAds ? widget.adIndexs.length : 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.songs?.length.isGreaterThan(0) == true)
    //   additionalIndex += widget.songs!.length ~/ 10;

    return widget.songs?.isNotEmpty == true
        ? StreamBuilder(
            stream: widget.appController.player.queueStateStream,
            builder: (context, snapshot) {
              if (widget.isSliver) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: widget.songs!.length + additionalIndex,
                    (context, index) {
                      // return Container();
                      return showSongListItem(
                        index,
                        snapshot.data?.current?.id ==
                            widget.songs![properIndex(index)].id,
                      );
                    },
                  ),
                );
              } else {
                if (widget.isReorderable) {
                  return ReorderableList(
                    controller: widget.controller,
                    primary: widget.primary,
                    itemCount: widget.header != null
                        ? widget.songs!.length + additionalIndex + 1
                        : widget.songs!.length + additionalIndex,
                    onReorder: (oldIndex, newIndex) {
                      print("reorder called");
                      setState(() {
                        if (newIndex > oldIndex) newIndex--;
                        var item = widget.songs!.removeAt(oldIndex);
                        widget.songs!.insert(newIndex, item);
                      });
                    },
                    itemBuilder: (context, index) {
                      return showSongListItem(
                          index,
                          snapshot.data?.current?.id ==
                              widget.songs![properIndex(index)].id);
                    },
                  );
                } else {
                  return ListView.builder(
                    primary: widget.primary,
                    controller: widget.controller,
                    itemCount: widget.songs!.length + additionalIndex,
                    shrinkWrap: widget.shrinkWrap,
                    itemBuilder: (context, index) {
                      return showSongListItem(
                        index,
                        snapshot.data?.current?.id ==
                            widget.songs![properIndex(index)].id,
                      );
                    },
                  );
                }
              }
            })
        : const Nil();
  }

  @override
  dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  int properIndex(int index) {
    var increment = 0;
    var finalIndex = index;
    if (widget.showAds == false) {
      return finalIndex;
    } else {
      for (var i = 0; i <= widget.adIndexs.length; i++) {
        if (i == widget.adIndexs.length) {
          finalIndex = index - increment;
          break;
        } else {
          if (index < widget.adIndexs[i]) {
            finalIndex = index - increment;
            break;
          } else {
            increment++;
          }
        }
      }
    }

    return finalIndex;
  }

  Widget showSongListItem(int index, bool isSelected) {
    print("index $index");
    if (widget.showAds && (widget.adIndexs.contains(index))) {
      print("native ad ${_nativeAd?.factoryId}");
      return BannerAdWidget(adKey: index.toString(), adSize: widget.adSize);
    } else {
      if (widget.isDismissable) {
        return Dismissible(
          key: UniqueKey(),
          background: Container(color: Colors.red),
          onDismissed: (direction) {
            setState(() {
              widget.songs?.removeAt(properIndex(index));
              widget.onDismissed
                  ?.call(widget.songs![properIndex(index)], properIndex(index));
            });
          },
          child: SongListItem(
            key: ValueKey("$index"),
            index: properIndex(index),
            isSelected: isSelected,
            widget.songs![properIndex(index)],
            selectionState: widget.selectionState,
            selectedSongIds: widget.selectedSongIds,
            src: widget.src,
            showDrag: widget.isReorderable,
            showMore: !widget.isReorderable,
            onTap: (selectedAction) {
              if (widget.onClick != null) {
                print("final index ${properIndex(index)}");
                widget.onClick?.call(widget.songs![properIndex(index)],
                    properIndex(index), selectedAction);
              } else {
                widget.appController.startPlayingAudioFile(widget.songs!,
                    index: properIndex(index), src: widget.src);
              }
            },
            onMoreclicked: (Song) {
              widget.onMoreClicked?.call(Song);
            },
            onLongPress: (songInfo) {
              print("on multi selection called");
              widget.onLongClick?.call(songInfo);
            },
          ),
        );
      } else {
        return SongListItem(
          key: ValueKey("$index"),
          index: properIndex(index),
          isSelected: isSelected,
          widget.songs![properIndex(index)],
          selectionState: widget.selectionState,
          selectedSongIds: widget.selectedSongIds,
          src: widget.src,
          showDrag: widget.isReorderable,
          showMore: !widget.isReorderable,
          onTap: (selectedAction) {
            if (widget.onClick != null) {
              print("final index ${properIndex(index)}");
              widget.onClick?.call(widget.songs![properIndex(index)],
                  properIndex(index), selectedAction);
            } else {
              widget.appController.startPlayingAudioFile(widget.songs!,
                  index: properIndex(index), src: widget.src);
            }
          },
          onMoreclicked: (Song) {
            widget.onMoreClicked?.call(Song);
          },
          onLongPress: (songInfo) {
            print("on multi selection called");
            widget.onLongClick?.call(songInfo);
          },
        );
      }
    }
  }
}
