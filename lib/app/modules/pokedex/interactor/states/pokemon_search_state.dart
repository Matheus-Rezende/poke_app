import 'package:poke_app/app/modules/pokedex/data/models/pokemon_search_model.dart';

sealed class PokemonSearchState {
  final PokemonSearchModel pokemon;
  PokemonSearchState({required this.pokemon});

  InitPokemonSearchState init() {
    return InitPokemonSearchState();
  }

  ErrorPokemonSearchState error({required String message}) {
    return ErrorPokemonSearchState(message: message);
  }

  SuccessPokemonSearchState success({PokemonSearchModel? pokemon}) {
    return SuccessPokemonSearchState(pokemon: pokemon ?? this.pokemon);
  }

  LoadingPokemonSearchState loading() {
    return LoadingPokemonSearchState();
  }
}

class SuccessPokemonSearchState extends PokemonSearchState {
  SuccessPokemonSearchState({required super.pokemon});
}

class LoadingPokemonSearchState extends PokemonSearchState {
  LoadingPokemonSearchState()
    : super(
        pokemon: PokemonSearchModel(id: 0, imageUrl: '', name: '', types: []),
      );
}

class InitPokemonSearchState extends PokemonSearchState {
  InitPokemonSearchState()
    : super(
        pokemon: PokemonSearchModel(id: 0, imageUrl: '', name: '', types: []),
      );
}

class ErrorPokemonSearchState extends PokemonSearchState {
  final String message;
  ErrorPokemonSearchState({required this.message})
    : super(
        pokemon: PokemonSearchModel(id: 0, imageUrl: '', name: '', types: []),
      );
}
