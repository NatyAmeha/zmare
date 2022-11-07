import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:zmare/controller/preview_controller.dart';
import 'package:zmare/modals/preview.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/extension.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/viewmodels/queue_state.dart';
import 'package:zmare/widget/custom_button.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/song_widget.dart/play_pause_icon.dart';

class PreviewPage extends StatelessWidget {
  Preview previewInfo;
  PreviewPage({required this.previewInfo});

  var previewController = Get.find<PreviewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          if (previewController.previewPlayer.playerState?.playbackState ==
              PlaybackState.PLAYING) {
            previewController.previewPlayer.pause();
          } else {
            previewController.previewPlayer.play();
          }
        },
        child: Stack(
          children: [
            CustomImage(
              previewInfo.images?.first,
              width: double.infinity,
              height: double.infinity,
            ),
            CustomContainer(
              height: double.infinity,
              width: double.infinity,
              gradientColor: [
                Colors.transparent,
                Theme.of(context).scaffoldBackgroundColor
              ],
              child: Container(),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_outline_outlined,
                            size: 40,
                          )),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: IconButton(
                          onPressed: () {
                            previewController.sharePreview(
                                "New release preview on ZmareApp",
                                "Check out ${previewInfo.title} new release preview. \n${previewInfo.description}",
                                "${previewInfo.images?.first}");
                          },
                          icon: const Icon(
                            Icons.share,
                            size: 40,
                          )),
                    ),
                    const SizedBox(height: 24),
                    ListTile(
                        onTap: () {
                          UIHelper.moveToArtistScreen([previewInfo.artistId!],
                              [previewInfo.artistName!]);
                        },
                        leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(previewInfo.artistImage!)),
                        title: CustomText(
                          previewInfo.artistName ?? "",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        trailing: CustomButton("Listen",
                            buttonType: ButtonType.ROUND_ELEVATED_BUTTON,
                            wrapContent: true, onPressed: () {
                          UIHelper.moveToScreen(
                              "/album/${previewInfo.destinationId}",
                              arguments: {"src": AudioSrcType.NETWORK},
                              navigatorId: UIHelper.bottomNavigatorKeyId);
                        })),
                    Padding(
                        padding: const EdgeInsets.all(16),
                        child: CustomText(
                          (previewInfo.description ?? "") * 2,
                          fontSize: 16,
                          alignment: TextAlign.start,
                          color: Colors.grey,
                          maxLine: 2,
                          overflow: TextOverflow.ellipsis,
                        )),
                    StreamBuilder(
                      stream: previewController.previewPlayer.position,
                      builder: (context, positionSnapshot) {
                        return StreamBuilder(
                          stream: previewController
                              .previewPlayer.totalDurationStream,
                          builder: (context, durationSnapshot) {
                            return handlePlaybackState(onBuffer: (_) {
                              return const LinearProgressIndicator(
                                backgroundColor: Colors.grey,
                                minHeight: 1,
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              );
                            }, onPlay: (_) {
                              return ProgressBar(
                                progress:
                                    positionSnapshot.data ?? Duration.zero,
                                total: durationSnapshot.data ?? Duration.zero,
                                timeLabelPadding: 0,
                                thumbRadius: 0,
                                barHeight: 1,
                                thumbCanPaintOutsideBar: false,
                                timeLabelLocation: TimeLabelLocation.none,
                              );
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
                child: Align(
              alignment: Alignment.center,
              child: handlePlaybackState(
                  onPause: (_) => const Icon(Icons.play_circle, size: 80)),
            ))
          ],
        ),
      ),
    );
  }

  Widget handlePlaybackState(
      {Widget Function(PlaybackState)? onPlay,
      Widget Function(PlaybackState)? onPause,
      Widget Function(PlaybackState)? onBuffer}) {
    return StreamBuilder(
      stream: previewController.previewPlayer.playerStateStream,
      builder: (context, playerStateSnapshot) {
        if (playerStateSnapshot.data?.playbackState == PlaybackState.PAUSED) {
          return onPause?.call(PlaybackState.PAUSED) ??
              onPlay?.call(PlaybackState.PLAYING) ??
              Container();
        } else if (playerStateSnapshot.data?.playbackState ==
            PlaybackState.PLAYING) {
          return onPlay?.call(PlaybackState.PLAYING) ?? Container();
        } else if (playerStateSnapshot.data?.playbackState ==
            PlaybackState.BUFFERING) {
          return onBuffer?.call(PlaybackState.BUFFERING) ??
              onPlay?.call(PlaybackState.BUFFERING) ??
              Container();
        } else {
          return Container();
        }
      },
    );
  }
}
