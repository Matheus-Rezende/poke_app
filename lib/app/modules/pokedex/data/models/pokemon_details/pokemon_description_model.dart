// ignore_for_file: public_member_api_docs, sort_constructors_first
class PokemonDescriptionModel {
  final String? description;
  final int? genderRate;
  final String? evolutionChainUrl;

  PokemonDescriptionModel({this.description, this.genderRate, this.evolutionChainUrl});
  factory PokemonDescriptionModel.fromJson(Map<String, dynamic> json) {
    return PokemonDescriptionModel(
      description: json['flavor_text'] ?? '',
      genderRate: json['gender_rate'] ?? 0,
      evolutionChainUrl: json['evolution_chain_url'] ?? '',
    );
  }
}
