import 'package:poke_app/app/core/data/services/local_storage/local_storage.dart';
import 'package:poke_app/app/modules/onboard/interactor/repositories/onboard_repository.dart';
import 'package:poke_app/app/modules/onboard/interactor/states/onboard_state.dart';

class OnboardRepositoryImpl implements OnboardRepository {
  final LocalStorage localStorage;

  OnboardRepositoryImpl({required this.localStorage});
  @override
  Future<OnboardState> showOnboarding() async {
    if (await localStorage.contains(key: 'skipOnboard')) {
      bool result = await localStorage.getItem(key: 'skipOnboard');
      return result ? SkipOnboardState() : FirstStepOnboardState();
    } else {
      return FirstStepOnboardState();
    }
  }

  @override
  Future<void> skipOnboarding({required bool finished}) async {
    await localStorage.setItem(key: 'skipOnboard', value: finished);
  }
}
