import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:zmare/modals/artist.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/widget/custom_button.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';

class CircleTile extends StatelessWidget {
  String id;
  String? image;
  String? text;
  double radius;
  double height;
  AudioSrcType src;
  Function? onClick;

  List<String> selectedArtistIds;
  ListSelectionState selectionState;
  Function(String)? onMultiSelection;
  CircleTile(
      {required this.id,
      this.image,
      this.text,
      required this.radius,
      this.height = 200,
      this.src = AudioSrcType.NETWORK,
      this.onClick,
      this.selectedArtistIds = const [],
      this.selectionState = ListSelectionState.SINGLE_SELECTION,
      this.onMultiSelection});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: height,
      onTap: () {
        if (selectionState == ListSelectionState.MULTI_SELECTION) {
          onMultiSelection?.call(id);
        } else {
          onClick?.call();
        }
      },
      width: radius * 2,
      padding: 8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (src == AudioSrcType.NETWORK)
            if (image != null)
              Stack(
                children: [
                  CircleAvatar(
                    radius: radius,
                    backgroundImage: NetworkImage(image!),
                  ),
                  if (selectionState == ListSelectionState.MULTI_SELECTION &&
                      selectedArtistIds.contains(id))
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(Icons.check_circle,
                            color: Colors.blue, size: radius),
                      ),
                    )
                ],
              ),
          if (src == AudioSrcType.LOCAL_STORAGE)
            QueryArtworkWidget(
              id: int.parse(id),
              type: ArtworkType.ARTIST,
              artworkHeight: radius * 2,
              artworkWidth: radius * 2,
              nullArtworkWidget: CustomImage(
                null,
                height: radius * 2,
                width: radius * 2,
                roundImage: true,
                borderRadius: 16,
              ),
            ),
          const SizedBox(height: 4),
          if (text != null)
            CustomText(
              text!,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              alignment: TextAlign.center,
              maxLine: 1,
              overflow: TextOverflow.ellipsis,
            )
        ],
      ),
    );
  }
}

class CircleVerticalListTile extends StatelessWidget {
  String image;
  String? text;
  String? subtitle;
  double radius;
  Widget? trailing;
  Function? onClick;

  CircleVerticalListTile({
    required this.image,
    this.text,
    this.subtitle,
    required this.radius,
    this.trailing,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        height: (radius * 2) + 30,
        onTap: () {
          onClick?.call();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(image),
              radius: radius,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text!,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    maxLine: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subtitle != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: CustomText(subtitle!, fontSize: 14),
                    ),
                ],
              ),
            ),
            if (trailing != null) trailing!
          ],
        ));
  }
}

class CircleTileList extends StatelessWidget {
  List<String>? id;
  List<String>? text;
  List<String>? subtitle;
  List<String> image;
  AudioSrcType src;
  Function(String?)? onclick;
  double circleRadius;
  double height;
  ArtistListType? listType;

  Function? onClick;
  CircleTileList(
      {required this.image,
      this.id,
      this.text,
      this.subtitle,
      this.circleRadius = 40,
      this.height = 110,
      this.listType = ArtistListType.ARTIST_HORIZONTAL_LIST,
      this.onclick,
      this.src = AudioSrcType.NETWORK});

  @override
  Widget build(BuildContext context) {
    if (listType == ArtistListType.ARTIST_HORIZONTAL_LIST) {
      return SizedBox(
        height: height,
        child: ListView.separated(
          itemCount: image.length,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemBuilder: (context, index) => src == AudioSrcType.LOCAL_STORAGE
              ? QueryArtworkWidget(
                  id: int.parse(id![index]),
                  type: ArtworkType.ARTIST,
                  artworkHeight: circleRadius * 2,
                  artworkWidth: circleRadius * 2,
                  nullArtworkWidget: CustomImage(
                    null,
                    height: circleRadius * 2,
                    width: circleRadius * 2,
                    roundImage: true,
                    borderRadius: 16,
                  ),
                )
              : CircleTile(
                  id: id![index],
                  image: image[index],
                  text: text?.elementAt(index),
                  radius: circleRadius,
                  src: src,
                  onClick: () {
                    onclick?.call(id![index]);
                  },
                ),
        ),
      );
    } else if (listType == ArtistListType.ARTIST_GRID_LIST) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
        itemBuilder: (context, index) => src == AudioSrcType.LOCAL_STORAGE
            ? QueryArtworkWidget(
                id: int.parse(id![index]),
                type: ArtworkType.ARTIST,
                artworkHeight: circleRadius * 2,
                artworkWidth: circleRadius * 2,
                nullArtworkWidget: CustomImage(
                  null,
                  height: circleRadius * 2,
                  width: circleRadius * 2,
                  roundImage: true,
                  borderRadius: 16,
                ),
              )
            : CircleTile(
                id: id![index],
                image: image[index],
                text: text?.elementAt(index),
                radius: circleRadius,
                src: src,
                onClick: () {
                  onclick?.call(id![index]);
                },
              ),
      );
    } else {
      return SizedBox(
        height: height,
        child: ListView.separated(
          itemCount: image.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) => CircleVerticalListTile(
            image: image[index],
            text: text?.elementAt(index),
            subtitle: subtitle?.elementAt(index),
            radius: circleRadius,
            onClick: onclick,
          ),
        ),
      );
    }
  }
}
