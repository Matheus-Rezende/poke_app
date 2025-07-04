// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:poke_app/app/core/interactor/utils/translator/pokemon_type_translator.dart';

class PokemonDetailsModel {
  final int? id;
  final String? name;
  final String? gifPath;
  final String? imagePath;
  final String? soundPath;
  final List<String>? typeUrls;
  final List<String>? abilities;
  final int? height;
  final int? weight;
  List<String>? types;
  PokemonDetailsModel({
    this.id,
    this.name,
    this.gifPath,
    this.soundPath,
    this.imagePath,
    this.types,
    this.typeUrls,
    this.abilities,
    this.height,
    this.weight,
  });
  factory PokemonDetailsModel.fromJson(Map<String, dynamic> json) {
    var types = (json['types'] as List)
        .map((typeInfo) => typeInfo['type']['name'] as String)
        .map((en) => pokemonTypeTranslation[en] ?? en)
        .toList();

    var typeUrls = (json['types'] as List).map((typeInfo) => typeInfo['type']['url'] as String).toList();

    var abilities = (json['abilities'] as List)
        .map((typeInfo) => typeInfo['ability']['name'] as String)
        .toList();

    return PokemonDetailsModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      gifPath: json['sprites']['other']['showdown']['front_default'] ?? '',
      imagePath: json['sprites']['versions']['generation-viii']['icons']['front_default'] ?? '',
      soundPath: json['cries']['latest'],
      types: types,
      typeUrls: typeUrls,
      height: json['height'],
      weight: json['weight'],
      abilities: abilities,
    );
  }
}
