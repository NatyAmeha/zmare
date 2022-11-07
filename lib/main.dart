import 'dart:isolate';
import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:zmare/screens/main_screen.dart';
import 'package:zmare/service/notification_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:zmare/service/player/player_service.dart';
import 'package:zmare/utils/constants.dart';
import 'package:zmare/utils/route/routes.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:zmare/utils/theme.dart';
import 'package:zmare/utils/ui_helper.dart';
import 'firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FlutterDownloader.initialize(
    debug: false, //set to false to disable printing logs to console
    // ignoreSsl: true //set to false to disable working with http links
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  FlutterDownloader.registerCallback(downloadCallback);
  await JustAudioPlayer.initBackgroundPlayback();
  await MobileAds.instance.initialize();
  await initializeFCM();
  await Settings.init();
  var isDarkMode = await UIHelper.getAppTheme();
  print("isdark mode $isDarkMode");

  runApp(MyApp(
    isDarkTheme: isDarkMode,
  ));
}

Future<void> initializeFCM() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
  var notificationService = LocalNotificationService();
  await notificationService.createNotificationChannel(
      Constants.DEFAULT_NOTIFICATION_CHANNEL_ID,
      Constants.DEFAULT_NOTIFICATION_CHANNEL_NAME);
  FirebaseMessaging.onMessage.listen((message) {
    print("fcm result  ${message.data} ${message.notification?.title}");
    var notification = message.notification;
    var android = message.notification?.android;
    if (message.data != null) {
      notificationService.showFirebaseNotification(
          1,
          message.data["title"],
          message.data["body"],
          Constants.DEFAULT_NOTIFICATION_CHANNEL_ID,
          Constants.DEFAULT_NOTIFICATION_CHANNEL_NAME);
    }
  });
}

class MyApp extends StatelessWidget {
  bool? isDarkTheme;
  MyApp({this.isDarkTheme});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        key: Get.nestedKey(UIHelper.mainNavigatorKeyId),
        themeMode: isDarkTheme == null
            ? ThemeMode.system
            : (isDarkTheme! ? ThemeMode.dark : ThemeMode.light),
        theme: AppTheme.Light,
        darkTheme: AppTheme.Dark,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('am', ''),
        defaultTransition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 160),
        home: MainScreen(),
        getPages: RouteUtil.routes);
  }
}

void downloadCallback(String id, DownloadTaskStatus status, int progress) {
  final SendPort send =
      IsolateNameServer.lookupPortByName('downloader_send_port')!;
  send.send([id, status, progress]);
}
