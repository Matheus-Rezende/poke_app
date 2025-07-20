import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:poke_app/app/core/routes/app_routes.dart';
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

    Map<String, dynamic>? selectedPokemon;
    for (int attempts = 0; attempts < 10; attempts++) {
      fullList.shuffle(random);
      final temp = fullList.first;
      if (!lastIds.contains(temp['id'])) {
        selectedPokemon = temp;
        break;
      }
    }

    if (selectedPokemon == null) return;

    await prefs.setStringList('last_sent_ids', [selectedPokemon['id'].toString()]);

    final hours = [10, 16, 22];
    final lastHour = prefs.getInt('last_sent_hour');

    final availableHours = hours.where((h) => h != lastHour).toList();
    final randomHour = availableHours[random.nextInt(availableHours.length)];

    await prefs.setInt('last_sent_hour', randomHour);

    await AwesomeNotifications().cancelAll();

    final timeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1001,
        autoDismissible: true,
        channelKey: 'pokemon_channel',
        title: selectedPokemon['title'],
        body: selectedPokemon['body'],
        payload: {'pokemonId': selectedPokemon['id'].toString(), 'route': AppRoutes.pokemonDetails()},
        notificationLayout: NotificationLayout.BigPicture,
        bigPicture:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${selectedPokemon['id']}.png',
      ),
      schedule: NotificationCalendar(hour: 11, minute: 23, second: 0, timeZone: timeZone, repeats: true),
    );
  }

  @override
  Future<void> cancelNotification() async {
    await initialize();
    await AwesomeNotifications().cancelAll();
  }
}
