import 'package:mobx/mobx.dart';
import 'package:poke_app/app/modules/pokedex/interactor/repositories/pokemons/details/pokemon_informations/informations_pokemon_repository.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_description_state.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_details_state.dart';
part 'informations_pokemon_store.g.dart';

class InformationsPokemonStore = InformationsPokemonStoreBase with _$InformationsPokemonStore;

abstract class InformationsPokemonStoreBase with Store {
  final InformationsPokemonRepository informationsPokemonRepository;

  InformationsPokemonStoreBase({required this.informationsPokemonRepository});

  @observable
  PokemonDetailsState pokemonDetailsState = InitPokemonDetailsState();

  @observable
  PokemonDescriptionState pokemonDescriptionState = InitPokemonDescriptionState();

  @action
  Future<void> detailsPokemon({required String pokemon}) async {
    pokemonDetailsState = pokemonDetailsState.loading();
    final result = await informationsPokemonRepository.fetchPokemonDetails(pokemon: pokemon);
    result.fold(
      (failure) => pokemonDetailsState = ErrorPokemonDetailsState(message: failure.message),
      (success) => pokemonDetailsState = SuccessPokemonDetailsState(pokemon: success.pokemon),
    );
  }

  @action
  Future<void> descriptionPokemon({required String pokemon}) async {
    pokemonDescriptionState = pokemonDescriptionState.loading();
    final result = await informationsPokemonRepository.fetchPokemonDescription(pokemon: pokemon);
    result.fold(
      (failure) => pokemonDescriptionState = ErrorPokemonDescriptionState(message: failure.message),
      (success) => pokemonDescriptionState = SuccessPokemonDescriptionState(description: success.description),
    );
  }

  @computed
  bool get isMainDetailsLoaded =>
      pokemonDetailsState is SuccessPokemonDetailsState &&
      (pokemonDescriptionState is SuccessPokemonDescriptionState ||
          pokemonDescriptionState is ErrorPokemonDescriptionState);

  @computed
  bool get isLoadingMainDetails =>
      pokemonDetailsState is LoadingPokemonDetailsState ||
      pokemonDescriptionState is LoadingPokemonDescriptionState;
}
