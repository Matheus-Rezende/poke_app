import 'package:dartz/dartz.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_description_state.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_details_state.dart';

abstract interface class InformationsPokemonRepository {
  Future<Either<ErrorPokemonDetailsState, SuccessPokemonDetailsState>> fetchPokemonDetails({
    required String pokemon,
  });
  Future<Either<ErrorPokemonDescriptionState, SuccessPokemonDescriptionState>> fetchPokemonDescription({
    required String pokemon,
  });
}
