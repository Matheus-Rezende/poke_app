sealed class NotificationsState {
  NotificationsState();

  NotificationEnabledState enabled() => NotificationEnabledState();
  NotificationDisabledState disabled() => NotificationDisabledState();
}

class NotificationEnabledState extends NotificationsState {
  NotificationEnabledState();
}

class NotificationDisabledState extends NotificationsState {
  NotificationDisabledState();
}
