class PokemonTypeModel {
  final String name;
  final String url;
  final int id;
  final String imageUrl;
  List<String> types;

  PokemonTypeModel({
    required this.name,
    required this.url,
    required this.id,
    required this.imageUrl,
    required this.types,
  });

  factory PokemonTypeModel.fromJson(Map<String, dynamic> json) {
    final url = json['pokemon']['url'] as String;

    // Extraindo o ID da URL
    final id = int.parse(url.split('/')[url.split('/').length - 2]);

    return PokemonTypeModel(
      name: json['pokemon']['name'],
      types: [],
      url: url,
      id: id,
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
    );
  }

  // Método para atualizar os tipos depois
  void setTypes(List<String> newTypes) {
    types = newTypes;
  }
}
