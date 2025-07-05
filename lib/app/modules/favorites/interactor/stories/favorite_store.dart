import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:poke_app/app/modules/pokedex/data/models/pokemons_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'favorite_store.g.dart';

class FavoriteStore = FavoriteStoreBase with _$FavoriteStore;

abstract class FavoriteStoreBase with Store {
  FavoriteStoreBase() {
    loadFavorites();
  }
  static const String _favoritesKey = 'favorite_pokemons';

  @observable
  ObservableList<PokemonsModel> pokemonsFavorites = ObservableList.of([]);

  @action
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList(_favoritesKey) ?? [];

    final parsedList = savedList.map((e) => PokemonsModel.fromJson(jsonDecode(e))).toList();

    pokemonsFavorites = ObservableList.of(parsedList);
  }

  @action
  Future<void> toggleFavorite(PokemonsModel pokemon) async {
    final prefs = await SharedPreferences.getInstance();
    final currentList = prefs.getStringList(_favoritesKey) ?? [];

    final isFav = pokemonsFavorites.any((p) => p.id == pokemon.id);

    if (isFav) {
      currentList.removeWhere((e) {
        final json = jsonDecode(e);
        return json['id'] == pokemon.id;
      });
    } else {
      currentList.add(jsonEncode(pokemon.toJson()));
    }

    await prefs.setStringList(_favoritesKey, currentList);
    await loadFavorites();
  }

  @action
  Future<void> removeFavorite(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final currentList = prefs.getStringList(_favoritesKey) ?? [];

    final pokemonToRemove = pokemonsFavorites[index];
    pokemonsFavorites.removeAt(index);

    currentList.removeWhere((e) {
      final json = jsonDecode(e);
      return json['id'] == pokemonToRemove.id;
    });

    await prefs.setStringList(_favoritesKey, currentList);
  }

  @action
  Future<bool> isFavorite(int id) async {
    return pokemonsFavorites.any((p) => p.id == id);
  }
}
