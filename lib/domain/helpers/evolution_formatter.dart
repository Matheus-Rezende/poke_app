import 'package:poke_app/utils/extensions/string_casting_extension.dart';

/// Traduz o objeto `evolution_details` da PokéAPI para uma String legível.
String formatEvolutionTrigger(Map<String, dynamic> details) {
  final trigger = details['trigger']['name'] as String?;
  final itemName = details['item']?['name'] as String?;
  final minLevel = details['min_level'];
  final minHappiness = details['min_happiness'];
  final timeOfDay = details['time_of_day'] as String?;

  // Regra de tradução para inglês (pode ser expandida para outros idiomas no futuro)
  switch (trigger) {
    case 'level-up':
      if (minHappiness != null) {
        return 'High Friendship${timeOfDay != null && timeOfDay.isNotEmpty ? ' at $timeOfDay' : ''}';
      }
      if (timeOfDay != null && timeOfDay.isNotEmpty) {
        return 'Level up during the $timeOfDay';
      }
      if (minLevel != null) {
        return 'Level $minLevel';
      }
      return 'Level Up';
    case 'use-item':
      // Formata o nome do item para ser mais legível (ex: "fire-stone" -> "Fire Stone")
      final formattedItemName = itemName
          ?.replaceAll('-', ' ')
          .split(' ')
          .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
          .join(' ');
      return 'Use $formattedItemName';
    case 'trade':
      return 'Trade';
    default:
      return trigger?.replaceAll('-', ' ').toCapitalized ?? 'Special';
  }
}
