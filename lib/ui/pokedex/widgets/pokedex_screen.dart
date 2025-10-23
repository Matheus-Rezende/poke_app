import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poke_app/routing/routes.dart';
import 'package:poke_app/ui/core/widgets/bottom_sheet/custom_bottom_sheet.dart';
import 'package:poke_app/ui/core/widgets/buttons/custom_button.dart';
import 'package:poke_app/ui/core/widgets/pokeball_loading.dart';
import 'package:poke_app/ui/core/widgets/pokemon_cards/pokemon_card.dart';
import 'package:poke_app/ui/core/widgets/pokemon_message.dart';
import 'package:poke_app/ui/core/widgets/textfields/custom_textfield.dart';
import 'package:poke_app/ui/pokedex/viewmodels/pokedex_viewmodel.dart';
import 'package:poke_app/ui/pokedex/viewmodels/search_pokemon_viewmodel.dart';
import 'package:poke_app/ui/pokedex/viewmodels/types_pokemon_viewmodel.dart';
import 'package:poke_app/ui/pokedex/widgets/pokedex_list.dart';
import 'package:poke_app/ui/pokedex/widgets/pokemon_types_bottom_sheet.dart';
import 'package:poke_app/ui/pokedex/widgets/pokemons_type_list.dart';

class PokedexScreen extends StatefulWidget {
  final PokedexViewmodel pokedexViewmodel;
  final SearchPokemonViewmodel searchPokemonViewmodel;
  final TypesPokemonViewmodel typesPokemonViewmodel;
  const PokedexScreen({
    super.key,
    required this.pokedexViewmodel,
    required this.searchPokemonViewmodel,
    required this.typesPokemonViewmodel,
  });

  @override
  State<PokedexScreen> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      widget.pokedexViewmodel.loadMore.execute();
      widget.typesPokemonViewmodel.loadMore.execute();
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomTextfield(
                onChanged: (value) {
                  if (widget.searchPokemonViewmodel.debounceSearch?.isActive ?? false) {
                    widget.searchPokemonViewmodel.debounceSearch!.cancel();
                  }
                  widget.searchPokemonViewmodel.debounceSearch = Timer(
                    const Duration(milliseconds: 500),
                    () {
                      widget.searchPokemonViewmodel.load.execute(value);
                      widget.searchPokemonViewmodel.searchText = value;
                    },
                  );
                },
              ),
            ),

            ListenableBuilder(
              listenable: widget.typesPokemonViewmodel,
              builder: (context, child) {
                return Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: CustomButton(
                    title: widget.typesPokemonViewmodel.pokemonTypeText,
                    width: sizeOf.width,
                    height: 48.0,
                    titleStyle: Theme.of(
                      context,
                    ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
                    backgroundColor: widget.typesPokemonViewmodel.pokemonTypeColor,
                    onPressed: () => showCustomBottomSheet(
                      context: context,
                      title: 'Selecione o tipo',
                      initialHeightFactor: 0.6,
                      child: PokemonTypesBottomSheet(
                        typesPokemonViewmodel: widget.typesPokemonViewmodel,
                        pokedexViewmodel: widget.pokedexViewmodel,
                      ),
                    ),
                  ),
                );
              },
            ),

            ListenableBuilder(
              listenable: Listenable.merge([
                widget.pokedexViewmodel,
                widget.searchPokemonViewmodel,
                widget.typesPokemonViewmodel,
              ]),
              builder: (context, child) {
                final pokedexViewmodel = widget.pokedexViewmodel;
                final searchViewmodel = widget.searchPokemonViewmodel;
                final typesViewModel = widget.typesPokemonViewmodel;

                final bool hasPokedexError =
                    pokedexViewmodel.load.error && pokedexViewmodel.pokedex.isEmpty;
                final bool hasSearchError =
                    searchViewmodel.load.error && searchViewmodel.searchText.isNotEmpty;

                final bool hasPokedexEmpty =
                    !pokedexViewmodel.load.running && pokedexViewmodel.pokedex.isEmpty;

                final bool hasLoading =
                    searchViewmodel.load.running ||
                    pokedexViewmodel.load.running ||
                    typesViewModel.load.running;

                final bool hasSearchSelected = searchViewmodel.searchText.isNotEmpty;

                final bool hasTypeSelected =
                    searchViewmodel.searchText.isEmpty && typesViewModel.hasSelectType;

                if (hasPokedexError) {
                  return Center(
                    child: PokemonMessage(title: 'Não foi possível carregar os Pokémons'),
                  );
                }

                if (hasPokedexEmpty) {
                  return PokemonMessage(
                    title: 'Hey treinador, sua pokedex está vazia :(',
                    subtitle: 'Vamos procurar novos pokémons para começar a coleção',
                  );
                }

                if (hasLoading) {
                  return const Center(child: PokeballLoading(isSliverWidget: false));
                }

                if (hasSearchError) {
                  return PokemonMessage(
                    title: 'Hey treinador, seu pokémon não existe :(',
                    subtitle: 'Verifique se digitou o nome dele corretamente',
                  );
                }
                if (hasSearchSelected) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: PokemonCard(
                      id: searchViewmodel.pokemon!.id,
                      name: searchViewmodel.pokemon!.name,
                      types: searchViewmodel.pokemon!.types,
                      imagePath: searchViewmodel.pokemon!.image,
                      onPressed: () => context.push(
                        Routes.pokemonDetails(searchViewmodel.pokemon!.id.toString()),
                      ),
                      favoriteOnPressed: () => print('Apertou no favorito'),
                    ),
                  );
                } else if (hasTypeSelected) {
                  return Expanded(
                    child: PokemonsTypeList(
                      typesPokemonViewmodel: typesViewModel,
                      scrollController: _scrollController,
                    ),
                  );
                } else {
                  return Expanded(
                    child: PokedexList(
                      pokedexViewmodel: pokedexViewmodel,
                      scrollController: _scrollController,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
