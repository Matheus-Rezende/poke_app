import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:poke_app/app/core/data/services/local_notifications/local_notifications.dart';
import 'package:poke_app/app/core/ui/app_colors.dart';
import 'package:poke_app/app/modules/notifications/interactor/utils/constants/notification_pokemons_constant.dart';

class LocalNotificationsImpl extends LocalNotifications {
  bool _initialized = false;

  @override
  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: 'pokemon_channel',
        channelName: 'Notificações Pokémon',
        channelDescription: 'Notificações sobre Pokémons!',
        defaultColor: AppColors().backgroundBlueColor,
        ledColor: AppColors().whiteColor,
        importance: NotificationImportance.High,
      ),
    ], debug: true);
  }

  @override
  Future<bool> requestPermission() async {
    final isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      return await AwesomeNotifications().requestPermissionToSendNotifications();
    }
    return true;
  }

  @override
  Future<void> scheduleDailyNotification() async {
    await initialize();
    final prefs = await SharedPreferences.getInstance();
    final random = Random();
    final fullList = NotificationPokemonsConstant().pokemonNotificationsMap.toList();

    final lastIds = prefs.getStringList('last_sent_ids')?.map(int.parse).toList() ?? [];

    List<Map<String, dynamic>> selectedNotifications = [];

    for (int attempts = 0; attempts < 10; attempts++) {
      fullList.shuffle(random);
      final temp = fullList.take(3).toList();
      final tempIds = temp.map((e) => e['id']).toList();

      if (!_areSameSet(tempIds, lastIds)) {
        selectedNotifications = temp;
        await prefs.setStringList('last_sent_ids', tempIds.map((e) => e.toString()).toList());
        break;
      }
    }

    final timeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
    final hours = [9, 13, 18, 22];

    for (int i = 0; i < selectedNotifications.length; i++) {
      final data = selectedNotifications[i];
      final randomId = DateTime.now().millisecondsSinceEpoch.remainder(100000) + i;

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: randomId,
          autoDismissible: true,
          channelKey: 'pokemon_channel',
          title: data['title'],
          body: data['body'],
          notificationLayout: data['id'] == 0 ? NotificationLayout.Default : NotificationLayout.BigText,
          largeIcon: data['id'] == 0
              ? null
              : 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${data['id']}.png',
        ),
        schedule: NotificationCalendar(
          hour: hours[i],
          minute: 0,
          second: 0,
          timeZone: timeZone,
          repeats: true,
        ),
      );
    }
  }

  bool _areSameSet(List a, List<int> b) {
    if (a.length != b.length) return false;
    final aSet = a.toSet();
    final bSet = b.toSet();
    return aSet.length == bSet.length && aSet.difference(bSet).isEmpty;
  }

  @override
  Future<void> cancelNotification() async {
    await initialize();
    await AwesomeNotifications().cancelAll();
  }
}
