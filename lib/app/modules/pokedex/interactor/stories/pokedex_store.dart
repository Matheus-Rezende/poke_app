import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:poke_app/app/modules/pokedex/data/models/pokemon_model.dart';
import 'package:poke_app/app/modules/pokedex/interactor/repositories/pokedex_repository.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_search_state.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_state.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_type_state.dart';

part 'pokedex_store.g.dart';

class PokedexStore = PokedexStoreBase with _$PokedexStore;

abstract class PokedexStoreBase with Store {
  final PokedexRepository pokedexRepository;

  PokedexStoreBase({required this.pokedexRepository});

  final int limit = 20;

  // Estados principais
  @observable
  PokemonState pokemonState = InitPokemonState();

  @observable
  PokemonSearchState pokemonSearchState = InitPokemonSearchState();

  @observable
  PokemonTypeState pokemonTypeState = InitPokemonTypeState();

  // Lista principal de Pokemons
  @observable
  ObservableList<PokemonModel> pokemons = ObservableList();

  @observable
  ObservableMap<int, List<PokemonModel>> pageCache = ObservableMap();

  @observable
  bool isLoadingBottom = false;

  @observable
  int currentOffset = 0;

  @observable
  bool hasMore = true;

  // Busca
  Timer? debounceSearch;

  @observable
  String pokemonSearchText = '';

  // Filtro por tipo
  @observable
  bool isFilterTypeSelected = false;

  @observable
  String textButtonTypePokemons = 'Todos os tipos';

  // ==== AÇÕES PRINCIPAIS ====

  @action
  Future<void> fetchInitial() async {
    hasMore = true;
    pokemonState = LoadingPokemonState();
    pokemons.clear();
    pageCache.clear();

    final result = await pokedexRepository.fetchPokemons(limit: limit, offset: 0);
    result.fold((failure) => pokemonState = ErrorPokemonState(message: failure.message), (success) {
      pokemonState = SuccessPokemonState(pokemons: success.pokemons);
      pageCache[0] = success.pokemons;
      pokemons.addAll(success.pokemons);
      currentOffset = 0;
    });
  }

  @action
  Future<void> fetchNext() async {
    if (isLoadingBottom || !hasMore) return;

    isLoadingBottom = true;
    final nextOffset = currentOffset + limit;

    if (pageCache.containsKey(nextOffset)) {
      pokemons.addAll(pageCache[nextOffset]!);
      currentOffset = nextOffset;
    } else {
      final result = await pokedexRepository.fetchPokemons(limit: limit, offset: nextOffset);
      result.fold((failure) => pokemonState = ErrorPokemonState(message: failure.message), (success) {
        final fetched = success.pokemons;
        pageCache[nextOffset] = fetched;
        pokemons.addAll(fetched);
        currentOffset = nextOffset;
        if (fetched.length < limit) hasMore = false;
      });
    }

    isLoadingBottom = false;
  }

  @action
  void changePokemonSearchText(String text) {
    pokemonSearchText = text;
  }

  @action
  Future<void> searchPokemon({required String pokemonName}) async {
    pokemonSearchState = pokemonSearchState.loading();
    final result = await pokedexRepository.searchPokemon(pokemonName: pokemonName);
    result.fold(
      (failure) => pokemonSearchState = ErrorPokemonSearchState(message: failure.message),
      (success) => pokemonSearchState = SuccessPokemonSearchState(pokemon: success.pokemon),
    );
  }

  void onSearchPokemonChanged(String pokemonName) {
    if (debounceSearch?.isActive ?? false) debounceSearch!.cancel();
    debounceSearch = Timer(const Duration(milliseconds: 600), () {
      searchPokemon(pokemonName: pokemonName);
      isFilterTypeSelected = false;
    });
  }

  @action
  Future<void> typePokemon({required String pokemonType}) async {
    pokemonTypeState = pokemonTypeState.loading();
    await Future.delayed(Duration(milliseconds: 500));
    final result = await pokedexRepository.fetchTypePokemons(pokemonType: pokemonType);
    result.fold(
      (failure) => pokemonTypeState = ErrorPokemonTypeState(message: failure.message),
      (success) => pokemonTypeState = SuccessPokemonTypeState(pokemons: success.pokemons),
    );
  }

  @action
  void changeButtonTypePokemons({required String text}) {
    textButtonTypePokemons = text;
    isFilterTypeSelected = true;
  }

  // ==== COMPUTED ====

  // -------------- Message error in Search and Type ------------------
  @computed
  String get messageSearchError => (pokemonSearchState as ErrorPokemonSearchState).message;
  @computed
  String get messageTypeError => (pokemonTypeState as ErrorPokemonTypeState).message;
  // ------------------------------------------------------------------

  // -------------------- Main List -----------------------------------
  @computed
  bool get showMainList =>
      pokemonSearchText.isEmpty && pokemonState is SuccessPokemonState && !isFilterTypeSelected;
  // ------------------------------------------------------------------

  // ------------------- Search Pokemon -------------------------------
  @computed
  bool get showSearchResult => pokemonSearchState is SuccessPokemonSearchState && !isFilterTypeSelected;
  @computed
  bool get showSearchLoading => pokemonSearchState is LoadingPokemonSearchState && !isFilterTypeSelected;
  @computed
  bool get showSearchError =>
      pokemonSearchState is ErrorPokemonSearchState && pokemonSearchText.isNotEmpty && !isFilterTypeSelected;
  // -------------------------------------------------------------------

  // --------------------- Types Pokemon -------------------------------
  @computed
  bool get showTypeButton => pokemonSearchText.isEmpty;
  @computed
  bool get showTypeList => pokemonTypeState is SuccessPokemonTypeState && isFilterTypeSelected;
  @computed
  bool get showTypeError => pokemonTypeState is ErrorPokemonTypeState && isFilterTypeSelected;
  @computed
  bool get showTypeLoading => pokemonTypeState is LoadingPokemonTypeState && isFilterTypeSelected;
  // --------------------------------------------------------------------
}
