import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:poke_app/app/core/data/services/local_notifications/local_notifications.dart';

class LocalNotificationsImpl extends LocalNotifications {
  final noficationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  Future<bool> initNotification() async {
    if (_isInitialized) return true;

    final isGranted =
        await noficationsPlugin
            .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission() ??
        false;

    if (!isGranted) return false;

    const initSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: initSettingsAndroid);

    await noficationsPlugin.initialize(initSettings);
    _isInitialized = true;
    return true;
  }

  @override
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Daily Notifications',
        channelDescription: 'Daily Notification Channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }

  @override
  Future<void> showNotification({int id = 0, String? title, String? body}) async {
    await noficationsPlugin.show(
      id,
      title,
      body,
      notificationDetails(), // Usa os detalhes corretos
    );
  }
}
