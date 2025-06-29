import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/core/core_module.dart';
import 'package:poke_app/app/modules/menu/interactor/stories/custom_bottom_menu_store.dart';
import 'package:poke_app/app/modules/menu/widgets/custom_bottom_menu_widget.dart';
import 'package:poke_app/app/modules/pokedex/data/repositories/pokedex_repository_impl.dart';
import 'package:poke_app/app/modules/pokedex/interactor/repositories/pokedex_repository.dart';
import 'package:poke_app/app/modules/pokedex/interactor/stories/pokedex_store.dart';

class MenuModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton(CustomBottomMenuStore.new);
    i.addLazySingleton(PokedexStore.new);
    i.add<PokedexRepository>(PokedexRepositoryImpl.new);
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
