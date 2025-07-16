// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  @computed
  bool get isNotificationsDisabled => notificationsState is NotificationDisabledState;

  final String notificationKey = "isNotificationsEnabled";

  @observable
  bool hasNotificationPermission = true;

  @action
  Future<void> changeNotification() async {
    if (notificationsState is NotificationDisabledState) {
      final granted = await localNotifications.initNotification();

      if (!granted) return;

      notificationsState = notificationsState.enabled();
      await localStorage.setItem(key: notificationKey, value: true);
      await localNotifications.showNotification(
        title: 'Notificações ativadas!',
        body: 'Você receberá notificações.',
      );
    } else if (notificationsState is NotificationEnabledState) {
      notificationsState = notificationsState.disabled();
      await localStorage.setItem(key: notificationKey, value: false);
    }
  }

  @action
  Future<void> loadNotifications() async {
    final hasKey = await localStorage.contains(key: notificationKey);
    final isEnabled = await localStorage.getItem(key: notificationKey);

    if (hasKey && isEnabled) {
      notificationsState = notificationsState.enabled();
      await localNotifications.initNotification();
    }
  }
}
