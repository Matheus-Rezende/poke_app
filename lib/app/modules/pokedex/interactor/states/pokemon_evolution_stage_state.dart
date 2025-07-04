import 'package:poke_app/app/modules/pokedex/data/models/pokemon_details/pokemon_evolution_stage_model.dart';

sealed class PokemonEvolutionStageState {
  final List<PokemonEvolutionStageModel> evolutions;
  PokemonEvolutionStageState({required this.evolutions});

  InitPokemonEvolutionStageState init() {
    return InitPokemonEvolutionStageState();
  }

  ErrorPokemonEvolutionStageState error({required String message}) {
    return ErrorPokemonEvolutionStageState(message: message);
  }

  SuccessPokemonEvolutionStageState success({List<PokemonEvolutionStageModel>? evolutions}) {
    return SuccessPokemonEvolutionStageState(evolutions: evolutions ?? this.evolutions);
  }

  LoadingPokemonEvolutionStageState loading() {
    return LoadingPokemonEvolutionStageState();
  }
}

class SuccessPokemonEvolutionStageState extends PokemonEvolutionStageState {
  SuccessPokemonEvolutionStageState({required super.evolutions});
}

class LoadingPokemonEvolutionStageState extends PokemonEvolutionStageState {
  LoadingPokemonEvolutionStageState() : super(evolutions: []);
}

class InitPokemonEvolutionStageState extends PokemonEvolutionStageState {
  InitPokemonEvolutionStageState() : super(evolutions: []);
}

class ErrorPokemonEvolutionStageState extends PokemonEvolutionStageState {
  final String message;
  ErrorPokemonEvolutionStageState({required this.message}) : super(evolutions: []);
}
