String? localizationUtils({
  required List<dynamic> data,
  String primaryLang = 'pt',
  String fallbackLang = 'en',
  required String fieldName,
}) {
  String? extract(String langCode) {
    for (final entry in data) {
      try {
        final language = entry['language'];
        if (language != null && language['name'] == langCode) {
          final value = entry[fieldName];
          if (value != null && value is String && value.isNotEmpty) {
            return value.replaceAll('\n', ' ').replaceAll('\f', ' ').trim();
          }
        }
      } catch (_) {
        continue;
      }
    }
    return null;
  }

  return extract(primaryLang) ?? extract(fallbackLang);
}
