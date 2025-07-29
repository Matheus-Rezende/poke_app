import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poke_app/app/core/routes/app_routes.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:poke_app/app/modules/onboard/interactor/states/onboard_state.dart';
import 'package:poke_app/app/modules/onboard/interactor/stories/onboard_store.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final appTheme = Modular.get<AppTheme>();
  final onboardStore = Modular.get<OnboardStore>();

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Observer(
      builder: (_) {
        onboardStore.showOnboard().then((value) {
          if (onboardStore.state is FirstStepOnboardState) {
            Modular.to.navigate(AppRoutes.onboarding());
          }
          if (onboardStore.state is SkipOnboardState) {
            Modular.to.navigate(AppRoutes.bottomMenu());
          }
        });
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                appTheme.colors.splashBlueColor.withValues(alpha: 0.5),
                appTheme.colors.splashBlueColor.withValues(alpha: 1.5),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/svg/pokeball_icon.svg',
                height: sizeOf.height * 0.15,
                width: sizeOf.width * 0.15,
              ),
              SvgPicture.asset('assets/images/svg/logos/pokemon_logo.svg', height: sizeOf.height * 0.15),
            ],
          ),
        );
      },
    );
  }
}
