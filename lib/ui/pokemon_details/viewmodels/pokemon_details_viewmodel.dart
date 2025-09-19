import 'package:flutter/material.dart';
import 'package:poke_app/data/repositories/pokedex/pokedex_repository.dart';
import 'package:poke_app/domain/models/pokemon/pokemon_detail.dart';
import 'package:poke_app/utils/commands/commands.dart';
import 'package:poke_app/utils/result/result.dart';

class PokemonDetailsViewmodel extends ChangeNotifier {
  PokemonDetailsViewmodel({required PokedexRepository pokedexRepository})
    : _pokedexRepository = pokedexRepository {
    load = Command1(_load);
  }

  final PokedexRepository _pokedexRepository;

  late final Command1<PokemonDetail, String> load;

  late PokemonDetail _pokemon;
  PokemonDetail get pokemon => _pokemon;

  Future<Result<PokemonDetail>> _load(String pokemonName) async {
    try {
      final result = await _pokedexRepository.getPokemonByName(pokemonName);
      switch (result) {
        case Ok<PokemonDetail>():
          _pokemon = result.value;
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }
}
