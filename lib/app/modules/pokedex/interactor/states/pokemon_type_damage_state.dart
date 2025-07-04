import 'package:poke_app/app/modules/pokedex/data/models/pokemon_details/pokemon_type_damage_model.dart';

sealed class PokemonTypeDamageState {
  final PokemonTypeDamageModel typeDamage;
  PokemonTypeDamageState({required this.typeDamage});

  InitPokemonTypeDamageState init() {
    return InitPokemonTypeDamageState();
  }

  ErrorPokemonTypeDamageState error({required String message}) {
    return ErrorPokemonTypeDamageState(message: message);
  }

  SuccessPokemonTypeDamageState success({PokemonTypeDamageModel? typeDamage}) {
    return SuccessPokemonTypeDamageState(typeDamage: typeDamage ?? this.typeDamage);
  }

  LoadingPokemonTypeDamageState loading() {
    return LoadingPokemonTypeDamageState();
  }
}

class SuccessPokemonTypeDamageState extends PokemonTypeDamageState {
  SuccessPokemonTypeDamageState({required super.typeDamage});
}

class LoadingPokemonTypeDamageState extends PokemonTypeDamageState {
  LoadingPokemonTypeDamageState() : super(typeDamage: PokemonTypeDamageModel());
}

class InitPokemonTypeDamageState extends PokemonTypeDamageState {
  InitPokemonTypeDamageState() : super(typeDamage: PokemonTypeDamageModel());
}

class ErrorPokemonTypeDamageState extends PokemonTypeDamageState {
  final String message;
  ErrorPokemonTypeDamageState({required this.message}) : super(typeDamage: PokemonTypeDamageModel());
}
