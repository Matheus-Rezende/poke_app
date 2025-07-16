// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavoriteStore on FavoriteStoreBase, Store {
  late final _$pokemonsFavoritesAtom = Atom(
    name: 'FavoriteStoreBase.pokemonsFavorites',
    context: context,
  );

  @override
  ObservableList<PokemonsModel> get pokemonsFavorites {
    _$pokemonsFavoritesAtom.reportRead();
    return super.pokemonsFavorites;
  }

  @override
  set pokemonsFavorites(ObservableList<PokemonsModel> value) {
    _$pokemonsFavoritesAtom.reportWrite(value, super.pokemonsFavorites, () {
      super.pokemonsFavorites = value;
    });
  }

  late final _$loadFavoritesAsyncAction = AsyncAction(
    'FavoriteStoreBase.loadFavorites',
    context: context,
  );

  @override
  Future<void> loadFavorites() {
    return _$loadFavoritesAsyncAction.run(() => super.loadFavorites());
  }

  late final _$toggleFavoriteAsyncAction = AsyncAction(
    'FavoriteStoreBase.toggleFavorite',
    context: context,
  );

  @override
  Future<void> toggleFavorite(PokemonsModel pokemon) {
    return _$toggleFavoriteAsyncAction.run(() => super.toggleFavorite(pokemon));
  }

  late final _$removeFavoriteAsyncAction = AsyncAction(
    'FavoriteStoreBase.removeFavorite',
    context: context,
  );

  @override
  Future<void> removeFavorite(int index) {
    return _$removeFavoriteAsyncAction.run(() => super.removeFavorite(index));
  }

  late final _$isFavoriteAsyncAction = AsyncAction(
    'FavoriteStoreBase.isFavorite',
    context: context,
  );

  @override
  Future<bool> isFavorite(int id) {
    return _$isFavoriteAsyncAction.run(() => super.isFavorite(id));
  }

  @override
  String toString() {
    return '''
pokemonsFavorites: ${pokemonsFavorites}
    ''';
  }
}
