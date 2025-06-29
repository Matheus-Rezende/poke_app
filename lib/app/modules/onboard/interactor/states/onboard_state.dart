sealed class OnboardState {
  OnboardState();
  InitOnboardState init() {
    return InitOnboardState();
  }

  FirstStepOnboardState firstStep() {
    return FirstStepOnboardState();
  }

  SecondStepOnboardState secondStep() {
    return SecondStepOnboardState();
  }

  ThirdStepOnboardState thirdStep() {
    return ThirdStepOnboardState();
  }

  SkipOnboardState skipOnboard() {
    return SkipOnboardState();
  }
}

class SecondStepOnboardState extends OnboardState {
  SecondStepOnboardState();
}

class ThirdStepOnboardState extends OnboardState {
  ThirdStepOnboardState();
}

class InitOnboardState extends OnboardState {
  InitOnboardState();
}

class FirstStepOnboardState extends OnboardState {
  FirstStepOnboardState();
}

class SkipOnboardState extends OnboardState {
  SkipOnboardState();
}
