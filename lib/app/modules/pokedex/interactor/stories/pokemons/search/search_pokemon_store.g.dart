// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_pokemon_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SearchPokemonStore on SearchPokemonStoreBase, Store {
  Computed<String>? _$messageSearchErrorComputed;

  @override
  String get messageSearchError =>
      (_$messageSearchErrorComputed ??= Computed<String>(
        () => super.messageSearchError,
        name: 'SearchPokemonStoreBase.messageSearchError',
      )).value;
  Computed<bool>? _$showSearchResultComputed;

  @override
  bool get showSearchResult => (_$showSearchResultComputed ??= Computed<bool>(
    () => super.showSearchResult,
    name: 'SearchPokemonStoreBase.showSearchResult',
  )).value;
  Computed<bool>? _$showSearchLoadingComputed;

  @override
  bool get showSearchLoading => (_$showSearchLoadingComputed ??= Computed<bool>(
    () => super.showSearchLoading,
    name: 'SearchPokemonStoreBase.showSearchLoading',
  )).value;
  Computed<bool>? _$showSearchErrorComputed;

  @override
  bool get showSearchError => (_$showSearchErrorComputed ??= Computed<bool>(
    () => super.showSearchError,
    name: 'SearchPokemonStoreBase.showSearchError',
  )).value;

  late final _$pokemonSearchStateAtom = Atom(
    name: 'SearchPokemonStoreBase.pokemonSearchState',
    context: context,
  );

  @override
  PokemonSearchState get pokemonSearchState {
    _$pokemonSearchStateAtom.reportRead();
    return super.pokemonSearchState;
  }

  @override
  set pokemonSearchState(PokemonSearchState value) {
    _$pokemonSearchStateAtom.reportWrite(value, super.pokemonSearchState, () {
      super.pokemonSearchState = value;
    });
  }

  late final _$pokemonSearchTextAtom = Atom(
    name: 'SearchPokemonStoreBase.pokemonSearchText',
    context: context,
  );

  @override
  String get pokemonSearchText {
    _$pokemonSearchTextAtom.reportRead();
    return super.pokemonSearchText;
  }

  @override
  set pokemonSearchText(String value) {
    _$pokemonSearchTextAtom.reportWrite(value, super.pokemonSearchText, () {
      super.pokemonSearchText = value;
    });
  }

  late final _$searchPokemonAsyncAction = AsyncAction(
    'SearchPokemonStoreBase.searchPokemon',
    context: context,
  );

  @override
  Future<void> searchPokemon({required String pokemonName}) {
    return _$searchPokemonAsyncAction.run(
      () => super.searchPokemon(pokemonName: pokemonName),
    );
  }

  late final _$SearchPokemonStoreBaseActionController = ActionController(
    name: 'SearchPokemonStoreBase',
    context: context,
  );

  @override
  void changePokemonSearchText(String text) {
    final _$actionInfo = _$SearchPokemonStoreBaseActionController.startAction(
      name: 'SearchPokemonStoreBase.changePokemonSearchText',
    );
    try {
      return super.changePokemonSearchText(text);
    } finally {
      _$SearchPokemonStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pokemonSearchState: ${pokemonSearchState},
pokemonSearchText: ${pokemonSearchText},
messageSearchError: ${messageSearchError},
showSearchResult: ${showSearchResult},
showSearchLoading: ${showSearchLoading},
showSearchError: ${showSearchError}
    ''';
  }
}
