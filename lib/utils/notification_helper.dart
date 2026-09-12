import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:task_manager/utils/notification_constraints.dart';

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin notification = FlutterLocalNotificationsPlugin();

  // notification init
  static Future<void> initialize() async{
    await notification.initialize(settings: InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings()
    ));
  }

  // notification show periodically
  static Future<void> showNotificationPeriodically(String title, String body) async{
    await notification.periodicallyShow(
        id: NotificationConstraints.notificationId,
        title: title,
        body: body,
        repeatInterval: RepeatInterval.daily,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            NotificationConstraints.channelId,
            NotificationConstraints.channelName,
            importance: Importance.high,
            priority: Priority.high
          ),
          iOS: DarwinNotificationDetails()
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle
    );
  }

}