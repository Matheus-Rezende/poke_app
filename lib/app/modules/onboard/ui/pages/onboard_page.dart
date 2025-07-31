import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:poke_app/app/core/routes/app_routes.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:poke_app/app/core/ui/widgets/buttons/custom_button_widget.dart';
import 'package:poke_app/app/modules/auth/interactor/utils/arguments/pre_auth_arguments.dart';
import 'package:poke_app/app/modules/onboard/interactor/states/onboard_state.dart';
import 'package:poke_app/app/modules/onboard/interactor/stories/onboard_store.dart';
import 'package:poke_app/app/modules/onboard/ui/widgets/onboard_widget.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> with TickerProviderStateMixin {
  final appTheme = Modular.get<AppTheme>();
  final store = Modular.get<OnboardStore>();

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: appTheme.colors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
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
                            iconSize: 16.0,
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
                    : const Expanded(child: SizedBox());
              },
            ),
            Observer(
              builder: (_) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    final inFromRight = Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: const Offset(0, 0),
                    ).animate(animation);
                    final outToLeft = Tween<Offset>(
                      begin: const Offset(-1, 0),
                      end: const Offset(0, 0),
                    ).animate(animation);

                    return SlideTransition(
                      position: animation.status == AnimationStatus.forward ? inFromRight : outToLeft,
                      child: child,
                    );
                  },
                  child: _buildStepWidget(store.state, sizeOf),
                );
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
                            children: [buildDot(FirstStepOnboardState()), buildDot(SecondStepOnboardState())],
                          ),
                    SizedBox(height: sizeOf.width * 0.06),
                    store.state is FirstStepOnboardState || store.state is SecondStepOnboardState
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: CustomButtonWidget(
                              title: store.state is FirstStepOnboardState ? 'Continuar' : 'Vamos começar!',
                              width: sizeOf.width,
                              height: 58.0,
                              borderRadius: 50.0,
                              onPressed: () async {
                                await store.onPressedAdvance();
                              },
                              titleStyle: appTheme.typography.poppins18px().copyWith(
                                color: appTheme.colors.whiteColor,
                                fontWeight: FontWeight.w500,
                              ),
                              backgroundColor: appTheme.colors.backgroundBlueColor,
                            ),
                          )
                        : Column(
                            children: [
                              CustomButtonWidget(
                                title: 'Criar conta',
                                width: sizeOf.width,
                                height: 58.0,
                                borderRadius: 50.0,
                                onPressed: () => Modular.to.pushNamed(
                                  AppRoutes.preAuth(),
                                  arguments: PreAuthArguments(
                                    appBarTitle: 'Criar conta',
                                    coachImagePath: 'assets/images/png/coaches/coach_6.png',
                                    title: 'Falta pouco para explorar esse mundo!',
                                    subtitle: 'Como deseja se conectar?',
                                    isRegister: true,
                                  ),
                                ),
                                titleStyle: appTheme.typography.poppins18px().copyWith(
                                  color: appTheme.colors.whiteColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                backgroundColor: appTheme.colors.backgroundBlueColor,
                              ),
                              const SizedBox(height: 8.0),
                              CustomButtonWidget(
                                title: 'Já tenho uma conta',
                                width: sizeOf.width,
                                height: 58.0,
                                borderRadius: 50.0,
                                onPressed: () => Modular.to.pushNamed(
                                  AppRoutes.preAuth(),
                                  arguments: PreAuthArguments(
                                    appBarTitle: 'Entrar',
                                    coachImagePath: 'assets/images/png/coaches/coach_7.png',

                                    title: 'Que bom te ver aqui novamente!',
                                    subtitle: 'Como deseja se conectar?',
                                    isRegister: false,
                                  ),
                                ),
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

  Widget _buildStepWidget(OnboardState state, Size sizeOf) {
    return SizedBox(
      key: ValueKey(state.runtimeType),
      width: double.infinity,
      child: switch (state) {
        InitOnboardState() => Container(),
        SkipOnboardState() => Container(),
        FirstStepOnboardState() => OnboardWidget(
          pathCoach1: 'assets/images/png/coaches/coach_1.png',
          widthCoach1: sizeOf.width * 0.7,
          pathCoach2: 'assets/images/png/coaches/coach_2.png',
          title: 'Todos os Pokémons em um só Lugar',
          subtitle: 'Acesse uma vasta lista de Pokémon de todas as gerações já feitas pela Nintendo',
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
      },
    );
  }

  Widget buildDot(OnboardState state) {
    final isActive = store.state.runtimeType == state.runtimeType;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 9,
      width: isActive ? 28 : 9,
      decoration: BoxDecoration(
        color: isActive
            ? appTheme.colors.backgroundBlueColor
            : appTheme.colors.backgroundBlueColor.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
