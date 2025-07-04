// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobx/mobx.dart';

import 'package:poke_app/app/modules/pokedex/data/models/pokemon_details/pokemon_type_damage_model.dart';
import 'package:poke_app/app/modules/pokedex/interactor/repositories/pokemons/details/pokemon_types/types_pokemon_repository.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_type_damage_state.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_type_state.dart';

part 'types_pokemon_store.g.dart';

class TypesPokemonStore = TypesPokemonStoreBase with _$TypesPokemonStore;

abstract class TypesPokemonStoreBase with Store {
  final TypesPokemonRepository typesPokemonRepository;
  final bool Function() isSearchTextEmpty;

  TypesPokemonStoreBase({required this.typesPokemonRepository, required this.isSearchTextEmpty});

  @observable
  PokemonTypeState pokemonTypeState = InitPokemonTypeState();

  @observable
  bool isFilterTypeSelected = false;

  @observable
  String textButtonTypePokemons = 'Todos os tipos';

  @action
  Future<void> typePokemon({required String pokemonType}) async {
    pokemonTypeState = pokemonTypeState.loading();
    await Future.delayed(Duration(milliseconds: 500));
    final result = await typesPokemonRepository.fetchTypePokemons(pokemonType: pokemonType);
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

  @computed
  String get messageTypeError => (pokemonTypeState as ErrorPokemonTypeState).message;
  @computed
  bool get showTypeButton => isSearchTextEmpty();
  @computed
  bool get showTypeList => pokemonTypeState is SuccessPokemonTypeState && isFilterTypeSelected;
  @computed
  bool get showTypeError => pokemonTypeState is ErrorPokemonTypeState && isFilterTypeSelected;
  @computed
  bool get showTypeLoading => pokemonTypeState is LoadingPokemonTypeState && isFilterTypeSelected;

  //================= Pokemon Type Damage =========================
  // São os tipos de pokemons que causam dano (Fraqueza)

  @observable
  PokemonTypeDamageState pokemonTypeDamageState = InitPokemonTypeDamageState();

  @observable
  ObservableFuture<void>? typeDamageFuture;

  @observable
  List<String> combinedDamages = [];

  @action
  Future<void> loadCombinedTypeDamages(List<String> urls) async {
    pokemonTypeDamageState = LoadingPokemonTypeDamageState();
    combinedDamages.clear();

    try {
      final results = await Future.wait(
        urls.map((url) async {
          final result = await typesPokemonRepository.fetchPokemonTypeDamageByUrl(url: url);
          return result.fold<List<String>>(
            (failure) => throw Exception(failure.message),
            (success) => success.typeDamage.damages ?? [],
          );
        }),
      );

      final merged = results.expand((list) => list).toSet().toList();
      combinedDamages = merged;
      pokemonTypeDamageState = SuccessPokemonTypeDamageState(
        typeDamage: PokemonTypeDamageModel(damages: merged),
      );
    } catch (e) {
      pokemonTypeDamageState = ErrorPokemonTypeDamageState(message: e.toString());
    }
  }
}
