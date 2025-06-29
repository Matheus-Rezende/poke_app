import 'package:poke_app/app/modules/onboard/interactor/states/onboard_state.dart';

abstract interface class OnboardRepository {
  Future<OnboardState> showOnboarding();
  Future<void> skipOnboarding({required bool finished});
}
