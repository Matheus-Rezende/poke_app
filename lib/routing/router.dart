import 'package:go_router/go_router.dart';
import 'package:poke_app/routing/routes.dart';
import 'package:poke_app/ui/menu/widgets/menu_screen.dart';
import 'package:poke_app/ui/pokedex/viewmodels/pokedex_viewmodel.dart';
import 'package:poke_app/ui/splash/widgets/splash_screen.dart';
import 'package:provider/provider.dart';

GoRouter routerConfig() {
  return GoRouter(
    routes: [
      GoRoute(path: Routes.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: Routes.menu,
        builder: (context, state) =>
            MenuScreen(pokedexViewmodel: PokedexViewmodel(pokedexRepository: context.read())),
      ),

      // GoRoute(
      //   path: Routes.todos,
      //   builder: (context, state) {
      //     return TodoScreen(
      //       todoViewmodel: TodoViewmodel(todosRepository: context.read(), todoUpdateUseCase: context.read()),
      //     );
      //   },
      //   routes: [
      //     GoRoute(
      //       path: ':id',
      //       builder: (context, state) {
      //         final todoId = state.pathParameters['id']!;
      //         final TodoDetailsViewmodel todoDetailsViewmodel = TodoDetailsViewmodel(
      //           todosRepository: context.read(),
      //           todoUpdateUsecase: context.read(),
      //         );
      //         todoDetailsViewmodel.load.execute(todoId);
      //         return TodoDetailsScreen(todoDetailsViewmodel: todoDetailsViewmodel);
      //       },
      //     ),
      //   ],
      // ),
    ],
  );
}
