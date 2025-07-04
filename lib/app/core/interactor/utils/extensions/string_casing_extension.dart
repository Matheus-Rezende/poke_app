extension StringCasingExtension on String {
  String get toCapitalized => isNotEmpty ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String get toTitleCase =>
      replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized).join(' ');
}
