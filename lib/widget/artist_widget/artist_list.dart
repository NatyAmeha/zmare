import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/artist_controller.dart';
import 'package:zmare/modals/artist.dart';
import 'package:zmare/screens/artist/local_aritst_screen.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/circle_tile.dart';
import 'package:zmare/widget/custom_button.dart';

class ArtistList extends StatefulWidget {
  List<Artist>? artistList;
  double height;
  ArtistListType type;
  bool shrinkWrap;
  AudioSrcType src;
  bool primary;
  ListSelectionState selectionState;
  ArtistList(
    this.artistList, {
    this.type = ArtistListType.ARTIST_HORIZONTAL_LIST,
    this.shrinkWrap = false,
    this.height = 200,
    this.primary = true,
    this.src = AudioSrcType.NETWORK,
    this.selectionState = ListSelectionState.SINGLE_SELECTION,
  });

  var artistController = Get.put(ArtistController());

  @override
  State<ArtistList> createState() => _ArtistListState();
}

class _ArtistListState extends State<ArtistList> {
  var selectedArtistId = <String>[];
  @override
  Widget build(BuildContext context) {
    if (widget.artistList?.isNotEmpty == true) {
      if (widget.type == ArtistListType.ARTIST_HORIZONTAL_LIST) {
        return SizedBox(
          height: widget.height,
          child: ListView.separated(
            primary: widget.primary,
            itemCount: widget.artistList!.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) => CircleTile(
              id: widget.artistList![index].id ?? "",
              src: widget.src,
              image: widget.artistList![index].profileImagePath!.elementAt(0),
              text: widget.artistList![index].name,
              radius: 70,
              onClick: () {
                if (widget.src == AudioSrcType.LOCAL_STORAGE) {
                  UIHelper.moveToScreen(LoccalArtistScreen.routeName,
                      arguments: widget.artistList![index],
                      navigatorId: UIHelper.bottomNavigatorKeyId);
                } else {
                  UIHelper.moveToScreen(
                      "/artist/${widget.artistList![index].id}",
                      navigatorId: UIHelper.bottomNavigatorKeyId);
                }
              },
            ),
          ),
        );
      } else if (widget.type == ArtistListType.ARTIST_GRID_LIST) {
        return GridView.builder(
          primary: widget.primary,
          itemCount: widget.artistList!.length,
          shrinkWrap: widget.shrinkWrap,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 170,
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8),
          itemBuilder: (context, index) => CircleTile(
            id: widget.artistList![index].id ?? "",
            image: widget.artistList![index].profileImagePath?.elementAt(0),
            text: widget.artistList![index].name,
            radius: 60,
            height: 160,
            selectionState: widget.selectionState,
            selectedArtistIds: selectedArtistId,
            src: widget.src,
            onClick: () {
              if (widget.src == AudioSrcType.LOCAL_STORAGE) {
                UIHelper.moveToScreen(LoccalArtistScreen.routeName,
                    arguments: widget.artistList![index],
                    navigatorId: UIHelper.bottomNavigatorKeyId);
              } else {
                UIHelper.moveToScreen("/artist/${widget.artistList![index].id}",
                    navigatorId: UIHelper.bottomNavigatorKeyId);
              }
            },
            onMultiSelection: (artistId) {
              setState(() {
                if (widget.selectionState !=
                    ListSelectionState.MULTI_SELECTION) {
                  widget.selectionState = ListSelectionState.MULTI_SELECTION;
                }
                addOrRemoveSongId(artistId);
              });
            },
          ),
        );
      } else {
        return SizedBox(
          height: widget.height,
          child: ListView.builder(
            primary: widget.primary,
            itemCount: widget.artistList!.length,
            // separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemExtent: 100,
            itemBuilder: (context, index) => CircleVerticalListTile(
              image: widget.artistList![index].profileImagePath!.elementAt(0),
              text: widget.artistList![index].name,
              subtitle: "${widget.artistList![index].followersCount} followers",
              radius: 40,
              trailing: CustomButton(
                "Follow",
                textSize: 12,
                wrapContent: true,
                buttonType: ButtonType.ROUND_ELEVATED_BUTTON,
                onPressed: () {},
              ),
              onClick: () {
                if (widget.src == AudioSrcType.LOCAL_STORAGE) {
                  UIHelper.moveToScreen(LoccalArtistScreen.routeName,
                      arguments: widget.artistList![index],
                      navigatorId: UIHelper.bottomNavigatorKeyId);
                } else {
                  UIHelper.moveToScreen(
                      "/artist/${widget.artistList![index].id}",
                      navigatorId: UIHelper.bottomNavigatorKeyId);
                }
              },
            ),
          ),
        );
      }
    } else {
      return Container();
    }
  }

  addOrRemoveSongId(String id) {
    if (selectedArtistId.contains(id) == true) {
      selectedArtistId.remove(id);
    } else {
      selectedArtistId.add(id);
    }
    widget.artistController.addOrRemoveArtistId(id);
  }
}
