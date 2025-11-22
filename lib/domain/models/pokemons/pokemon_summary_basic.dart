import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_summary_basic.freezed.dart';
part 'pokemon_summary_basic.g.dart';

@freezed
abstract class PokemonSummaryBasic with _$PokemonSummaryBasic {
  const factory PokemonSummaryBasic({required String name, required String url}) =
      _PokemonSummaryBasic;

  factory PokemonSummaryBasic.fromJson(Map<String, dynamic> json) =>
      _$PokemonSummaryBasicFromJson(json);
}
