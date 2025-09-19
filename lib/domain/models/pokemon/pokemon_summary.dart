class PokemonSummary {
  final int id;
  final String name;
  final String image;
  final List<String> types;

  PokemonSummary({required this.id, required this.name, required this.image, required this.types});

  factory PokemonSummary.fromJson(Map<String, dynamic> json) {
    final List<String> typesList = (json['types'] as List)
        .map((typeInfo) => typeInfo['type']['name'] as String)
        .toList();

    return PokemonSummary(
      id: json['id'],
      name: json['name'],
      image: json['sprites']?['front_default'] ?? '',
      types: typesList,
    );
  }
}
