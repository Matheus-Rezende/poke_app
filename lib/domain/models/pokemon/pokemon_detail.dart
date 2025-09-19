class PokemonDetail {
  final int id;
  final String name;
  final List<String> types;
  final String animatedGif;
  final String sound;

  PokemonDetail({
    required this.id,
    required this.name,
    required this.types,
    required this.animatedGif,
    required this.sound,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    final List<String> typesList = (json['types'] as List)
        .map((typeInfo) => typeInfo['type']['name'] as String)
        .toList();

    return PokemonDetail(
      id: json['id'],
      name: json['name'],
      types: typesList,
      animatedGif: json['sprites']?['other']?['showdown']?['front_default'] ?? '',
      sound: json['cries']?['latest'] ?? '',
    );
  }
}
