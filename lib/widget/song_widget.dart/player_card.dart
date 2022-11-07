import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/screens/player_screen.dart';
import 'package:zmare/service/ad/admob_helper.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/ad_widget/banner_ad_widget.dart';
import 'package:zmare/widget/custom_container.dart';
import 'package:zmare/widget/custom_image.dart';
import 'package:zmare/widget/custom_text.dart';
import 'package:zmare/widget/song_widget.dart/play_pause_icon.dart';

class PlayerCard extends StatefulWidget {
  PlayerCard({super.key});

  @override
  State<PlayerCard> createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  var appController = Get.find<AppController>();
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadInterstitialAD();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => appController.playerCardActive
        ? StreamBuilder(
            stream: appController.player.queueStateStream,
            builder: (context, snapshot) {
              print("song data p ${appController.selectedAlbumorPlaylistId}");
              if (snapshot.hasData) {
                return CustomContainer(
                  onTap: () {
                    if (appController.playerCardClickCount % 5 == 0)
                      _interstitialAd?.show();
                    else {
                      UIHelper.moveToScreen(PlayerScreen.routeName);
                    }
                    appController.playerCardClickCount++;
                  },
                  padding: 0,
                  borderRadius: 10,
                  color: Theme.of(context).backgroundColor,
                  margin: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      StreamBuilder(
                          stream: appController.player.position,
                          builder: (context, positionSnapshot) {
                            return StreamBuilder(
                              stream: appController.player.totalDurationStream,
                              builder: (context, durationSnapshot) {
                                return ProgressBar(
                                  barHeight: 1,
                                  thumbRadius: 0,
                                  timeLabelLocation: TimeLabelLocation.none,
                                  progress:
                                      positionSnapshot.data ?? Duration.zero,
                                  total: durationSnapshot.data ?? Duration.zero,
                                );
                              },
                            );
                          }),
                      ListTile(
                        minVerticalPadding: 0,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 16),
                        leading: appController.player.playbackSrc ==
                                AudioSrcType.NETWORK
                            ? CustomImage(
                                snapshot.data?.current?.artUri?.toString(),
                                roundImage: true,
                                width: 50,
                                height: 50,
                              )
                            : QueryArtworkWidget(
                                id: int.parse(snapshot.data!.current!.title),
                                type: ArtworkType.AUDIO,
                                artworkWidth: double.infinity,
                                artworkHeight:
                                    MediaQuery.of(context).size.height * 0.4,
                                nullArtworkWidget: CustomImage(null,
                                    roundImage: true, width: 50, height: 50),
                              ),
                        title: CustomText(
                          snapshot.data!.current?.title ?? "",
                          textStyle: Theme.of(context).textTheme.titleSmall,
                          fontWeight: FontWeight.bold,
                          maxLine: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: CustomText(
                          snapshot.data!.current?.artist ?? "",
                          textStyle: Theme.of(context).textTheme.bodySmall,
                        ),
                        trailing: PlayPauseIcon(
                          size: 40,
                          overrideDisplayBeheviour: true,
                          color:
                              Theme.of(context).iconTheme.color ?? Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return BannerAdWidget(adSize: AdSize.fullBanner);
              }
            })
        : Container());
  }

  @override
  dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  _loadInterstitialAD() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          ad.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (fad) {
            fad.dispose();
            UIHelper.moveToScreen(PlayerScreen.routeName);
            _loadInterstitialAD();
          });
          setState(() {
            _interstitialAd = ad;
          });
        }, onAdFailedToLoad: (error) {
          print('Failed to load an interstitial ad: ${error.message}');
        }));
  }
}
