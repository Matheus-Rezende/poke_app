// notifications_store.dart

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:mobx/mobx.dart';
import 'package:poke_app/app/core/data/services/local_notifications/local_notifications.dart';
import 'package:poke_app/app/core/data/services/local_storage/local_storage.dart';
import 'package:poke_app/app/modules/notifications/interactor/states/notifications_state.dart';

part 'notifications_store.g.dart';

class NotificationsStore = NotificationsStoreBase with _$NotificationsStore;

abstract class NotificationsStoreBase with Store {
  final LocalStorage localStorage;
  final LocalNotifications localNotifications;

  NotificationsStoreBase({required this.localStorage, required this.localNotifications});

  @observable
  NotificationsState notificationsState = NotificationDisabledState();

  @observable
  bool hasNotificationPermission = true;

  @computed
  bool get isNotificationsDisabled => notificationsState is NotificationDisabledState;

  final String notificationKey = "isNotificationsEnabled";

  @action
  Future<void> changeNotification() async {
    if (notificationsState is NotificationDisabledState) {
      final granted = await localNotifications.requestPermission();
      hasNotificationPermission = granted;

      if (!granted) return;

      await localNotifications.initialize();
      await localNotifications.scheduleDailyNotification();

      notificationsState = notificationsState.enabled();
      await localStorage.setItem(key: notificationKey, value: true);
    } else {
      await localNotifications.cancelNotification();
      notificationsState = notificationsState.disabled();
      await localStorage.setItem(key: notificationKey, value: false);
    }
  }

  @action
  Future<void> loadNotifications() async {
    final hasKey = await localStorage.contains(key: notificationKey);
    final isEnabled = await localStorage.getItem(key: notificationKey);

    if (hasKey && isEnabled) {
      final permission = await AwesomeNotifications().isNotificationAllowed();
      hasNotificationPermission = permission;

      if (permission) {
        notificationsState = notificationsState.enabled();

        // Inicializa e agenda novamente (em caso de reboot do app)
        await localNotifications.initialize();
        await localNotifications.scheduleDailyNotification();
      }
    }
  }

  /// ✅ Método novo para ser chamado quando o app volta do background
  @action
  Future<void> updateNotificationPermission() async {
    final permission = await AwesomeNotifications().isNotificationAllowed();
    hasNotificationPermission = permission;
    if (hasNotificationPermission) {
      notificationsState = notificationsState.enabled();
      await localStorage.setItem(key: notificationKey, value: true);
      // Inicializa e agenda novamente (em caso de reboot do app)
      await localNotifications.initialize();
      await localNotifications.scheduleDailyNotification();
    } else {
      notificationsState = notificationsState.disabled();
      await localStorage.setItem(key: notificationKey, value: false);
    }
  }
}
