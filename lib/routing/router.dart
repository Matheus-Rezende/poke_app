import 'package:go_router/go_router.dart';
import 'package:poke_app/routing/routes.dart';
import 'package:poke_app/ui/home/widgets/home_screen.dart';
import 'package:poke_app/ui/pokedex/viewmodels/pokedex_viewmodel.dart';
import 'package:poke_app/ui/pokedex/viewmodels/search_pokemon_viewmodel.dart';
import 'package:poke_app/ui/pokedex/viewmodels/types_pokemon_viewmodel.dart';
import 'package:poke_app/ui/pokemon_details/viewmodels/pokemon_details_viewmodel.dart';
import 'package:poke_app/ui/pokemon_details/widgets/pokemon_details_screen.dart';
import 'package:poke_app/ui/splash/widgets/splash_screen.dart';
import 'package:provider/provider.dart';

GoRouter routerConfig() {
  return GoRouter(
    routes: [
      GoRoute(path: Routes.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: Routes.home,
        builder: (context, state) {
          return HomeScreen(
            pokedexViewmodel: PokedexViewmodel(pokedexRepository: context.read()),
            searchPokemonViewmodel: SearchPokemonViewmodel(pokedexRepository: context.read()),
            typesPokemonViewmodel: TypesPokemonViewmodel(pokedexRepository: context.read()),
          );
        },
        routes: [
          GoRoute(
            path: ':pokemon',
            builder: (context, state) {
              final pokemon = state.pathParameters['pokemon']!;
              final PokemonDetailsViewmodel pokemonDetailsViewmodel = PokemonDetailsViewmodel(
                pokedexRepository: context.read(),
              );
              pokemonDetailsViewmodel.load.execute(pokemon);

              return PokemonDetailsScreen(pokemonDetailsViewmodel: pokemonDetailsViewmodel);
            },
          ),
        ],
      ),
    ],
  );
}
