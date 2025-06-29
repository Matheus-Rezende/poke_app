import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:poke_app/app/modules/onboard/interactor/repositories/onboard_repository.dart';
import 'package:poke_app/app/modules/onboard/interactor/states/onboard_state.dart';
part 'onboard_store.g.dart';

class OnboardStore = OnboardStoreBase with _$OnboardStore;

abstract class OnboardStoreBase with Store {
  final OnboardRepository onboardRepository;
  OnboardStoreBase({required this.onboardRepository});

  @observable
  OnboardState state = InitOnboardState();

  @observable
  PageController pageController = PageController();

  @action
  Future<void> showOnboard() async {
    state = await onboardRepository.showOnboarding();
  }

  @action
  Future<void> onPressedAdvance() async {
    if (state is FirstStepOnboardState) {
      state = state.secondStep();
    } else if (state is SecondStepOnboardState) {
      state = state.thirdStep();
    } else if (state is ThirdStepOnboardState) {
      onboardRepository.skipOnboarding(finished: true);
      state = state.skipOnboard();
    }
  }

  @action
  Future<void> skipOnboard() async {
    onboardRepository.skipOnboarding(finished: false);
    state = state.skipOnboard();
  }
}
