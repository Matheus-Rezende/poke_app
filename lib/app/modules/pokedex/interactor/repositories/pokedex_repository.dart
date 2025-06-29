import 'package:dartz/dartz.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_search_state.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_state.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_type_state.dart';

abstract interface class PokedexRepository {
  Future<Either<ErrorPokemonState, SuccessPokemonState>> fetchPokemons({int limit = 20, required int offset});
  Future<Either<ErrorPokemonSearchState, SuccessPokemonSearchState>> searchPokemon({
    required String pokemonName,
  });
  Future<Either<ErrorPokemonTypeState, SuccessPokemonTypeState>> fetchTypePokemons({
    required String pokemonType,
  });
}
