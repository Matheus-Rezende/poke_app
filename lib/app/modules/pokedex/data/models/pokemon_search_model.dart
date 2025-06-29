class PokemonSearchModel {
  final String name;
  final int id;
  final String imageUrl;
  List<String> types;

  PokemonSearchModel({required this.name, required this.id, required this.imageUrl, required this.types});

  factory PokemonSearchModel.fromJson(Map<String, dynamic> json) {
    return PokemonSearchModel(
      name: json['name'],
      types: [],
      id: json['id'],
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${json['id']}.png',
    );
  }

  // Método para atualizar os tipos depois
  void setTypes(List<String> newTypes) {
    types = newTypes;
  }
}
