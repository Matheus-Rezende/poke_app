import 'package:dartz/dartz.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_type_damage_state.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_type_state.dart';

abstract interface class TypesPokemonRepository {
  Future<Either<ErrorPokemonTypeState, SuccessPokemonTypeState>> fetchTypePokemons({
    required String pokemonType,
  });
  Future<Either<ErrorPokemonTypeDamageState, SuccessPokemonTypeDamageState>> fetchPokemonTypeDamageByUrl({
    required String url,
  });
}
