// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evolutions_pokemon_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EvolutionsPokemonStore on EvolutionsPokemonStoreBase, Store {
  late final _$pokemonEvolutionStageStateAtom = Atom(
    name: 'EvolutionsPokemonStoreBase.pokemonEvolutionStageState',
    context: context,
  );

  @override
  PokemonEvolutionStageState get pokemonEvolutionStageState {
    _$pokemonEvolutionStageStateAtom.reportRead();
    return super.pokemonEvolutionStageState;
  }

  @override
  set pokemonEvolutionStageState(PokemonEvolutionStageState value) {
    _$pokemonEvolutionStageStateAtom.reportWrite(
      value,
      super.pokemonEvolutionStageState,
      () {
        super.pokemonEvolutionStageState = value;
      },
    );
  }

  late final _$pokemonEvolutionsDetailsAtom = Atom(
    name: 'EvolutionsPokemonStoreBase.pokemonEvolutionsDetails',
    context: context,
  );

  @override
  ObservableMap<String, PokemonDetailsState> get pokemonEvolutionsDetails {
    _$pokemonEvolutionsDetailsAtom.reportRead();
    return super.pokemonEvolutionsDetails;
  }

  @override
  set pokemonEvolutionsDetails(
    ObservableMap<String, PokemonDetailsState> value,
  ) {
    _$pokemonEvolutionsDetailsAtom.reportWrite(
      value,
      super.pokemonEvolutionsDetails,
      () {
        super.pokemonEvolutionsDetails = value;
      },
    );
  }

  late final _$evolutionStagePokemonAsyncAction = AsyncAction(
    'EvolutionsPokemonStoreBase.evolutionStagePokemon',
    context: context,
  );

  @override
  Future<void> evolutionStagePokemon({required String url}) {
    return _$evolutionStagePokemonAsyncAction.run(
      () => super.evolutionStagePokemon(url: url),
    );
  }

  late final _$fetchEvolutionDetailsIfNeededAsyncAction = AsyncAction(
    'EvolutionsPokemonStoreBase.fetchEvolutionDetailsIfNeeded',
    context: context,
  );

  @override
  Future<void> fetchEvolutionDetailsIfNeeded(List<String> names) {
    return _$fetchEvolutionDetailsIfNeededAsyncAction.run(
      () => super.fetchEvolutionDetailsIfNeeded(names),
    );
  }

  @override
  String toString() {
    return '''
pokemonEvolutionStageState: ${pokemonEvolutionStageState},
pokemonEvolutionsDetails: ${pokemonEvolutionsDetails}
    ''';
  }
}
