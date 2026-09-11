import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin notification = FlutterLocalNotificationsPlugin();

  static void initialize() async{
    await notification.initialize(settings: InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings()
    ));
  }

}