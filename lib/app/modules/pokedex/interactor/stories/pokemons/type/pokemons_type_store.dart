// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobx/mobx.dart';

import 'package:poke_app/app/core/interactor/repositories/pokemon_types_repository.dart';
import 'package:poke_app/app/modules/pokedex/data/models/pokemons_model.dart';
import 'package:poke_app/app/modules/pokedex/interactor/repositories/pokemons/type/pokemons_type_repository.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_type_state.dart';

part 'pokemons_type_store.g.dart';

class PokemonsTypeStore = PokemonsTypeStoreBase with _$PokemonsTypeStore;

abstract class PokemonsTypeStoreBase with Store {
  final PokemonsTypeRepository pokemonsTypeRepository;
  final PokemonTypesRepository pokemonTypesRepository;

  PokemonsTypeStoreBase({required this.pokemonsTypeRepository, required this.pokemonTypesRepository});

  //================= Pokemon Types filter =====================================================
  // Tudo que está relacionado ao filtro de tipos de pokemons está aqui

  @observable
  PokemonTypeState pokemonTypeState = InitPokemonTypeState();

  @observable
  bool isFilterTypeSelected = false;

  @observable
  String textButtonTypePokemons = 'Todos os tipos';

  @observable
  ObservableList<PokemonsModel> pokemons = ObservableList<PokemonsModel>();

  @action
  Future<void> typePokemon({required String pokemonType}) async {
    pokemonTypeState = pokemonTypeState.loading();
    await Future.delayed(Duration(milliseconds: 500));
    final result = await pokemonsTypeRepository.fetchTypePokemons(pokemonType: pokemonType);

    result.fold((failure) => pokemonTypeState = ErrorPokemonTypeState(message: failure.message), (success) {
      pokemons.clear();
      pokemons.addAll(success.pokemons);

      pokemonTypeState = SuccessPokemonTypeState(pokemons: pokemons.toList());

      _loadPokemonTypes(pokemons);
    });
  }

  Future<void> _loadPokemonTypes(List<PokemonsModel> list) async {
    const chunkSize = 10;

    for (int i = 0; i < list.length; i += chunkSize) {
      final chunk = list.skip(i).take(chunkSize);
      await Future.wait(
        chunk.map((pokemon) async {
          final types = await pokemonTypesRepository.fetchPokemonTypesById(id: pokemon.id);
          types.fold((failure) => pokemon.types = [], (success) => pokemon.types = success);
        }),
      );

      pokemonTypeState = SuccessPokemonTypeState(pokemons: pokemons.toList());
    }
  }

  @action
  void changeButtonTypePokemons({required String text}) {
    textButtonTypePokemons = text;
    isFilterTypeSelected = true;
  }

  @computed
  String get messageTypeError => (pokemonTypeState as ErrorPokemonTypeState).message;
  @computed
  bool get showTypeList => pokemonTypeState is SuccessPokemonTypeState && isFilterTypeSelected;
  @computed
  bool get showTypeError => pokemonTypeState is ErrorPokemonTypeState && isFilterTypeSelected;
  @computed
  bool get showTypeLoading => pokemonTypeState is LoadingPokemonTypeState && isFilterTypeSelected;

  @action
  void clearTypeSelection() {
    isFilterTypeSelected = false;
    textButtonTypePokemons = 'Todos os tipos';
    pokemonTypeState = InitPokemonTypeState();
  }
}
