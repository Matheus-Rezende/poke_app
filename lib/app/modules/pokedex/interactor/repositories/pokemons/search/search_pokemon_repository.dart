import 'package:dartz/dartz.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_search_state.dart';

abstract interface class SearchPokemonRepository {
  Future<Either<ErrorPokemonSearchState, SuccessPokemonSearchState>> searchPokemon({
    required String pokemonName,
  });
}
