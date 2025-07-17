abstract class LocalNotifications {
  Future<void> initialize();
  Future<bool> requestPermission();
  Future<void> scheduleDailyNotification();
  Future<void> cancelNotification();
}
