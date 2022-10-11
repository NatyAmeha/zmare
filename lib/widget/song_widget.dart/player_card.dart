import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:zmare/controller/app_controller.dart';
import 'package:zmare/screens/player_screen.dart';
import 'package:zmare/service/ad/admob_helper.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'package:zmare/widget/ad_widget/banner_ad_widget.dart';
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
    return StreamBuilder(
        stream: appController.player.queueState,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return InkWell(
              onTap: () {
                if (appController.playerCardClickCount % 5 == 0)
                  _interstitialAd?.show();
                else
                  UIHelper.moveToScreen(PlayerScreen.routeName);
                appController.playerCardClickCount++;
              },
              child: Card(
                elevation: 2,
                margin: const EdgeInsets.all(0),
                child: ListTile(
                  minVerticalPadding: 0,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  leading: CustomImage(
                    snapshot.data?.current?.artUri?.toString(),
                    roundImage: true,
                    width: 50,
                    height: 50,
                  ),
                  title: CustomText(
                    snapshot.data!.current?.title ?? "",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    maxLine: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: CustomText(snapshot.data!.current?.artist ?? "",
                      fontSize: 12),
                  trailing: PlayPauseIcon(isBuffering: true, size: 40),
                ),
              ),
            );
          } else {
            return BannerAdWidget(
              adSize: AdSize.fullBanner,
            );
          }
        });
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
