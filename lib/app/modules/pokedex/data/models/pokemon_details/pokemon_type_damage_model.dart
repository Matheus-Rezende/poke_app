// ignore_for_file: public_member_api_docs, sort_constructors_first
class PokemonTypeDamageModel {
  final List<String>? damages;

  PokemonTypeDamageModel({this.damages});
  factory PokemonTypeDamageModel.fromJson(Map<String, dynamic> json) {
    var damages = (json['double_damage_from'] as List)
        .map((damageInfo) => damageInfo['name'] as String)
        .toList();

    return PokemonTypeDamageModel(damages: damages);
  }
}
