class PokemonsModel {
  final String name;
  final String? url;
  final int id;
  final String imageUrl;
  List<String> types;

  PokemonsModel({
    required this.name,
    this.url,
    required this.id,
    required this.imageUrl,
    required this.types,
  });

  factory PokemonsModel.fromJson(Map<String, dynamic> json) {
    final url = (json['url'] ?? json['pokemon']?['url'] ?? '') as String;
    int id = 0;

    if (url.isNotEmpty) {
      id = int.parse(url.split('/')[url.split('/').length - 2]);
    }

    return PokemonsModel(
      name: json['name'] ?? json['pokemon']['name'],
      types: List<String>.from(json['types'] ?? []),
      url: url,
      id: url.isEmpty ? json['id'] : id,
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${url.isEmpty ? json['id'] : id}.png',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'url': url, 'id': id, 'imageUrl': imageUrl, 'types': types};
  }
}
