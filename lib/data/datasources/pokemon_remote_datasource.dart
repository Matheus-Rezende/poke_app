import 'dart:convert';
import 'package:logging/logging.dart';
import 'package:poke_app/data/services/http_client_service.dart';
import 'package:poke_app/domain/models/pokemons/pokemon_summary.dart';
import 'package:poke_app/domain/models/pokemons/pokemon_summary_basic.dart';
import 'package:poke_app/utils/result/result.dart';

class PokemonRemoteDataSource {
  final HttpClientService _httpClient;
  final _log = Logger('PokemonRemoteDataSource');

  PokemonRemoteDataSource(this._httpClient);

  Future<Result<List<PokemonSummaryBasic>>> getPokemons({
    required int limit,
    required int offset,
  }) async {
    try {
      final response = await _httpClient.get(
        '/api/v2/pokemon',
        queryParameters: {'limit': limit.toString(), 'offset': offset.toString()},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final results = json['results'] as List<dynamic>;

        final pokemons = results
            .map((e) => PokemonSummaryBasic.fromJson(e as Map<String, dynamic>))
            .toList();

        _log.fine('Lista de ${pokemons.length} pokémons carregada com sucesso!');
        return Result.ok(pokemons);
      } else {
        _log.warning('Falha ao carregar lista. Código: ${response.statusCode}');
        // Mantendo a lógica de retornar Exception encapsulada no Result como no seu original
        return Result.error(Exception('Falha ao carregar lista de pokémons.'));
      }
    } catch (error) {
      _log.severe('Erro ao buscar pokémons: $error');
      return Result.error(error is Exception ? error : Exception(error.toString()));
    }
  }

  Future<Result<PokemonSummary>> getPokemonDetailsByUrl(String url) async {
    try {
      final response = await _httpClient.get(url);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final detail = PokemonSummary.fromApiJson(json);

        _log.fine('Detalhes do pokémon ${detail.name} carregados com sucesso!');
        return Result.ok(detail);
      } else {
        _log.warning('Falha ao carregar detalhes do pokémon ($url)');
        return Result.error(Exception('Falha ao carregar detalhes.'));
      }
    } on Exception catch (error) {
      _log.severe('Erro ao carregar detalhes do pokémon: $error');
      return Result.error(error);
    }
  }

  Future<Result<PokemonSummary>> getPokemonDetails(String nameOrId) async {
    try {
      // Unificando a lógica: A API aceita tanto ID quanto Nome na mesma URL
      final response = await _httpClient.get('/api/v2/pokemon/$nameOrId');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final detail = PokemonSummary.fromApiJson(json);

        _log.fine('Detalhes do pokémon ${detail.name} carregados com sucesso!');
        return Result.ok(detail);
      } else {
        _log.warning('Falha ao carregar detalhes ($nameOrId). Código: ${response.statusCode}');
        return Result.error(Exception('Falha ao carregar detalhes.'));
      }
    } catch (error) {
      _log.severe('Erro ao carregar detalhes do pokémon: $error');
      return Result.error(error is Exception ? error : Exception(error.toString()));
    }
  }

  Future<Result<List<PokemonSummaryBasic>>> getPokemonsByType({required String typeName}) async {
    try {
      final response = await _httpClient.get('/api/v2/type/$typeName');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final pokemonList = json['pokemon'] as List<dynamic>;

        final pokemons = pokemonList
            .map((e) => PokemonSummaryBasic.fromJson(e['pokemon'] as Map<String, dynamic>))
            .toList();

        _log.fine('Lista de pokémons do tipo $typeName carregada!');
        return Result.ok(pokemons);
      } else {
        _log.warning('Falha ao carregar por tipo $typeName. Código: ${response.statusCode}');
        return Result.error(Exception('Falha ao carregar pokémons por tipo.'));
      }
    } catch (error) {
      _log.severe('Erro ao buscar pokémons por tipo: $error');
      return Result.error(error is Exception ? error : Exception(error.toString()));
    }
  }
}
