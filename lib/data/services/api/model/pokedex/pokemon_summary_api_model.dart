import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_summary_api_model.freezed.dart';
part 'pokemon_summary_api_model.g.dart';

@freezed
abstract class PokemonSummaryApiModel with _$PokemonSummaryApiModel {
  const factory PokemonSummaryApiModel({required String name, required String url}) =
      _PokemonSummaryApiModel;

  factory PokemonSummaryApiModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonSummaryApiModelFromJson(json);
}
