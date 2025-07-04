import 'package:poke_app/app/modules/pokedex/data/models/pokemon_details/pokemon_details_model.dart';

sealed class PokemonDetailsState {
  final PokemonDetailsModel pokemon;
  PokemonDetailsState({required this.pokemon});

  InitPokemonDetailsState init() {
    return InitPokemonDetailsState();
  }

  ErrorPokemonDetailsState error({required String message}) {
    return ErrorPokemonDetailsState(message: message);
  }

  SuccessPokemonDetailsState success({PokemonDetailsModel? pokemon}) {
    return SuccessPokemonDetailsState(pokemon: pokemon ?? this.pokemon);
  }

  LoadingPokemonDetailsState loading() {
    return LoadingPokemonDetailsState();
  }
}

class SuccessPokemonDetailsState extends PokemonDetailsState {
  SuccessPokemonDetailsState({required super.pokemon});
}

class LoadingPokemonDetailsState extends PokemonDetailsState {
  LoadingPokemonDetailsState() : super(pokemon: PokemonDetailsModel());
}

class InitPokemonDetailsState extends PokemonDetailsState {
  InitPokemonDetailsState() : super(pokemon: PokemonDetailsModel());
}

class ErrorPokemonDetailsState extends PokemonDetailsState {
  final String message;
  ErrorPokemonDetailsState({required this.message}) : super(pokemon: PokemonDetailsModel());
}
