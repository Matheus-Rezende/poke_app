// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CoreStore on CoreStoreBase, Store {
  Computed<bool>? _$isLightComputed;

  @override
  bool get isLight => (_$isLightComputed ??= Computed<bool>(
    () => super.isLight,
    name: 'CoreStoreBase.isLight',
  )).value;

  late final _$themeStateAtom = Atom(
    name: 'CoreStoreBase.themeState',
    context: context,
  );

  @override
  AppThemeState get themeState {
    _$themeStateAtom.reportRead();
    return super.themeState;
  }

  @override
  set themeState(AppThemeState value) {
    _$themeStateAtom.reportWrite(value, super.themeState, () {
      super.themeState = value;
    });
  }

  late final _$changeThemeAsyncAction = AsyncAction(
    'CoreStoreBase.changeTheme',
    context: context,
  );

  @override
  Future changeTheme() {
    return _$changeThemeAsyncAction.run(() => super.changeTheme());
  }

  late final _$loadThemeAsyncAction = AsyncAction(
    'CoreStoreBase.loadTheme',
    context: context,
  );

  @override
  Future loadTheme() {
    return _$loadThemeAsyncAction.run(() => super.loadTheme());
  }

  @override
  String toString() {
    return '''
themeState: ${themeState},
isLight: ${isLight}
    ''';
  }
}
