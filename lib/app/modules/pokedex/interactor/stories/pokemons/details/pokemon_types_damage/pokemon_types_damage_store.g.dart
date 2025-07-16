// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_types_damage_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PokemonTypesDamageStore on PokemonTypesDamageStoreBase, Store {
  late final _$pokemonTypeDamageStateAtom = Atom(
    name: 'PokemonTypesDamageStoreBase.pokemonTypeDamageState',
    context: context,
  );

  @override
  PokemonTypeDamageState get pokemonTypeDamageState {
    _$pokemonTypeDamageStateAtom.reportRead();
    return super.pokemonTypeDamageState;
  }

  @override
  set pokemonTypeDamageState(PokemonTypeDamageState value) {
    _$pokemonTypeDamageStateAtom.reportWrite(
      value,
      super.pokemonTypeDamageState,
      () {
        super.pokemonTypeDamageState = value;
      },
    );
  }

  late final _$combinedDamagesAtom = Atom(
    name: 'PokemonTypesDamageStoreBase.combinedDamages',
    context: context,
  );

  @override
  List<String> get combinedDamages {
    _$combinedDamagesAtom.reportRead();
    return super.combinedDamages;
  }

  @override
  set combinedDamages(List<String> value) {
    _$combinedDamagesAtom.reportWrite(value, super.combinedDamages, () {
      super.combinedDamages = value;
    });
  }

  late final _$loadCombinedTypeDamagesAsyncAction = AsyncAction(
    'PokemonTypesDamageStoreBase.loadCombinedTypeDamages',
    context: context,
  );

  @override
  Future<void> loadCombinedTypeDamages(List<String> urls) {
    return _$loadCombinedTypeDamagesAsyncAction.run(
      () => super.loadCombinedTypeDamages(urls),
    );
  }

  @override
  String toString() {
    return '''
pokemonTypeDamageState: ${pokemonTypeDamageState},
combinedDamages: ${combinedDamages}
    ''';
  }
}
