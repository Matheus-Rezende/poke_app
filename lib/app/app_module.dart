import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/modules/favorites/favorites_module.dart';
import 'package:poke_app/app/modules/menu/menu_module.dart';
import 'package:poke_app/app/modules/pokedex/pokedex_module.dart';
import 'package:poke_app/app/modules/onboard/onboard_module.dart';
import 'package:poke_app/app/modules/profile/profile_module.dart';
import 'package:poke_app/app/modules/regions/regions_module.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    r.module(Modular.initialRoute, module: OnboardModule());
    r.module('/bottom-menu', module: MenuModule());
    r.module('/pokedex', module: PokedexModule());
    r.module('/regions', module: RegionsModule());
    r.module('/favorites', module: FavoritesModule());
    r.module('/profile', module: ProfileModule());
    super.routes(r);
  }
}
