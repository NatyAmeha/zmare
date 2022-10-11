import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/6300978111";
      // return "ca-app-pub-7035794285501909/6902961567";
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
      // return "ca-app-pub-7035794285501909/7279748977";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/1033173712";
      // return "ca-app-pub-7035794285501909/1672199075";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/4411468910";
      // return "ca-app-pub-7035794285501909/6353131379";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      // return "ca-app-pub-7035794285501909/6655549557";
      return 'ca-app-pub-3940256099942544/2247696110';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/3986624511';
      // return "ca-app-pub-7035794285501909/3208093284";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
