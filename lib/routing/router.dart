import 'package:go_router/go_router.dart';
import 'package:poke_app/routing/routes.dart';
import 'package:poke_app/ui/home/widgets/home_screen.dart';
import 'package:poke_app/ui/pokedex/viewmodels/pokedex_viewmodel.dart';
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
          return HomeScreen(pokedexViewmodel: PokedexViewmodel(pokedexRepository: context.read()));
        },
        routes: [
          GoRoute(
            path: ':pokemonId',
            builder: (context, state) {
              final pokemonId = state.pathParameters['pokemonId']!;
              final PokemonDetailsViewmodel pokemonDetailsViewmodel = PokemonDetailsViewmodel(
                pokedexRepository: context.read(),
              );
              pokemonDetailsViewmodel.load.execute(int.parse(pokemonId));

              return PokemonDetailsScreen(pokemonDetailsViewmodel: pokemonDetailsViewmodel);
            },
          ),
        ],
      ),
    ],
  );
}
