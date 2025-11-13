import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:poke_app/data/repositories/pokedex/pokedex_repository.dart';
import 'package:poke_app/domain/models/pokemons/pokemon_summary.dart';
import 'package:poke_app/utils/commands/commands.dart';
import 'package:poke_app/utils/result/result.dart';

class SearchPokemonViewmodel extends ChangeNotifier {
  SearchPokemonViewmodel({required PokedexRepository pokedexRepository})
    : _pokedexRepository = pokedexRepository {
    load = Command1(_search);
  }

  final PokedexRepository _pokedexRepository;

  PokemonSummary? _pokemon;
  PokemonSummary? get pokemon => _pokemon;

  String _searchText = '';
  String get searchText => _searchText;

  set searchText(String query) {
    if (_searchText != query) {
      _searchText = query;
    }
  }

  late final Command1<PokemonSummary, String> load;

  Timer? debounceSearch;

  final _log = Logger('SearchPokemonViewmodel');

  Future<Result<PokemonSummary>> _search(String query) async {
    try {
      final result = await _pokedexRepository.searchPokemon(query);

      switch (result) {
        case Ok<PokemonSummary>():
          _log.fine('Pokemon ${result.value.name} encontrado com sucesso!');
          _pokemon = result.value;
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (error, stacktrace) {
      _log.warning('Falha ao carregar o pokemon:', error, stacktrace);
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }
}
