import 'package:dartz/dartz.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_state.dart';

abstract interface class PokemonsRepository {
  Future<Either<ErrorPokemonState, SuccessPokemonState>> fetchPokemons({int limit = 20, required int offset});
}
