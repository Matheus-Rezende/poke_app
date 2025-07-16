// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemons_type_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PokemonsTypeStore on PokemonsTypeStoreBase, Store {
  Computed<String>? _$messageTypeErrorComputed;

  @override
  String get messageTypeError =>
      (_$messageTypeErrorComputed ??= Computed<String>(
        () => super.messageTypeError,
        name: 'PokemonsTypeStoreBase.messageTypeError',
      )).value;
  Computed<bool>? _$showTypeListComputed;

  @override
  bool get showTypeList => (_$showTypeListComputed ??= Computed<bool>(
    () => super.showTypeList,
    name: 'PokemonsTypeStoreBase.showTypeList',
  )).value;
  Computed<bool>? _$showTypeErrorComputed;

  @override
  bool get showTypeError => (_$showTypeErrorComputed ??= Computed<bool>(
    () => super.showTypeError,
    name: 'PokemonsTypeStoreBase.showTypeError',
  )).value;
  Computed<bool>? _$showTypeLoadingComputed;

  @override
  bool get showTypeLoading => (_$showTypeLoadingComputed ??= Computed<bool>(
    () => super.showTypeLoading,
    name: 'PokemonsTypeStoreBase.showTypeLoading',
  )).value;

  late final _$pokemonTypeStateAtom = Atom(
    name: 'PokemonsTypeStoreBase.pokemonTypeState',
    context: context,
  );

  @override
  PokemonTypeState get pokemonTypeState {
    _$pokemonTypeStateAtom.reportRead();
    return super.pokemonTypeState;
  }

  @override
  set pokemonTypeState(PokemonTypeState value) {
    _$pokemonTypeStateAtom.reportWrite(value, super.pokemonTypeState, () {
      super.pokemonTypeState = value;
    });
  }

  late final _$isFilterTypeSelectedAtom = Atom(
    name: 'PokemonsTypeStoreBase.isFilterTypeSelected',
    context: context,
  );

  @override
  bool get isFilterTypeSelected {
    _$isFilterTypeSelectedAtom.reportRead();
    return super.isFilterTypeSelected;
  }

  @override
  set isFilterTypeSelected(bool value) {
    _$isFilterTypeSelectedAtom.reportWrite(
      value,
      super.isFilterTypeSelected,
      () {
        super.isFilterTypeSelected = value;
      },
    );
  }

  late final _$textButtonTypePokemonsAtom = Atom(
    name: 'PokemonsTypeStoreBase.textButtonTypePokemons',
    context: context,
  );

  @override
  String get textButtonTypePokemons {
    _$textButtonTypePokemonsAtom.reportRead();
    return super.textButtonTypePokemons;
  }

  @override
  set textButtonTypePokemons(String value) {
    _$textButtonTypePokemonsAtom.reportWrite(
      value,
      super.textButtonTypePokemons,
      () {
        super.textButtonTypePokemons = value;
      },
    );
  }

  late final _$pokemonsAtom = Atom(
    name: 'PokemonsTypeStoreBase.pokemons',
    context: context,
  );

  @override
  ObservableList<PokemonsModel> get pokemons {
    _$pokemonsAtom.reportRead();
    return super.pokemons;
  }

  @override
  set pokemons(ObservableList<PokemonsModel> value) {
    _$pokemonsAtom.reportWrite(value, super.pokemons, () {
      super.pokemons = value;
    });
  }

  late final _$isLoadingPokemonTypesAtom = Atom(
    name: 'PokemonsTypeStoreBase.isLoadingPokemonTypes',
    context: context,
  );

  @override
  bool get isLoadingPokemonTypes {
    _$isLoadingPokemonTypesAtom.reportRead();
    return super.isLoadingPokemonTypes;
  }

  @override
  set isLoadingPokemonTypes(bool value) {
    _$isLoadingPokemonTypesAtom.reportWrite(
      value,
      super.isLoadingPokemonTypes,
      () {
        super.isLoadingPokemonTypes = value;
      },
    );
  }

  late final _$typePokemonAsyncAction = AsyncAction(
    'PokemonsTypeStoreBase.typePokemon',
    context: context,
  );

  @override
  Future<void> typePokemon({required String pokemonType}) {
    return _$typePokemonAsyncAction.run(
      () => super.typePokemon(pokemonType: pokemonType),
    );
  }

  late final _$PokemonsTypeStoreBaseActionController = ActionController(
    name: 'PokemonsTypeStoreBase',
    context: context,
  );

  @override
  void changeButtonTypePokemons({required String text}) {
    final _$actionInfo = _$PokemonsTypeStoreBaseActionController.startAction(
      name: 'PokemonsTypeStoreBase.changeButtonTypePokemons',
    );
    try {
      return super.changeButtonTypePokemons(text: text);
    } finally {
      _$PokemonsTypeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearTypeSelection() {
    final _$actionInfo = _$PokemonsTypeStoreBaseActionController.startAction(
      name: 'PokemonsTypeStoreBase.clearTypeSelection',
    );
    try {
      return super.clearTypeSelection();
    } finally {
      _$PokemonsTypeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pokemonTypeState: ${pokemonTypeState},
isFilterTypeSelected: ${isFilterTypeSelected},
textButtonTypePokemons: ${textButtonTypePokemons},
pokemons: ${pokemons},
isLoadingPokemonTypes: ${isLoadingPokemonTypes},
messageTypeError: ${messageTypeError},
showTypeList: ${showTypeList},
showTypeError: ${showTypeError},
showTypeLoading: ${showTypeLoading}
    ''';
  }
}
