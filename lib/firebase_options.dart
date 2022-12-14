// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBeSL86UQiFBgqRPMvVip7YDm259FnNpzs',
    appId: '1:255551597191:web:66ebd5b4fa797dcad32622',
    messagingSenderId: '255551597191',
    projectId: 'zmare-ee670',
    authDomain: 'zmare-ee670.firebaseapp.com',
    storageBucket: 'zmare-ee670.appspot.com',
    measurementId: 'G-F86W03NW0F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCSK9-cRjzGUKiDacy-HYO50_q4Wgl787w',
    appId: '1:255551597191:android:c94192e45d728a71d32622',
    messagingSenderId: '255551597191',
    projectId: 'zmare-ee670',
    storageBucket: 'zmare-ee670.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAGW94L8UGzQlu2hzGjSxeW8AA0eQhmrHw',
    appId: '1:255551597191:ios:27f3d1f6b3038607d32622',
    messagingSenderId: '255551597191',
    projectId: 'zmare-ee670',
    storageBucket: 'zmare-ee670.appspot.com',
    androidClientId: '255551597191-h2rauphq21ae62ejt80m9e7ni1bkk87u.apps.googleusercontent.com',
    iosClientId: '255551597191-olbccakmvllggb2tdb3ebu7t3lhe14u4.apps.googleusercontent.com',
    iosBundleId: 'com.savvy.zmare',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAGW94L8UGzQlu2hzGjSxeW8AA0eQhmrHw',
    appId: '1:255551597191:ios:27f3d1f6b3038607d32622',
    messagingSenderId: '255551597191',
    projectId: 'zmare-ee670',
    storageBucket: 'zmare-ee670.appspot.com',
    androidClientId: '255551597191-h2rauphq21ae62ejt80m9e7ni1bkk87u.apps.googleusercontent.com',
    iosClientId: '255551597191-olbccakmvllggb2tdb3ebu7t3lhe14u4.apps.googleusercontent.com',
    iosBundleId: 'com.savvy.zmare',
  );
}
