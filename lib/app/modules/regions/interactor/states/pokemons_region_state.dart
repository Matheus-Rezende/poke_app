import 'package:poke_app/app/modules/pokedex/data/models/pokemons_model.dart';

sealed class PokemonsRegionState {
  final List<PokemonsModel> pokemons;
  PokemonsRegionState({required this.pokemons});

  InitPokemonsRegionState init() {
    return InitPokemonsRegionState();
  }

  ErrorPokemonsRegionState error({required String message}) {
    return ErrorPokemonsRegionState(message: message);
  }

  SuccessPokemonsRegionState success({List<PokemonsModel>? pokemons}) {
    return SuccessPokemonsRegionState(pokemons: pokemons ?? this.pokemons);
  }

  LoadingPokemonsRegionState loading() {
    return LoadingPokemonsRegionState();
  }
}

class SuccessPokemonsRegionState extends PokemonsRegionState {
  SuccessPokemonsRegionState({required super.pokemons});
}

class LoadingPokemonsRegionState extends PokemonsRegionState {
  LoadingPokemonsRegionState() : super(pokemons: []);
}

class InitPokemonsRegionState extends PokemonsRegionState {
  InitPokemonsRegionState() : super(pokemons: []);
}

class ErrorPokemonsRegionState extends PokemonsRegionState {
  final String message;
  ErrorPokemonsRegionState({required this.message}) : super(pokemons: []);
}
