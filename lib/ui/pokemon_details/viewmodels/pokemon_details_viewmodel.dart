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

  /// Retorna a altura formatada em metros (m), usando vírgula como separador decimal.
  String get formattedHeight {
    final heightAsString = pokemon.height.toStringAsFixed(1);
    return '${heightAsString.replaceAll('.', ',')} m';
  }

  /// Retorna o peso formatado em quilogramas (kg), usando vírgula.
  String get formattedWeight {
    final weightAsString = pokemon.weight.toStringAsFixed(1);
    return '${weightAsString.replaceAll('.', ',')} kg';
  }

  /// Retorna apenas a primeira palavra da categoria (ex: "Seed Pokémon" -> "Seed").
  String get formattedCategory {
    if (pokemon.category.isEmpty) return 'Desconhecida';
    return pokemon.category.split(' ').first;
  }

  /// Retorna a primeira habilidade da lista.
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
