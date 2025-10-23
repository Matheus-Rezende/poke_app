import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:poke_app/data/repositories/pokedex/pokedex_repository.dart';
import 'package:poke_app/domain/models/pokemon/pokemon_summary.dart';
import 'package:poke_app/ui/core/themes/colors.dart';
import 'package:poke_app/utils/commands/commands.dart';
import 'package:poke_app/utils/result/result.dart';

class TypesPokemonViewmodel extends ChangeNotifier {
  TypesPokemonViewmodel({required PokedexRepository pokedexRepository})
    : _pokedexRepository = pokedexRepository {
    load = Command1(_initialLoadByType);
    loadMore = Command0(_loadMoreByType);
  }

  final PokedexRepository _pokedexRepository;
  final _log = Logger('TypesPokemonViewmodel');

  String _pokemonTypeText = 'All types';
  String get pokemonTypeText => _pokemonTypeText;
  Color _pokemonTypeColor = AppColors.grey5;
  Color get pokemonTypeColor => _pokemonTypeColor;
  bool _hasSelectType = false;
  bool get hasSelectType => _hasSelectType;

  List<PokemonSummary> _pokemonsByType = [];
  List<PokemonSummary> get pokemonsByType => _pokemonsByType;

  static const _pageSize = 20;
  int _filteredOffset = 0;
  bool _filteredHasMore = true;
  bool get filteredHasMore => _filteredHasMore;

  late final Command1<List<PokemonSummary>, String> load;
  late final Command0<List<PokemonSummary>> loadMore;

  Future<Result<List<PokemonSummary>>> _initialLoadByType(String type) async {
    _hasSelectType = true;
    _filteredOffset = 0;
    _filteredHasMore = true;
    _pokemonsByType = [];

    try {
      final result = await _pokedexRepository.getPokemonsByType(
        typeName: type,
        limit: _pageSize,
        offset: _filteredOffset,
      );

      switch (result) {
        case Ok<List<PokemonSummary>>():
          final newPokemons = result.value;
          _pokemonsByType = newPokemons;
          _filteredOffset += newPokemons.length;
          _filteredHasMore = newPokemons.length == _pageSize;
          _log.fine('Primeira página do tipo $type carregada com sucesso!');
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (error, stacktrace) {
      _log.warning('Falha ao carregar os pokemons:', error, stacktrace);
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  Future<Result<List<PokemonSummary>>> _loadMoreByType() async {
    if (load.running || !_filteredHasMore) {
      return Result.ok([]);
    }

    try {
      final result = await _pokedexRepository.getPokemonsByType(
        typeName: _pokemonTypeText,
        limit: _pageSize,
        offset: _filteredOffset,
      );
      switch (result) {
        case Ok<List<PokemonSummary>>():
          final newPokemons = result.value;
          _pokemonsByType.addAll(newPokemons);
          _filteredOffset += newPokemons.length;
          _filteredHasMore = newPokemons.length == _pageSize;
          _log.fine('Mais pokémons do tipo $_pokemonTypeText carregados com sucesso!');
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (error, stacktrace) {
      _log.warning(
        'Erro inesperado ao carregar mais pokémons do tipo $_pokemonTypeText:',
        error,
        stacktrace,
      );

      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }

  set pokemonTypeText(String type) {
    if (_pokemonTypeText != type) {
      _pokemonTypeText = type;
      notifyListeners();
    }
  }

  set pokemonTypeColor(Color color) {
    if (_pokemonTypeColor != color) {
      _pokemonTypeColor = color;
      notifyListeners();
    }
  }

  void selectAllTypes() {
    pokemonTypeText = 'All types';
    pokemonTypeColor = AppColors.grey5;
    _hasSelectType = false;
    _pokemonsByType = [];
    _filteredOffset = 0;
    _filteredHasMore = true;
    notifyListeners();
  }
}
