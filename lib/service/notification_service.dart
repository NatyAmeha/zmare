import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class INotificationService {
  Future<void> createNotificationChannel(String id, String name);
  Future<void> showFirebaseNotification(int id, String? title, String? message,
      String channelId, String channelName);
}

class LocalNotificationService extends INotificationService {
  var flutterNotification = FlutterLocalNotificationsPlugin();
  LocalNotificationService() {
    flutterNotification.initialize(const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher')));
  }
  @override
  Future<void> showFirebaseNotification(int id, String? title, String? message,
      String channelId, String channelName) async {
    var notificationDetail = NotificationDetails(
        android: AndroidNotificationDetails(
      channelId,
      channelName,
    ));
    await flutterNotification.show(
      id,
      title,
      message,
      notificationDetail,
    );
  }

  @override
  Future<void> createNotificationChannel(String id, String name) async {
    var channel =
        AndroidNotificationChannel(id, name, importance: Importance.max);
    await flutterNotification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }
}
