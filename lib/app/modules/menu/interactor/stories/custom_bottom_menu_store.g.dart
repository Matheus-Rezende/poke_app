// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_bottom_menu_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CustomBottomMenuStore on CustomBottomMenuStoreBase, Store {
  late final _$selectedIndexAtom = Atom(
    name: 'CustomBottomMenuStoreBase.selectedIndex',
    context: context,
  );

  @override
  int get selectedIndex {
    _$selectedIndexAtom.reportRead();
    return super.selectedIndex;
  }

  @override
  set selectedIndex(int value) {
    _$selectedIndexAtom.reportWrite(value, super.selectedIndex, () {
      super.selectedIndex = value;
    });
  }

  late final _$CustomBottomMenuStoreBaseActionController = ActionController(
    name: 'CustomBottomMenuStoreBase',
    context: context,
  );

  @override
  void onItemTapped(int index) {
    final _$actionInfo = _$CustomBottomMenuStoreBaseActionController
        .startAction(name: 'CustomBottomMenuStoreBase.onItemTapped');
    try {
      return super.onItemTapped(index);
    } finally {
      _$CustomBottomMenuStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedIndex: ${selectedIndex}
    ''';
  }
}
