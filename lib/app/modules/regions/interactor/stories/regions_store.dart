// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobx/mobx.dart';

import 'package:poke_app/app/core/interactor/repositories/pokemon_types_repository.dart';
import 'package:poke_app/app/modules/pokedex/data/models/pokemons_model.dart';
import 'package:poke_app/app/modules/pokedex/interactor/stories/pokemons/search/search_pokemon_store.dart';
import 'package:poke_app/app/modules/regions/interactor/repositories/regions_repository.dart';
import 'package:poke_app/app/modules/regions/interactor/states/pokemons_region_state.dart';
import 'package:poke_app/app/modules/regions/interactor/states/regions_state.dart';

part 'regions_store.g.dart';

class RegionsStore = RegionsStoreBase with _$RegionsStore;

abstract class RegionsStoreBase with Store {
  final RegionsRepository regionsRepository;
  final PokemonTypesRepository pokemonTypesRepository;
  final SearchPokemonStore pokemonSearchStore;

  RegionsStoreBase({
    required this.regionsRepository,
    required this.pokemonTypesRepository,
    required this.pokemonSearchStore,
  });

  @observable
  RegionsState regionsState = InitRegionsState();

  @observable
  PokemonsRegionState pokemonsRegionState = InitPokemonsRegionState();

  @observable
  ObservableList<PokemonsModel> pokemons = ObservableList<PokemonsModel>();

  @observable
  bool isLoading = false;

  @action
  Future<void> getRegions() async {
    regionsState = regionsState.loading();
    final result = await regionsRepository.fetchRegions();
    result.fold(
      (failure) => regionsState = ErrorRegionsState(message: failure.message),
      (success) => regionsState = SuccessRegionsState(regions: success.regions),
    );
  }

  @action
  Future<void> getPokemonsByRegion({required String url}) async {
    pokemonsRegionState = pokemonsRegionState.loading();
    final result = await regionsRepository.fetchPokemonsByRegion(url: url);

    result.fold((failure) => pokemonsRegionState = ErrorPokemonsRegionState(message: failure.message), (
      success,
    ) {
      pokemons.clear();
      pokemons.addAll(success.pokemons);

      pokemonsRegionState = SuccessPokemonsRegionState(pokemons: pokemons.toList());

      _loadPokemonTypes(pokemons);
    });
  }

  Future<void> _loadPokemonTypes(List<PokemonsModel> list) async {
    const chunkSize = 10;
    isLoading = true;

    for (int i = 0; i < list.length; i += chunkSize) {
      final chunk = list.skip(i).take(chunkSize);
      await Future.wait(
        chunk.map((pokemon) async {
          final types = await pokemonTypesRepository.fetchPokemonTypesById(id: pokemon.id);
          types.fold((failure) => pokemon.types = [], (success) => pokemon.types = success);
        }),
      );

      isLoading = false;
      pokemonsRegionState = SuccessPokemonsRegionState(pokemons: pokemons.toList());
    }
  }

  @computed
  bool get showMainList =>
      pokemonSearchStore.pokemonSearchText.isEmpty && pokemonsRegionState is SuccessPokemonsRegionState;
}
