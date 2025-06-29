import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/modules/pokedex/ui/pages/pokemon_details_page.dart';

class PokedexModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/pokemon-details', child: (context) => PokemonDetailsPage(pokemonId: r.args.data));
    super.routes(r);
  }
}
