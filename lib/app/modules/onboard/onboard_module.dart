import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/core/core_module.dart';
import 'package:poke_app/app/modules/onboard/data/repositories/onboard_repository_impl.dart';
import 'package:poke_app/app/modules/onboard/interactor/repositories/onboard_repository.dart';
import 'package:poke_app/app/modules/onboard/interactor/stories/onboard_store.dart';
import 'package:poke_app/app/modules/onboard/pages/onboard_page.dart';
import 'package:poke_app/app/modules/onboard/pages/splash_page.dart';

class OnboardModule extends Module {
  @override
  void binds(Injector i) {
    i.add<OnboardRepository>(OnboardRepositoryImpl.new);
    i.addLazySingleton(OnboardStore.new);
    super.binds(i);
  }

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (context) => SplashPage());
    r.child('/onboarding', child: (context) => OnboardPage());

    super.routes(r);
  }
}
