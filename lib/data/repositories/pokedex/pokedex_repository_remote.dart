import 'package:logging/logging.dart';
import 'package:poke_app/data/services/api/api_client.dart';
import 'package:poke_app/data/services/api/model/pokedex/pokemon_detail_api_model.dart';
import 'package:poke_app/data/services/api/model/pokedex/pokemon_summary_api_model.dart';
import 'package:poke_app/domain/models/pokemons/pokemon_summary.dart';
import 'package:poke_app/utils/result/result.dart';

import 'pokedex_repository.dart';

class PokedexRepositoryRemote implements PokedexRepository {
  PokedexRepositoryRemote({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;
  final _log = Logger('PokedexRepositoryRemote');

  final Map<String, PokemonDetailApiModel> _cachedPokemons = {};

  @override
  Future<Result<List<PokemonSummary>>> getPokemons({
    required int limit,
    required int offset,
  }) async {
    try {
      final listResult = await _apiClient.getPokemons(limit: limit, offset: offset);
      if (listResult is Error<List<PokemonSummaryApiModel>>) {
        return Result.error(listResult.error);
      }
      final summaries = listResult.asOk.value;

      // Buscar detalhes em paralelo
      final futures = summaries.map((summary) async {
        final detailsResult = await _apiClient.getPokemonDetailsByUrl(summary.url);

        switch (detailsResult) {
          case Error<PokemonDetailApiModel>():
            _log.warning('Erro ao buscar detalhes de ${summary.name}');
            return null;
          case Ok<PokemonDetailApiModel>():
            final details = detailsResult.value;
            return PokemonSummary(
              id: details.id,
              name: details.name,
              image: details.imageUrl,
              types: details.types,
            );
        }
      });

      final pokemons = (await Future.wait(futures)).whereType<PokemonSummary>().toList();
      return Result.ok(pokemons);
    } on Exception catch (error) {
      _log.severe('Erro no repositório: $error');
      return Result.error(error);
    }
  }

  @override
  Future<Result<List<PokemonSummary>>> getPokemonsByType({
    required String typeName,
    required int limit,
    required int offset,
  }) async {
    try {
      final listResult = await _apiClient.getPokemonsByType(typeName: typeName);

      if (listResult is Error<List<PokemonSummaryApiModel>>) {
        return Result.error(listResult.error);
      }

      final allPokemons = listResult.asOk.value;

      final paginatedList = allPokemons.skip(offset).take(limit).toList();

      final futures = paginatedList.map((summary) async {
        final detailsResult = await _apiClient.getPokemonDetailsByUrl(summary.url);

        switch (detailsResult) {
          case Error<PokemonDetailApiModel>():
            _log.warning('Erro ao buscar detalhes de ${summary.name}');
            return null;

          case Ok<PokemonDetailApiModel>():
            final details = detailsResult.value;
            return PokemonSummary(
              id: details.id,
              name: details.name,
              image: details.imageUrl,
              types: details.types,
            );
        }
      });

      final pokemons = (await Future.wait(futures)).whereType<PokemonSummary>().toList();

      _log.fine(
        'Página carregada: ${pokemons.length} pokémons do tipo $typeName (offset=$offset, limit=$limit)',
      );

      return Result.ok(pokemons);
    } on Exception catch (error) {
      _log.severe('Erro no repositório ao buscar pokémons por tipo: $error');
      return Result.error(error);
    }
  }

  @override
  Future<Result<PokemonSummary>> searchPokemon(String query) async {
    try {
      final result = await _apiClient.getPokemonDetailsByQuery(query);

      switch (result) {
        case Ok<PokemonDetailApiModel>():
          final details = result.value;
          _cachedPokemons[query] = details;
          return Result.ok(
            PokemonSummary(
              id: details.id,
              name: details.name,
              image: details.imageUrl,
              types: details.types,
            ),
          );
        default:
          if (result is Error<PokemonDetailApiModel>) {
            return Result.error(result.error);
          }
          return Result.error(Exception('Resultado inesperado ao buscar pokémon'));
      }
    } on Exception catch (error) {
      _log.severe('Erro no repositório ao buscar pokémon: $error');
      return Result.error(error);
    }
  }
}
