import 'package:poke_app/app/modules/pokedex/data/models/pokemons_model.dart';

sealed class PokemonTypeState {
  final List<PokemonsModel> pokemons;
  final List<String>? types;
  PokemonTypeState({required this.pokemons, this.types});

  InitPokemonTypeState init() {
    return InitPokemonTypeState();
  }

  ErrorPokemonTypeState error({required String message}) {
    return ErrorPokemonTypeState(message: message);
  }

  SuccessPokemonTypeState success({List<PokemonsModel>? pokemons, List<String>? types}) {
    return SuccessPokemonTypeState(pokemons: pokemons ?? this.pokemons, types: types ?? this.types);
  }

  LoadingPokemonTypeState loading() {
    return LoadingPokemonTypeState();
  }
}

class SuccessPokemonTypeState extends PokemonTypeState {
  SuccessPokemonTypeState({required super.pokemons, super.types});
}

class LoadingPokemonTypeState extends PokemonTypeState {
  LoadingPokemonTypeState() : super(pokemons: []);
}

class InitPokemonTypeState extends PokemonTypeState {
  InitPokemonTypeState() : super(pokemons: []);
}

class ErrorPokemonTypeState extends PokemonTypeState {
  final String message;
  ErrorPokemonTypeState({required this.message}) : super(pokemons: []);
}
