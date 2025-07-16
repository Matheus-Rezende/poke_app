// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboard_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OnboardStore on OnboardStoreBase, Store {
  late final _$stateAtom = Atom(
    name: 'OnboardStoreBase.state',
    context: context,
  );

  @override
  OnboardState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(OnboardState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$pageControllerAtom = Atom(
    name: 'OnboardStoreBase.pageController',
    context: context,
  );

  @override
  PageController get pageController {
    _$pageControllerAtom.reportRead();
    return super.pageController;
  }

  @override
  set pageController(PageController value) {
    _$pageControllerAtom.reportWrite(value, super.pageController, () {
      super.pageController = value;
    });
  }

  late final _$showOnboardAsyncAction = AsyncAction(
    'OnboardStoreBase.showOnboard',
    context: context,
  );

  @override
  Future<void> showOnboard() {
    return _$showOnboardAsyncAction.run(() => super.showOnboard());
  }

  late final _$onPressedAdvanceAsyncAction = AsyncAction(
    'OnboardStoreBase.onPressedAdvance',
    context: context,
  );

  @override
  Future<void> onPressedAdvance() {
    return _$onPressedAdvanceAsyncAction.run(() => super.onPressedAdvance());
  }

  late final _$skipOnboardAsyncAction = AsyncAction(
    'OnboardStoreBase.skipOnboard',
    context: context,
  );

  @override
  Future<void> skipOnboard() {
    return _$skipOnboardAsyncAction.run(() => super.skipOnboard());
  }

  @override
  String toString() {
    return '''
state: ${state},
pageController: ${pageController}
    ''';
  }
}
