import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_detail_api_model.freezed.dart';
part 'pokemon_detail_api_model.g.dart';

@freezed
abstract class PokemonDetailApiModel with _$PokemonDetailApiModel {
  const factory PokemonDetailApiModel({
    required int id,
    required String name,
    required List<String> types,
    required String imageUrl,
  }) = _PokemonDetailApiModel;

  factory PokemonDetailApiModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonDetailApiModelFromJson(json);

  factory PokemonDetailApiModel.fromApiJson(Map<String, dynamic> json) {
    return PokemonDetailApiModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e['type']['name'] as String).toList() ?? [],
      imageUrl: json['sprites']?['front_default'] as String? ?? '',
    );
  }
}
