// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  final ScrollController scrollController = ScrollController();

  final FocusNode searchFocusNode = FocusNode();

  void initScrollController({required bool isFetchNextPokemons}) {
    scrollController.addListener(() {
      if (!pokemonsTypeStore.isFilterTypeSelected && isFetchNextPokemons) {
        if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100) {
          pokemonsStore.fetchNext();
        }
      }
      if (searchFocusNode.hasFocus) {
        searchFocusNode.unfocus();
      }
    });
  }
}
