import 'package:flutter/material.dart';
import 'package:poke_app/data/repositories/pokedex/pokedex_repository.dart';
import 'package:poke_app/domain/models/pokemon/pokemon.dart';
import 'package:poke_app/utils/commands/commands.dart';
import 'package:poke_app/utils/result/result.dart';
// ... outras importações

class PokedexViewmodel extends ChangeNotifier {
  PokedexViewmodel({required PokedexRepository pokedexRepository})
    : _pokedexRepository = pokedexRepository {
    load = Command0(_initialLoad)..execute();
    loadMore = Command0(_loadMore);
  }

  final PokedexRepository _pokedexRepository;

  List<Pokemon> _pokedex = [];
  List<Pokemon> get pokedex => _pokedex;

  static const _pageSize = 20;
  int _offset = 0;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  late final Command0<List<Pokemon>> load;
  late final Command0<List<Pokemon>> loadMore;

  Future<Result<List<Pokemon>>> _initialLoad() async {
    _offset = 0;
    _hasMore = true;

    final result = await _pokedexRepository.get(limit: _pageSize, offset: _offset);

    if (result is Ok<List<Pokemon>>) {
      final newPokemons = result.value;
      _pokedex = newPokemons;
      _offset += newPokemons.length;
      _hasMore = newPokemons.length == _pageSize;
      notifyListeners();
    }
    return result;
  }

  Future<Result<List<Pokemon>>> _loadMore() async {
    if (load.running || !_hasMore) {
      return Result.ok([]);
    }

    final result = await _pokedexRepository.get(limit: _pageSize, offset: _offset);

    if (result is Ok<List<Pokemon>>) {
      final newPokemons = result.value;
      _pokedex.addAll(newPokemons);
      _offset += newPokemons.length;
      _hasMore = newPokemons.length == _pageSize;
      notifyListeners();
    }
    return result;
  }
}
