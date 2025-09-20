class PokemonDetail {
  final int id;
  final String name;
  final List<String> types;
  final String animatedImage;
  final String sound;
  final String description;
  final int height;
  final int weight;
  final String category;

  final List<String> abilities;

  PokemonDetail({
    required this.id,
    required this.name,
    required this.types,
    required this.animatedImage,
    required this.sound,
    required this.description,
    required this.height,
    required this.weight,
    required this.category,
    required this.abilities,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    final List<String> typesList = (json['types'] as List)
        .map((typeInfo) => typeInfo['type']['name'] as String)
        .toList();

    String parsedDescription = 'Nenhuma descrição encontrada.';
    String parsedCategory = 'Desconhecida';

    if (json['species_data'] != null) {
      final speciesJson = json['species_data'];

      final descriptionEntries = (speciesJson['flavor_text_entries'] as List)
          .where((entry) => entry['language']['name'] == 'en')
          .toList();
      if (descriptionEntries.isNotEmpty) {
        parsedDescription = (descriptionEntries.first['flavor_text'] as String)
            .replaceAll('\n', ' ')
            .replaceAll('\f', ' ');
      }

      final generaEntries = (speciesJson['genera'] as List)
          .where((entry) => entry['language']['name'] == 'en')
          .toList();
      if (generaEntries.isNotEmpty) {
        parsedCategory = generaEntries.first['genus'] as String;
      }
    }

    final List<String> abilitiesList = (json['abilities'] as List)
        .map((abilityInfo) => abilityInfo['ability']['name'] as String)
        .toList();

    return PokemonDetail(
      id: json['id'],
      name: json['name'],
      types: typesList,
      animatedImage: json['sprites']?['other']?['showdown']?['front_default'] ?? '',
      sound: json['cries']?['latest'] ?? '',
      description: parsedDescription,
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      category: parsedCategory,
      abilities: abilitiesList,
    );
  }
}
