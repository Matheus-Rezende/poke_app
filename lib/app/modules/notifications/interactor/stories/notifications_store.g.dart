// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NotificationsStore on NotificationsStoreBase, Store {
  Computed<bool>? _$isNotificationsDisabledComputed;

  @override
  bool get isNotificationsDisabled =>
      (_$isNotificationsDisabledComputed ??= Computed<bool>(
        () => super.isNotificationsDisabled,
        name: 'NotificationsStoreBase.isNotificationsDisabled',
      )).value;

  late final _$notificationsStateAtom = Atom(
    name: 'NotificationsStoreBase.notificationsState',
    context: context,
  );

  @override
  NotificationsState get notificationsState {
    _$notificationsStateAtom.reportRead();
    return super.notificationsState;
  }

  @override
  set notificationsState(NotificationsState value) {
    _$notificationsStateAtom.reportWrite(value, super.notificationsState, () {
      super.notificationsState = value;
    });
  }

  late final _$hasNotificationPermissionAtom = Atom(
    name: 'NotificationsStoreBase.hasNotificationPermission',
    context: context,
  );

  @override
  bool get hasNotificationPermission {
    _$hasNotificationPermissionAtom.reportRead();
    return super.hasNotificationPermission;
  }

  @override
  set hasNotificationPermission(bool value) {
    _$hasNotificationPermissionAtom.reportWrite(
      value,
      super.hasNotificationPermission,
      () {
        super.hasNotificationPermission = value;
      },
    );
  }

  late final _$changeNotificationAsyncAction = AsyncAction(
    'NotificationsStoreBase.changeNotification',
    context: context,
  );

  @override
  Future<void> changeNotification() {
    return _$changeNotificationAsyncAction.run(
      () => super.changeNotification(),
    );
  }

  late final _$loadNotificationsAsyncAction = AsyncAction(
    'NotificationsStoreBase.loadNotifications',
    context: context,
  );

  @override
  Future<void> loadNotifications() {
    return _$loadNotificationsAsyncAction.run(() => super.loadNotifications());
  }

  @override
  String toString() {
    return '''
notificationsState: ${notificationsState},
hasNotificationPermission: ${hasNotificationPermission},
isNotificationsDisabled: ${isNotificationsDisabled}
    ''';
  }
}
