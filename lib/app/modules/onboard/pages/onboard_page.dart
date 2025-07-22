import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:poke_app/app/core/routes/app_routes.dart';

import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:poke_app/app/core/ui/widgets/buttons/custom_button_widget.dart';
import 'package:poke_app/app/modules/onboard/interactor/states/onboard_state.dart';
import 'package:poke_app/app/modules/onboard/interactor/stories/onboard_store.dart';
import 'package:poke_app/app/modules/onboard/widgets/onboard_widget.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  final appTheme = Modular.get<AppTheme>();
  final store = Modular.get<OnboardStore>();
  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: appTheme.colors.whiteColor,
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Observer(
              builder: (context) {
                return store.state is ThirdStepOnboardState
                    ? Expanded(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: CustomButtonWidget(
                            title: 'Pular',
                            titleStyle: appTheme.typography.poppins18px().copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            iconPosition: IconPosition.sufix,
                            iconPath: 'assets/icons/svg/arrow_right_icon.svg',
                            backgroundColor: appTheme.colors.whiteColor,
                            padding: 0.0,
                            height: 64.0,
                            onPressed: () {
                              store.skipOnboard();
                              Modular.to.navigate(AppRoutes.bottomMenu());
                            },
                          ),
                        ),
                      )
                    : Expanded(child: Container());
              },
            ),
            Observer(
              builder: (_) {
                return switch (store.state) {
                  InitOnboardState() => Container(),
                  SkipOnboardState() => Container(),
                  FirstStepOnboardState() => OnboardWidget(
                    pathCoach1: 'assets/images/png/coaches/coach_1.png',
                    widthCoach1: sizeOf.width * 0.7,
                    pathCoach2: 'assets/images/png/coaches/coach_2.png',
                    title: 'Todos os Pokémons em um só Lugar',
                    subtitle:
                        'Acesse uma vasta lista de Pokémon de todas as gerações já feitas pela Nintendo',
                  ),
                  SecondStepOnboardState() => OnboardWidget(
                    pathCoach1: 'assets/images/png/coaches/coach_3.png',
                    title: 'Mantenha sua Pokédex atualizada',
                    subtitle:
                        'Você pode gerenciar seu perfil, pokémon favoritos, configurações e muito mais, salvos no aplicativo, mesmo sem conexão com a internet.',
                  ),
                  ThirdStepOnboardState() => OnboardWidget(
                    pathCoach1: 'assets/images/png/coaches/coach_4.png',
                    widthCoach1: sizeOf.width * 0.55,
                    pathCoach2: 'assets/images/png/coaches/coach_5.png',
                    title: 'Está pronto para essa aventura?',
                    subtitle: 'Basta criar uma conta e começar a explorar o mundo dos Pokémon hoje!',
                  ),
                };
              },
            ),

            Observer(
              builder: (context) {
                return Column(
                  children: [
                    store.state is ThirdStepOnboardState
                        ? Container()
                        : SizedBox(height: sizeOf.width * 0.06),
                    store.state is ThirdStepOnboardState
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buildDot(FirstStepOnboardState(), context),
                              buildDot(SecondStepOnboardState(), context),
                            ],
                          ),
                    SizedBox(height: sizeOf.width * 0.06),
                    store.state is FirstStepOnboardState || store.state is SecondStepOnboardState
                        ? CustomButtonWidget(
                            title: store.state is FirstStepOnboardState ? 'Continuar' : 'Vamos começar!',
                            width: sizeOf.width,
                            height: 58.0,
                            borderRadius: 50.0,
                            onPressed: () => store.onPressedAdvance(),
                            titleStyle: appTheme.typography.poppins18px().copyWith(
                              color: appTheme.colors.whiteColor,
                              fontWeight: FontWeight.w500,
                            ),
                            backgroundColor: appTheme.colors.backgroundBlueColor,
                          )
                        : Column(
                            children: [
                              CustomButtonWidget(
                                title: 'Criar conta',
                                width: sizeOf.width,
                                height: 58.0,
                                borderRadius: 50.0,
                                onPressed: () => store.onPressedAdvance(),
                                titleStyle: appTheme.typography.poppins18px().copyWith(
                                  color: appTheme.colors.whiteColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                backgroundColor: appTheme.colors.backgroundBlueColor,
                              ),
                              SizedBox(height: 8.0),
                              CustomButtonWidget(
                                title: 'Ja tenho uma conta',
                                width: sizeOf.width,
                                height: 58.0,
                                borderRadius: 50.0,
                                onPressed: () {},
                                titleStyle: appTheme.typography.poppins18px().copyWith(
                                  color: appTheme.colors.backgroundBlueColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                backgroundColor: appTheme.colors.whiteColor,
                              ),
                            ],
                          ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDot(OnboardState state, BuildContext context) {
    return Observer(
      builder: (context) {
        return Container(
          height: 9.0,
          margin: EdgeInsets.only(right: 8.0),
          width: store.state.runtimeType == state.runtimeType ? 28.0 : 9.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: store.state.runtimeType == state.runtimeType
                ? appTheme.colors.backgroundBlueColor
                : appTheme.colors.backgroundBlueColor.withValues(alpha: 0.5),
          ),
        );
      },
    );
  }
}
