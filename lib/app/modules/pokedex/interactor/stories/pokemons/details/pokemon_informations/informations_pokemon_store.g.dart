// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'informations_pokemon_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$InformationsPokemonStore on InformationsPokemonStoreBase, Store {
  Computed<bool>? _$isSuccessMainDetailsComputed;

  @override
  bool get isSuccessMainDetails =>
      (_$isSuccessMainDetailsComputed ??= Computed<bool>(
        () => super.isSuccessMainDetails,
        name: 'InformationsPokemonStoreBase.isSuccessMainDetails',
      )).value;
  Computed<bool>? _$isErrorMainDetailsComputed;

  @override
  bool get isErrorMainDetails =>
      (_$isErrorMainDetailsComputed ??= Computed<bool>(
        () => super.isErrorMainDetails,
        name: 'InformationsPokemonStoreBase.isErrorMainDetails',
      )).value;
  Computed<bool>? _$isLoadingMainDetailsComputed;

  @override
  bool get isLoadingMainDetails =>
      (_$isLoadingMainDetailsComputed ??= Computed<bool>(
        () => super.isLoadingMainDetails,
        name: 'InformationsPokemonStoreBase.isLoadingMainDetails',
      )).value;

  late final _$pokemonDetailsStateAtom = Atom(
    name: 'InformationsPokemonStoreBase.pokemonDetailsState',
    context: context,
  );

  @override
  PokemonDetailsState get pokemonDetailsState {
    _$pokemonDetailsStateAtom.reportRead();
    return super.pokemonDetailsState;
  }

  @override
  set pokemonDetailsState(PokemonDetailsState value) {
    _$pokemonDetailsStateAtom.reportWrite(value, super.pokemonDetailsState, () {
      super.pokemonDetailsState = value;
    });
  }

  late final _$pokemonDescriptionStateAtom = Atom(
    name: 'InformationsPokemonStoreBase.pokemonDescriptionState',
    context: context,
  );

  @override
  PokemonDescriptionState get pokemonDescriptionState {
    _$pokemonDescriptionStateAtom.reportRead();
    return super.pokemonDescriptionState;
  }

  @override
  set pokemonDescriptionState(PokemonDescriptionState value) {
    _$pokemonDescriptionStateAtom.reportWrite(
      value,
      super.pokemonDescriptionState,
      () {
        super.pokemonDescriptionState = value;
      },
    );
  }

  late final _$detailsPokemonAsyncAction = AsyncAction(
    'InformationsPokemonStoreBase.detailsPokemon',
    context: context,
  );

  @override
  Future<void> detailsPokemon({required String pokemon}) {
    return _$detailsPokemonAsyncAction.run(
      () => super.detailsPokemon(pokemon: pokemon),
    );
  }

  late final _$descriptionPokemonAsyncAction = AsyncAction(
    'InformationsPokemonStoreBase.descriptionPokemon',
    context: context,
  );

  @override
  Future<void> descriptionPokemon({required String pokemon}) {
    return _$descriptionPokemonAsyncAction.run(
      () => super.descriptionPokemon(pokemon: pokemon),
    );
  }

  @override
  String toString() {
    return '''
pokemonDetailsState: ${pokemonDetailsState},
pokemonDescriptionState: ${pokemonDescriptionState},
isSuccessMainDetails: ${isSuccessMainDetails},
isErrorMainDetails: ${isErrorMainDetails},
isLoadingMainDetails: ${isLoadingMainDetails}
    ''';
  }
}
