import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:poke_app/data/services/api/model/pokedex/pokemon_detail_api_model.dart';
import 'package:poke_app/data/services/api/model/pokedex/pokemon_summary_api_model.dart';
import 'package:poke_app/data/services/api/model/regions/pokemon_region_api_model.dart';
import 'package:poke_app/utils/result/result.dart';

class ApiClient {
  ApiClient({http.Client? clientHttpFactory})
    : _clientHttpFactory = clientHttpFactory ?? http.Client(),
      _baseUrl = 'pokeapi.co';

  final http.Client _clientHttpFactory;
  final String _baseUrl;
  final _log = Logger('ApiClient');

  Future<Result<List<PokemonSummaryApiModel>>> getPokemons({
    required int limit,
    required int offset,
  }) async {
    try {
      final client = _clientHttpFactory;
      final uri = Uri.https(_baseUrl, '/api/v2/pokemon', {
        'limit': limit.toString(),
        'offset': offset.toString(),
      });

      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final results = json['results'] as List<dynamic>;

        final pokemons = results.map((e) => PokemonSummaryApiModel.fromJson(e)).toList();

        _log.fine('Lista de ${pokemons.length} pokémons carregada com sucesso!');
        return Result.ok(pokemons);
      } else {
        _log.warning('Falha ao carregar lista de pokémons. Código: ${response.statusCode}');
        return Result.error(HttpException('Falha ao carregar lista de pokémons.'));
      }
    } on Exception catch (error) {
      _log.severe('Erro ao buscar pokémons: $error');
      return Result.error(error);
    }
  }

  Future<Result<PokemonDetailApiModel>> getPokemonDetailsByUrl(String url) async {
    try {
      final client = _clientHttpFactory;
      final uri = Uri.parse(url);

      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final detail = PokemonDetailApiModel.fromApiJson(json);

        _log.fine('Detalhes do pokémon ${detail.name} carregados com sucesso!');
        return Result.ok(detail);
      } else {
        _log.warning('Falha ao carregar detalhes do pokémon ($url)');
        return Result.error(HttpException('Falha ao carregar detalhes.'));
      }
    } on Exception catch (error) {
      _log.severe('Erro ao carregar detalhes do pokémon: $error');
      return Result.error(error);
    }
  }

  Future<Result<PokemonDetailApiModel>> getPokemonDetailsByQuery(String query) async {
    try {
      final client = _clientHttpFactory;
      final uri = Uri.https(_baseUrl, '/api/v2/pokemon/$query');

      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final detail = PokemonDetailApiModel.fromApiJson(json);

        _log.fine('Detalhes do pokémon ${detail.name} carregados com sucesso!');
        return Result.ok(detail);
      } else {
        _log.warning('Falha ao carregar detalhes do pokémon ($query)');
        return Result.error(HttpException('Falha ao carregar detalhes.'));
      }
    } on Exception catch (error) {
      _log.severe('Erro ao carregar detalhes do pokémon: $error');
      return Result.error(error);
    }
  }

  Future<Result<List<Map<String, dynamic>>>> getRegions() async {
    try {
      final uri = Uri.https(_baseUrl, '/api/v2/region');
      final response = await _clientHttpFactory.get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final results = json['results'] as List<dynamic>;
        return Result.ok(List<Map<String, dynamic>>.from(results));
      } else {
        _log.warning('Falha ao buscar regiões. Código: ${response.statusCode}');
        return Result.error(HttpException('Falha ao buscar regiões.'));
      }
    } on Exception catch (error) {
      _log.severe('Erro ao buscar regiões: $error');
      return Result.error(error);
    }
  }

  Future<Result<PokemonRegionApiModel>> getRegionDetails(String url) async {
    try {
      final response = await _clientHttpFactory.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;

        final generationName = (json['main_generation']?['name'] as String?) ?? '';
        final regionName = json['name'] as String? ?? '';

        return Result.ok(
          PokemonRegionApiModel(generationName: generationName, regionName: regionName),
        );
      } else {
        return Result.error(HttpException('Falha ao buscar detalhes da região: $url'));
      }
    } on Exception catch (error) {
      _log.warning('Erro ao buscar detalhes da região: $error');
      return Result.error(error);
    }
  }

  Future<Result<List<PokemonSummaryApiModel>>> getPokemonsByType({required String typeName}) async {
    try {
      final client = _clientHttpFactory;
      final uri = Uri.https(_baseUrl, '/api/v2/type/$typeName');

      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final pokemonList = json['pokemon'] as List<dynamic>;

        // Cada item tem estrutura { "pokemon": { "name": ..., "url": ... }, "slot": ... }
        final pokemons = pokemonList
            .map((e) => PokemonSummaryApiModel.fromJson(e['pokemon'] as Map<String, dynamic>))
            .toList();

        _log.fine('Lista de ${pokemons.length} pokémons do tipo $typeName carregada com sucesso!');
        return Result.ok(pokemons);
      } else {
        _log.warning(
          'Falha ao carregar pokémons por tipo $typeName. Código: ${response.statusCode}',
        );
        return Result.error(HttpException('Falha ao carregar pokémons por tipo.'));
      }
    } on Exception catch (error) {
      _log.severe('Erro ao buscar pokémons por tipo $typeName: $error');
      return Result.error(error);
    }
  }
}
