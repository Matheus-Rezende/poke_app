// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobx/mobx.dart';

import 'package:poke_app/app/modules/pokedex/data/models/pokemon_list_model.dart';
import 'package:poke_app/app/modules/pokedex/interactor/repositories/pokemons/pokemons_repository.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_state.dart';
import 'package:poke_app/app/modules/pokedex/interactor/stories/pokemons/details/pokemon_types/types_pokemon_store.dart';
import 'package:poke_app/app/modules/pokedex/interactor/stories/pokemons/search/search_pokemon_store.dart';

part 'pokemons_store.g.dart';

class PokemonsStore = PokemonsStoreBase with _$PokemonsStore;

abstract class PokemonsStoreBase with Store {
  final PokemonsRepository pokemonsRepository;
  final SearchPokemonStore pokemonSearchStore;
  final TypesPokemonStore pokemonTypeStore;
  PokemonsStoreBase({
    required this.pokemonsRepository,
    required this.pokemonSearchStore,
    required this.pokemonTypeStore,
  });

  final int limit = 20;

  @observable
  PokemonState pokemonState = InitPokemonState();

  @observable
  ObservableList<PokemonListModel> pokemons = ObservableList();

  @observable
  ObservableMap<int, List<PokemonListModel>> pageCache = ObservableMap();

  @observable
  bool isLoadingBottom = false;

  @observable
  int currentOffset = 0;

  @observable
  bool hasMore = true;

  @action
  Future<void> fetchInitial() async {
    hasMore = true;
    pokemonState = LoadingPokemonState();
    pokemons.clear();
    pageCache.clear();

    final result = await pokemonsRepository.fetchPokemons(limit: limit, offset: 0);
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
      final result = await pokemonsRepository.fetchPokemons(limit: limit, offset: nextOffset);
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

  @computed
  bool get showMainList =>
      pokemonSearchStore.pokemonSearchText.isEmpty &&
      pokemonState is SuccessPokemonState &&
      !pokemonTypeStore.isFilterTypeSelected;
}
