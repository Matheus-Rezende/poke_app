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

  late final Command1<PokemonDetail, String> load;

  late PokemonDetail _pokemon;
  PokemonDetail get pokemon => _pokemon;

  String get formattedNumber {
    return 'N°${pokemon.id.toString().padLeft(3, '0')}';
  }

  String get formattedDescription {
    return pokemon.description.replaceAll('\n', ' ').replaceAll('\f', ' ');
  }

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

  double get femalePercentage {
    final femaleRate = (pokemon.genderRate / 8.0) * 100.0;
    return femaleRate;
  }

  double get malePercentage {
    final femaleRate = (pokemon.genderRate / 8.0) * 100.0;
    final maleRate = 100.0 - femaleRate;
    return maleRate;
  }

  bool get isGenderUnknown => pokemon.genderRate == -1;

  Future<Result<PokemonDetail>> _load(String pokemon) async {
    try {
      final result = await _pokedexRepository.getPokemonDetailById(pokemon);
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
