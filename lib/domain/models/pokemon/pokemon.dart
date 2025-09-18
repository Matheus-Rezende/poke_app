class Pokemon {
  final int id;
  final String name;
  final String image;
  final List<String> types;

  Pokemon({required this.id, required this.name, required this.image, required this.types});

  // MUDANÇA PRINCIPAL: O construtor de fábrica foi reescrito para entender a estrutura da PokéAPI.
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    // Extrai a lista de tipos do JSON aninhado.
    final List<String> typesList = (json['types'] as List)
        .map((typeInfo) => typeInfo['type']['name'] as String)
        .toList();

    return Pokemon(
      id: json['id'],
      name: json['name'],

      image: json['sprites']['front_default'] ?? '',
      types: typesList,
    );
  }

  // O resto da classe permanece o mesmo.
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'image': image, 'types': types};
  }

  Pokemon copyWith({int? id, String? name, String? image, List<String>? types}) {
    return Pokemon(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      types: types ?? this.types,
    );
  }
}
