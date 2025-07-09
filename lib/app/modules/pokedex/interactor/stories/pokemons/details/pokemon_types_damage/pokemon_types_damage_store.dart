import 'package:mobx/mobx.dart';
import 'package:poke_app/app/modules/pokedex/data/models/pokemon_details/pokemon_type_damage_model.dart';
import 'package:poke_app/app/modules/pokedex/interactor/repositories/pokemons/type/pokemons_type_repository.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_type_damage_state.dart';
part 'pokemon_types_damage_store.g.dart';

class PokemonTypesDamageStore = PokemonTypesDamageStoreBase with _$PokemonTypesDamageStore;

abstract class PokemonTypesDamageStoreBase with Store {
  final PokemonsTypeRepository pokemonsTypeRepository;

  PokemonTypesDamageStoreBase({required this.pokemonsTypeRepository});

  @observable
  PokemonTypeDamageState pokemonTypeDamageState = InitPokemonTypeDamageState();

  @observable
  List<String> combinedDamages = [];

  @action
  Future<void> loadCombinedTypeDamages(List<String> urls) async {
    pokemonTypeDamageState = LoadingPokemonTypeDamageState();
    combinedDamages.clear();

    try {
      final results = await Future.wait(
        urls.map((url) async {
          final result = await pokemonsTypeRepository.fetchPokemonTypeDamageByUrl(url: url);
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
