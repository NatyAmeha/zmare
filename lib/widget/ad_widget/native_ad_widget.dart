import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:zmare/service/ad/admob_helper.dart';

class NativeAdWidget extends StatelessWidget {
  double height;
  NativeAd nativeAd;
  NativeAdWidget({required this.nativeAd, this.height = 60});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      child: AdWidget(ad: nativeAd),
    );
  }
}
