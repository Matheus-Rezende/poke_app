import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poke_app/routing/routes.dart';
import 'package:poke_app/ui/core/widgets/pokeball_loading.dart';
import 'package:poke_app/ui/core/widgets/pokemon_cards/pokemon_card.dart';
import 'package:poke_app/ui/pokedex/viewmodels/pokedex_viewmodel.dart';

class PokedexList extends StatelessWidget {
  final PokedexViewmodel pokedexViewmodel;
  final ScrollController scrollController;
  const PokedexList({super.key, required this.pokedexViewmodel, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 120.0),
      itemCount: pokedexViewmodel.pokedex.length + (pokedexViewmodel.hasMore ? 1 : 0),
      separatorBuilder: (context, index) => const SizedBox(height: 16.0),
      itemBuilder: (context, index) {
        if (index == pokedexViewmodel.pokedex.length) {
          return const Center(child: PokeballLoading(isSliverWidget: false));
        }

        final pokemon = pokedexViewmodel.pokedex[index];
        return PokemonCard(
          id: pokemon.id,
          name: pokemon.name,
          types: pokemon.types,
          imagePath: pokemon.image,
          onPressed: () => context.push(Routes.pokemonDetails(pokemon.name)),
          favoriteOnPressed: () => print('Apertou no favorito'),
        );
      },
    );
  }
}
