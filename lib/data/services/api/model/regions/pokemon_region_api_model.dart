import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_region_api_model.freezed.dart';
part 'pokemon_region_api_model.g.dart';

@freezed
abstract class PokemonRegionApiModel with _$PokemonRegionApiModel {
  const factory PokemonRegionApiModel({
    required String generationName,
    required String regionName,
  }) = _PokemonRegionApiModel;

  factory PokemonRegionApiModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonRegionApiModelFromJson(json);
}
