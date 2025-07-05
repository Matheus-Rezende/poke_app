import 'package:poke_app/app/modules/pokedex/data/models/pokemons_model.dart';

sealed class PokemonSearchState {
  final PokemonsModel pokemon;
  PokemonSearchState({required this.pokemon});

  InitPokemonSearchState init() {
    return InitPokemonSearchState();
  }

  ErrorPokemonSearchState error({required String message}) {
    return ErrorPokemonSearchState(message: message);
  }

  SuccessPokemonSearchState success({PokemonsModel? pokemon}) {
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
        pokemon: PokemonsModel(id: 0, imageUrl: '', name: '', types: [], url: ''),
      );
}

class InitPokemonSearchState extends PokemonSearchState {
  InitPokemonSearchState()
    : super(
        pokemon: PokemonsModel(id: 0, imageUrl: '', name: '', types: [], url: ''),
      );
}

class ErrorPokemonSearchState extends PokemonSearchState {
  final String message;
  ErrorPokemonSearchState({required this.message})
    : super(
        pokemon: PokemonsModel(id: 0, imageUrl: '', name: '', types: [], url: ''),
      );
}
