import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:just_audio/just_audio.dart';
import 'package:zmare/modals/playlist.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/playlist_widget/large_playlist_list_item.dart';
import 'package:zmare/widget/playlist_widget/playlist_grid_tile.dart';

class PlaylistList extends StatelessWidget {
  List<Playlist>? playlists;
  bool shrinkWrap;
  AudioSrcType src;
  PlaylistListType listType;
  double height;
  bool querySongs;
  bool primary;
  bool isSliver;
  PlaylistList(
    this.playlists, {
    this.src = AudioSrcType.NETWORK,
    this.shrinkWrap = false,
    this.height = 200,
    this.isSliver = false,
    this.primary = true,
    this.querySongs = true,
    this.listType = PlaylistListType.HORIZONTAL,
  });

  @override
  Widget build(BuildContext context) {
    if (playlists?.isNotEmpty == true) {
      if (listType == PlaylistListType.HORIZONTAL) {
        return SizedBox(
          height: 250,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: playlists!.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) => LargePlaylistTile(
              playlists![index],
              querySongs: querySongs,
            ),
          ),
        );
      } else if (listType == PlaylistListType.GRID) {
        if (isSliver) {
          return SliverGrid(
            delegate: SliverChildBuilderDelegate(
              childCount: playlists!.length,
              (context, index) => PlaylistGridTile(
                playlistInfo: playlists![index],
                imageSize: 200,
                height: height,
                subtitle: playlists![index].songs?.isNotEmpty == true
                    ? CustomText(
                        "${playlists![index].songs?.length} songs",
                        textStyle: Theme.of(context).textTheme.bodySmall,
                      )
                    : CustomText(
                        "${playlists![index].followersId?.length ?? 0} followers",
                        textStyle: Theme.of(context).textTheme.bodySmall,
                        fontSize: 11,
                      ),
                src: src,
              ),
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                mainAxisExtent: height),
          );
        } else {
          return GridView.builder(
            primary: primary,
            itemCount: playlists!.length,
            shrinkWrap: shrinkWrap,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                mainAxisExtent: height),
            itemBuilder: (context, index) => PlaylistGridTile(
              playlistInfo: playlists![index],
              imageSize: 200,
              height: height,
              subtitle: playlists![index].songs?.isNotEmpty == true
                  ? CustomText(
                      "${playlists![index].songs?.length} songs",
                      fontSize: 11,
                    )
                  : CustomText(
                      "${playlists![index].followersId?.length ?? 0} followers",
                      fontSize: 11,
                    ),
              src: src,
            ),
          );
        }
      }
    }
    if (isSliver)
      return SliverToBoxAdapter(child: Container());
    else
      return Container();
  }
}
