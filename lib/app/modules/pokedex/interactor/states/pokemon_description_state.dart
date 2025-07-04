import 'package:poke_app/app/modules/pokedex/data/models/pokemon_details/pokemon_description_model.dart';

sealed class PokemonDescriptionState {
  final PokemonDescriptionModel description;
  PokemonDescriptionState({required this.description});

  InitPokemonDescriptionState init() {
    return InitPokemonDescriptionState();
  }

  ErrorPokemonDescriptionState error({required String message}) {
    return ErrorPokemonDescriptionState(message: message);
  }

  SuccessPokemonDescriptionState success({PokemonDescriptionModel? description}) {
    return SuccessPokemonDescriptionState(description: description ?? this.description);
  }

  LoadingPokemonDescriptionState loading() {
    return LoadingPokemonDescriptionState();
  }
}

class SuccessPokemonDescriptionState extends PokemonDescriptionState {
  SuccessPokemonDescriptionState({required super.description});
}

class LoadingPokemonDescriptionState extends PokemonDescriptionState {
  LoadingPokemonDescriptionState() : super(description: PokemonDescriptionModel());
}

class InitPokemonDescriptionState extends PokemonDescriptionState {
  InitPokemonDescriptionState() : super(description: PokemonDescriptionModel());
}

class ErrorPokemonDescriptionState extends PokemonDescriptionState {
  final String message;
  ErrorPokemonDescriptionState({required this.message}) : super(description: PokemonDescriptionModel());
}
