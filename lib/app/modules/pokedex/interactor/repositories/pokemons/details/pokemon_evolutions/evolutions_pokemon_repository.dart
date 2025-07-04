import 'package:dartz/dartz.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_evolution_stage_state.dart';

abstract interface class EvolutionsPokemonRepository {
  Future<Either<ErrorPokemonEvolutionStageState, SuccessPokemonEvolutionStageState>>
  fetchPokemonPokemonEvolutionsByUrl({required String url});
}
