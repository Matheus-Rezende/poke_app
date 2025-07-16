// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemons_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PokemonsStore on PokemonsStoreBase, Store {
  Computed<bool>? _$showMainListComputed;

  @override
  bool get showMainList => (_$showMainListComputed ??= Computed<bool>(
    () => super.showMainList,
    name: 'PokemonsStoreBase.showMainList',
  )).value;

  late final _$pokemonStateAtom = Atom(
    name: 'PokemonsStoreBase.pokemonState',
    context: context,
  );

  @override
  PokemonState get pokemonState {
    _$pokemonStateAtom.reportRead();
    return super.pokemonState;
  }

  @override
  set pokemonState(PokemonState value) {
    _$pokemonStateAtom.reportWrite(value, super.pokemonState, () {
      super.pokemonState = value;
    });
  }

  late final _$pokemonsAtom = Atom(
    name: 'PokemonsStoreBase.pokemons',
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

  late final _$pageCacheAtom = Atom(
    name: 'PokemonsStoreBase.pageCache',
    context: context,
  );

  @override
  ObservableMap<int, List<PokemonsModel>> get pageCache {
    _$pageCacheAtom.reportRead();
    return super.pageCache;
  }

  @override
  set pageCache(ObservableMap<int, List<PokemonsModel>> value) {
    _$pageCacheAtom.reportWrite(value, super.pageCache, () {
      super.pageCache = value;
    });
  }

  late final _$isLoadingBottomAtom = Atom(
    name: 'PokemonsStoreBase.isLoadingBottom',
    context: context,
  );

  @override
  bool get isLoadingBottom {
    _$isLoadingBottomAtom.reportRead();
    return super.isLoadingBottom;
  }

  @override
  set isLoadingBottom(bool value) {
    _$isLoadingBottomAtom.reportWrite(value, super.isLoadingBottom, () {
      super.isLoadingBottom = value;
    });
  }

  late final _$currentOffsetAtom = Atom(
    name: 'PokemonsStoreBase.currentOffset',
    context: context,
  );

  @override
  int get currentOffset {
    _$currentOffsetAtom.reportRead();
    return super.currentOffset;
  }

  @override
  set currentOffset(int value) {
    _$currentOffsetAtom.reportWrite(value, super.currentOffset, () {
      super.currentOffset = value;
    });
  }

  late final _$hasMoreAtom = Atom(
    name: 'PokemonsStoreBase.hasMore',
    context: context,
  );

  @override
  bool get hasMore {
    _$hasMoreAtom.reportRead();
    return super.hasMore;
  }

  @override
  set hasMore(bool value) {
    _$hasMoreAtom.reportWrite(value, super.hasMore, () {
      super.hasMore = value;
    });
  }

  late final _$fetchInitialAsyncAction = AsyncAction(
    'PokemonsStoreBase.fetchInitial',
    context: context,
  );

  @override
  Future<void> fetchInitial() {
    return _$fetchInitialAsyncAction.run(() => super.fetchInitial());
  }

  late final _$fetchNextAsyncAction = AsyncAction(
    'PokemonsStoreBase.fetchNext',
    context: context,
  );

  @override
  Future<void> fetchNext() {
    return _$fetchNextAsyncAction.run(() => super.fetchNext());
  }

  @override
  String toString() {
    return '''
pokemonState: ${pokemonState},
pokemons: ${pokemons},
pageCache: ${pageCache},
isLoadingBottom: ${isLoadingBottom},
currentOffset: ${currentOffset},
hasMore: ${hasMore},
showMainList: ${showMainList}
    ''';
  }
}
