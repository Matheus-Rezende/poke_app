// core_store.dart
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'package:poke_app/app/modules/pokedex/interactor/stories/pokemons/pokemons_store.dart';
import 'package:poke_app/app/modules/pokedex/interactor/stories/pokemons/type/pokemons_type_store.dart';

part 'core_store.g.dart';

class CoreStore = CoreStoreBase with _$CoreStore;

abstract class CoreStoreBase with Store {
  final PokemonsStore pokemonsStore;
  final PokemonsTypeStore pokemonsTypeStore;

  CoreStoreBase({required this.pokemonsStore, required this.pokemonsTypeStore});

  final Map<String, ScrollController> _scrollControllers = {};
  final FocusNode searchFocusNode = FocusNode();

  ScrollController getScrollController(String key) {
    return _scrollControllers.putIfAbsent(key, () => ScrollController());
  }

  void initScrollListener({required String key, required bool isFetchNextPokemons}) {
    final controller = getScrollController(key);

    controller.removeListener(() => _scrollListener(key, isFetchNextPokemons));
    controller.addListener(() => _scrollListener(key, isFetchNextPokemons));
  }

  void _scrollListener(String key, bool isFetchNextPokemons) {
    final controller = _scrollControllers[key];
    if (controller == null) return;

    if (!pokemonsTypeStore.isFilterTypeSelected && isFetchNextPokemons) {
      if (controller.position.pixels >= controller.position.maxScrollExtent - 100) {
        pokemonsStore.fetchNext();
      }
    }

    if (searchFocusNode.hasFocus) {
      searchFocusNode.unfocus();
    }
  }

  void disposeScrollController(String key) {
    _scrollControllers[key]?.dispose();
    _scrollControllers.remove(key);
  }

  void disposeFocusNode() {
    searchFocusNode.dispose();
  }
}
