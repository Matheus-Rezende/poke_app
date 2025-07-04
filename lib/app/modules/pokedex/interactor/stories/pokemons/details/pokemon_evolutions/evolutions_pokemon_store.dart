import 'package:mobx/mobx.dart';
import 'package:poke_app/app/modules/pokedex/interactor/repositories/pokemons/details/pokemon_evolutions/evolutions_pokemon_repository.dart';
import 'package:poke_app/app/modules/pokedex/interactor/repositories/pokemons/details/pokemon_informations/informations_pokemon_repository.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_details_state.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_evolution_stage_state.dart';
part 'evolutions_pokemon_store.g.dart';

class EvolutionsPokemonStore = EvolutionsPokemonStoreBase with _$EvolutionsPokemonStore;

abstract class EvolutionsPokemonStoreBase with Store {
  final InformationsPokemonRepository informationsPokemonRepository;
  final EvolutionsPokemonRepository evolutionsPokemonRepository;

  EvolutionsPokemonStoreBase({
    required this.informationsPokemonRepository,
    required this.evolutionsPokemonRepository,
  });

  @observable
  PokemonEvolutionStageState pokemonEvolutionStageState = InitPokemonEvolutionStageState();

  @observable
  ObservableMap<String, PokemonDetailsState> pokemonEvolutionsDetails = ObservableMap.of({});

  @action
  Future<void> evolutionStagePokemon({required String url}) async {
    pokemonEvolutionsDetails.clear();

    pokemonEvolutionStageState = pokemonEvolutionStageState.loading();

    final result = await evolutionsPokemonRepository.fetchPokemonPokemonEvolutionsByUrl(url: url);
    result.fold(
      (failure) => pokemonEvolutionStageState = ErrorPokemonEvolutionStageState(message: failure.message),
      (success) async {
        pokemonEvolutionStageState = SuccessPokemonEvolutionStageState(evolutions: success.evolutions);

        final names = success.evolutions.map((e) => e.name).toList();
        await fetchEvolutionDetailsIfNeeded(names);
      },
    );
  }

  @action
  Future<void> fetchEvolutionDetailsIfNeeded(List<String> names) async {
    for (final name in names) {
      if (!pokemonEvolutionsDetails.containsKey(name)) {
        final result = await informationsPokemonRepository.fetchPokemonDetails(pokemon: name);
        result.fold(
          (failure) => pokemonEvolutionStageState = ErrorPokemonEvolutionStageState(message: failure.message),
          (success) => pokemonEvolutionsDetails[name] = success,
        );
      }
    }
  }
}
