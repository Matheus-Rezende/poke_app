import 'package:flutter/material.dart';
import 'package:poke_app/data/repositories/pokedex/pokedex_repository.dart';
import 'package:poke_app/domain/models/pokemon/pokemon_detail.dart';
import 'package:poke_app/utils/commands/commands.dart';
import 'package:poke_app/utils/extensions/string_casting_extension.dart';
import 'package:poke_app/utils/result/result.dart';

class PokemonDetailsViewmodel extends ChangeNotifier {
  PokemonDetailsViewmodel({required PokedexRepository pokedexRepository})
    : _pokedexRepository = pokedexRepository {
    load = Command1(_load);
  }

  final PokedexRepository _pokedexRepository;

  late final Command1<PokemonDetail, int> load;

  late PokemonDetail _pokemon;
  PokemonDetail get pokemon => _pokemon;

  String get formattedHeight {
    final heightToDouble = pokemon.height / 10.0;
    final heightAsString = heightToDouble.toStringAsFixed(1);
    return '${heightAsString.replaceAll('.', ',')} m';
  }

  String get formattedWeight {
    final weightToDouble = pokemon.weight / 10.0;
    final weightAsString = weightToDouble.toStringAsFixed(1);
    return '${weightAsString.replaceAll('.', ',')} kg';
  }

  String get formattedCategory {
    if (pokemon.category.isEmpty) return 'Desconhecida';
    return pokemon.category.split(' ').first;
  }

  String get firstAbility {
    if (pokemon.abilities.isEmpty) return 'Nenhuma';
    return pokemon.abilities.first.toCapitalized;
  }

  Future<Result<PokemonDetail>> _load(int pokemonId) async {
    try {
      final result = await _pokedexRepository.getPokemonDetailById(pokemonId);
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
