import 'package:poke_app/app/modules/pokedex/data/models/pokemons_model.dart';

sealed class PokemonState {
  final List<PokemonsModel> pokemons;
  final List<String>? types;
  PokemonState({required this.pokemons, this.types});

  InitPokemonState init() {
    return InitPokemonState();
  }

  ErrorPokemonState error({required String message}) {
    return ErrorPokemonState(message: message);
  }

  SuccessPokemonState success({List<PokemonsModel>? pokemons, List<String>? types}) {
    return SuccessPokemonState(pokemons: pokemons ?? this.pokemons, types: types ?? this.types);
  }

  LoadingPokemonState loading() {
    return LoadingPokemonState();
  }
}

class SuccessPokemonState extends PokemonState {
  SuccessPokemonState({required super.pokemons, super.types});
}

class LoadingPokemonState extends PokemonState {
  LoadingPokemonState() : super(pokemons: []);
}

class InitPokemonState extends PokemonState {
  InitPokemonState() : super(pokemons: []);
}

class ErrorPokemonState extends PokemonState {
  final String message;
  ErrorPokemonState({required this.message}) : super(pokemons: []);
}
