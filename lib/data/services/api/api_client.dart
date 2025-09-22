import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:poke_app/domain/models/pokemon/pokemon_detail.dart';
import 'package:poke_app/domain/models/pokemon/pokemon_summary.dart';
import 'package:poke_app/utils/result/result.dart';

class ApiClient {
  ApiClient({http.Client? clientHttpFactory})
    : _clientHttpFactory = clientHttpFactory ?? http.Client(),
      _baseUrl = 'pokeapi.co';

  final http.Client _clientHttpFactory;
  final String _baseUrl;

  final Map<String, List<String>> _typeWeaknessCache = {};

  Future<Result<List<PokemonSummary>>> getPokemons({
    required int limit,
    required int offset,
  }) async {
    final client = _clientHttpFactory;

    try {
      final listUrl = Uri.https(_baseUrl, '/api/v2/pokemon', {
        'limit': limit.toString(),
        'offset': offset.toString(),
      });

      final listResponse = await client.get(listUrl);

      if (listResponse.statusCode == 200) {
        final listJson = jsonDecode(listResponse.body);
        final List<dynamic> pokemonSummaries = listJson['results'];

        final List<Future<PokemonSummary>> futuresPokemons = pokemonSummaries.map((summary) async {
          final detailUrl = Uri.parse(summary['url']);
          final detailResponse = await client.get(detailUrl);
          if (detailResponse.statusCode == 200) {
            final detailJson = jsonDecode(detailResponse.body);
            return PokemonSummary.fromJson(detailJson);
          } else {
            return throw HttpException('Falha ao carregar detalhes para ${summary['name']}');
          }
        }).toList();
        final List<PokemonSummary> pokedex = await Future.wait(futuresPokemons, eagerError: true);

        return Result.ok(pokedex);
      } else {
        return Result.error(const HttpException('Falha ao carregar os pokémons.'));
      }
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  Future<List<String>> _getTypeWeaknesses(String typeName) async {
    if (_typeWeaknessCache.containsKey(typeName)) {
      return _typeWeaknessCache[typeName]!;
    }
    final client = _clientHttpFactory;

    try {
      final url = Uri.https(_baseUrl, '/api/v2/type/$typeName');
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<String> weaknesses = (json['damage_relations']['double_damage_from'] as List)
            .map((typeInfo) => typeInfo['name'] as String)
            .toList();

        _typeWeaknessCache[typeName] = weaknesses;
        return weaknesses;
      }
    } on Exception catch (error) {
      print('Erro ao buscar fraquezas para o tipo $typeName: $error');
    }
    return [];
  }

  Future<Result<PokemonDetail>> getPokemonDetailById(int id) async {
    final client = _clientHttpFactory;
    try {
      final pokemonUrl = Uri.https(_baseUrl, '/api/v2/pokemon/$id');
      final speciesUrl = Uri.https(_baseUrl, '/api/v2/pokemon-species/$id');

      final primaryResponses = await Future.wait([client.get(pokemonUrl), client.get(speciesUrl)]);

      if (primaryResponses[0].statusCode != 200) {
        return Result.error(
          HttpException(
            'Falha ao carregar dados do Pokémon: Status ${primaryResponses[0].statusCode}',
          ),
        );
      }

      final pokemonJson = jsonDecode(primaryResponses[0].body) as Map<String, dynamic>;
      final speciesJson = primaryResponses[1].statusCode == 200
          ? jsonDecode(primaryResponses[1].body) as Map<String, dynamic>
          : null;

      final List<String> types = (pokemonJson['types'] as List)
          .map((typeInfo) => typeInfo['type']['name'] as String)
          .toList();

      final weaknessFutures = types.map((typeName) => _getTypeWeaknesses(typeName)).toList();
      final weaknessesResults = await Future.wait(weaknessFutures);

      final uniqueWeaknesses = weaknessesResults.expand((list) => list).toSet().toList();

      final combinedJson = {
        ...pokemonJson,
        if (speciesJson != null) 'species_data': speciesJson,
        'weaknesses_data': uniqueWeaknesses,
      };

      final pokemon = PokemonDetail.fromJson(combinedJson);
      return Result.ok(pokemon);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
