import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:poke_app/data/repositories/pokedex/pokedex_repository.dart';
import 'package:poke_app/domain/models/pokemon/pokemon_summary.dart';
import 'package:poke_app/utils/commands/commands.dart';
import 'package:poke_app/utils/result/result.dart';

class PokedexViewmodel extends ChangeNotifier {
  PokedexViewmodel({required PokedexRepository pokedexRepository})
    : _pokedexRepository = pokedexRepository {
    load = Command0(_initialLoad)..execute();
    loadMore = Command0(_loadMore);
  }

  final PokedexRepository _pokedexRepository;

  List<PokemonSummary> _pokedex = [];
  List<PokemonSummary> get pokedex => _pokedex;

  static const _pageSize = 20;
  int _offset = 0;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  late final Command0<List<PokemonSummary>> load;
  late final Command0<List<PokemonSummary>> loadMore;

  final _log = Logger('PokedexViewModel');

  Future<Result<List<PokemonSummary>>> _initialLoad() async {
    try {
      _offset = 0;
      _hasMore = true;

      final result = await _pokedexRepository.get(limit: _pageSize, offset: _offset);

      switch (result) {
        case Ok<List<PokemonSummary>>():
          final newPokemons = result.value;
          _pokedex = newPokemons;
          _offset += newPokemons.length;
          _hasMore = newPokemons.length == _pageSize;
          _log.fine('Pokemons iniciais carregados com sucesso!');
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (error, stacktrace) {
      _log.warning('Falha ao carregar os pokemons iniciais:', error, stacktrace);
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  Future<Result<List<PokemonSummary>>> _loadMore() async {
    try {
      if (load.running || !_hasMore) {
        return Result.ok([]);
      }

      final result = await _pokedexRepository.get(limit: _pageSize, offset: _offset);

      switch (result) {
        case Ok<List<PokemonSummary>>():
          final newPokemons = result.value;
          _pokedex.addAll(newPokemons);
          _offset += newPokemons.length;
          _hasMore = newPokemons.length == _pageSize;
          _log.fine('Mais pokémons carregados com sucesso!');
          break;
        case Error():
          _log.warning('Falha ao carregar mais pokémons:', result.error);
          break;
      }
      return result;
    } on Exception catch (error, stacktrace) {
      _log.warning('Falha ao carregar mais pokémons:', error, stacktrace);
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }
}
