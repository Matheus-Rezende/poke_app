// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regions_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegionsStore on RegionsStoreBase, Store {
  Computed<bool>? _$showMainListComputed;

  @override
  bool get showMainList => (_$showMainListComputed ??= Computed<bool>(
    () => super.showMainList,
    name: 'RegionsStoreBase.showMainList',
  )).value;
  Computed<bool>? _$loadingMainListComputed;

  @override
  bool get loadingMainList => (_$loadingMainListComputed ??= Computed<bool>(
    () => super.loadingMainList,
    name: 'RegionsStoreBase.loadingMainList',
  )).value;

  late final _$regionsStateAtom = Atom(
    name: 'RegionsStoreBase.regionsState',
    context: context,
  );

  @override
  RegionsState get regionsState {
    _$regionsStateAtom.reportRead();
    return super.regionsState;
  }

  @override
  set regionsState(RegionsState value) {
    _$regionsStateAtom.reportWrite(value, super.regionsState, () {
      super.regionsState = value;
    });
  }

  late final _$pokemonsRegionStateAtom = Atom(
    name: 'RegionsStoreBase.pokemonsRegionState',
    context: context,
  );

  @override
  PokemonsRegionState get pokemonsRegionState {
    _$pokemonsRegionStateAtom.reportRead();
    return super.pokemonsRegionState;
  }

  @override
  set pokemonsRegionState(PokemonsRegionState value) {
    _$pokemonsRegionStateAtom.reportWrite(value, super.pokemonsRegionState, () {
      super.pokemonsRegionState = value;
    });
  }

  late final _$pokemonsAtom = Atom(
    name: 'RegionsStoreBase.pokemons',
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

  late final _$isLoadingAtom = Atom(
    name: 'RegionsStoreBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$getRegionsAsyncAction = AsyncAction(
    'RegionsStoreBase.getRegions',
    context: context,
  );

  @override
  Future<void> getRegions() {
    return _$getRegionsAsyncAction.run(() => super.getRegions());
  }

  late final _$getPokemonsByRegionAsyncAction = AsyncAction(
    'RegionsStoreBase.getPokemonsByRegion',
    context: context,
  );

  @override
  Future<void> getPokemonsByRegion({required String url}) {
    return _$getPokemonsByRegionAsyncAction.run(
      () => super.getPokemonsByRegion(url: url),
    );
  }

  @override
  String toString() {
    return '''
regionsState: ${regionsState},
pokemonsRegionState: ${pokemonsRegionState},
pokemons: ${pokemons},
isLoading: ${isLoading},
showMainList: ${showMainList},
loadingMainList: ${loadingMainList}
    ''';
  }
}
