// search_pokemon_store.dart
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import 'package:poke_app/app/modules/pokedex/interactor/repositories/pokemons/search/search_pokemon_repository.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_search_state.dart';

part 'search_pokemon_store.g.dart';

class SearchPokemonStore = SearchPokemonStoreBase with _$SearchPokemonStore;

abstract class SearchPokemonStoreBase with Store {
  final SearchPokemonRepository searchPokemonRepository;
  final VoidCallback? onClearTypeSelection;
  final bool Function() isFilterTypeSelected;

  SearchPokemonStoreBase({
    required this.searchPokemonRepository,
    this.onClearTypeSelection,
    required this.isFilterTypeSelected,
  });

  @observable
  PokemonSearchState pokemonSearchState = InitPokemonSearchState();

  Timer? debounceSearch;

  @observable
  String pokemonSearchText = '';

  @action
  void changePokemonSearchText(String text) {
    pokemonSearchText = text;
  }

  @action
  Future<void> searchPokemon({required String pokemonName}) async {
    pokemonSearchState = pokemonSearchState.loading();
    final result = await searchPokemonRepository.searchPokemon(pokemonName: pokemonName);
    result.fold(
      (failure) => pokemonSearchState = ErrorPokemonSearchState(message: failure.message),
      (success) => pokemonSearchState = SuccessPokemonSearchState(pokemon: success.pokemon),
    );
  }

  void onSearchPokemonChanged(String pokemonName) {
    if (debounceSearch?.isActive ?? false) debounceSearch!.cancel();
    debounceSearch = Timer(const Duration(milliseconds: 600), () {
      searchPokemon(pokemonName: pokemonName);
      onClearTypeSelection?.call();
    });
  }

  @computed
  String get messageSearchError => (pokemonSearchState as ErrorPokemonSearchState).message;

  @computed
  bool get showSearchResult =>
      pokemonSearchState is SuccessPokemonSearchState &&
      !isFilterTypeSelected() &&
      pokemonSearchText.isNotEmpty;

  @computed
  bool get showSearchLoading => pokemonSearchState is LoadingPokemonSearchState && !isFilterTypeSelected();

  @computed
  bool get showSearchError =>
      pokemonSearchState is ErrorPokemonSearchState &&
      pokemonSearchText.isNotEmpty &&
      !isFilterTypeSelected();
}
