import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_summary.freezed.dart';
part 'pokemon_summary.g.dart';

@freezed
abstract class PokemonSummary with _$PokemonSummary {
  const factory PokemonSummary({
    required int id,
    required String name,
    required List<String> types,
    required String imageUrl,
  }) = _PokemonSummary;

  factory PokemonSummary.fromJson(Map<String, dynamic> json) => _$PokemonSummaryFromJson(json);

  factory PokemonSummary.fromApiJson(Map<String, dynamic> json) {
    return PokemonSummary(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e['type']['name'] as String).toList() ?? [],
      imageUrl: json['sprites']?['front_default'] as String? ?? '',
    );
  }
}
