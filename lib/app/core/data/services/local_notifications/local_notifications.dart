import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class LocalNotifications {
  Future<bool> initNotification();
  NotificationDetails notificationDetails();
  Future<void> showNotification({int id = 0, String? title, String? body});
}
