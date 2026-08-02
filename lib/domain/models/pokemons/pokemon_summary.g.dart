// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PokemonSummary _$PokemonSummaryFromJson(Map<String, dynamic> json) =>
    _PokemonSummary(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$PokemonSummaryToJson(_PokemonSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'types': instance.types,
      'imageUrl': instance.imageUrl,
    };
