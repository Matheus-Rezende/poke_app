import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/core/core_module.dart';
import 'package:poke_app/app/modules/favorites/interactor/stories/favorite_store.dart';
import 'package:poke_app/app/modules/menu/interactor/stories/custom_bottom_menu_store.dart';
import 'package:poke_app/app/modules/menu/widgets/custom_bottom_menu_widget.dart';
import 'package:poke_app/app/modules/pokedex/data/repositories/pokemons/details/pokemon_evolutions/evolutions_pokemon_repository_impl.dart';
import 'package:poke_app/app/modules/pokedex/data/repositories/pokemons/details/pokemon_informations/informations_pokemon_repository_impl.dart';
import 'package:poke_app/app/modules/pokedex/data/repositories/pokemons/details/pokemon_types/types_pokemon_repository_impl.dart';
import 'package:poke_app/app/modules/pokedex/data/repositories/pokemons/pokemons_repository_impl.dart';
import 'package:poke_app/app/modules/pokedex/data/repositories/pokemons/search/search_pokemon_repository_impl.dart';
import 'package:poke_app/app/modules/pokedex/interactor/repositories/pokemons/details/pokemon_evolutions/evolutions_pokemon_repository.dart';
import 'package:poke_app/app/modules/pokedex/interactor/repositories/pokemons/details/pokemon_informations/informations_pokemon_repository.dart';
import 'package:poke_app/app/modules/pokedex/interactor/repositories/pokemons/details/pokemon_types/types_pokemon_repository.dart';
import 'package:poke_app/app/modules/pokedex/interactor/repositories/pokemons/pokemons_repository.dart';
import 'package:poke_app/app/modules/pokedex/interactor/repositories/pokemons/search/search_pokemon_repository.dart';
import 'package:poke_app/app/modules/pokedex/interactor/stories/pokemons/details/pokemon_evolutions/evolutions_pokemon_store.dart';
import 'package:poke_app/app/modules/pokedex/interactor/stories/pokemons/details/pokemon_informations/informations_pokemon_store.dart';
import 'package:poke_app/app/modules/pokedex/interactor/stories/pokemons/details/pokemon_types/types_pokemon_store.dart';
import 'package:poke_app/app/modules/pokedex/interactor/stories/pokemons/pokemons_store.dart';
import 'package:poke_app/app/modules/pokedex/interactor/stories/pokemons/search/search_pokemon_store.dart';

class MenuModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(CustomBottomMenuStore.new);
    i.addLazySingleton(PokemonsStore.new);
    // Registra o TypesPokemonStore primeiro
    i.addLazySingleton<TypesPokemonStore>(
      () => TypesPokemonStore(typesPokemonRepository: i.get<TypesPokemonRepository>()),
    );

    // Agora SearchPokemonStore com dependência dele
    i.addLazySingleton<SearchPokemonStore>(() {
      final typesStore = i.get<TypesPokemonStore>();
      return SearchPokemonStore(
        searchPokemonRepository: i.get<SearchPokemonRepository>(),
        onClearTypeSelection: typesStore.clearTypeSelection,
        isFilterTypeSelected: () => typesStore.isFilterTypeSelected,
      );
    });
    i.addLazySingleton(InformationsPokemonStore.new);
    i.addLazySingleton(EvolutionsPokemonStore.new);
    i.addLazySingleton(FavoriteStore.new);
    i.add<PokemonsRepository>(PokemonsRepositoryImpl.new);
    i.add<SearchPokemonRepository>(SearchPokemonRepositoryImpl.new);
    i.add<TypesPokemonRepository>(TypesPokemonRepositoryImpl.new);
    i.add<InformationsPokemonRepository>(InformationsPokemonRepositoryImpl.new);
    i.add<EvolutionsPokemonRepository>(EvolutionsPokemonRepositoryImpl.new);
    super.binds(i);
  }

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (context) => CustomBottomMenuWidget());
    super.routes(r);
  }
}
