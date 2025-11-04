import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_summary.freezed.dart';
part 'pokemon_summary.g.dart';

@freezed
abstract class PokemonSummary with _$PokemonSummary {
  const factory PokemonSummary({
    required int id,
    required String name,
    required String image,
    required List<String> types,
  }) = _PokemonSummary;

  factory PokemonSummary.fromJson(Map<String, dynamic> json) => _$PokemonSummaryFromJson(json);
}
