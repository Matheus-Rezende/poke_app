import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poke_app/routing/routes.dart';
import 'package:poke_app/ui/core/widgets/pokeball_loading.dart';
import 'package:poke_app/ui/core/widgets/pokemon_cards/pokemon_card.dart';
import 'package:poke_app/ui/pokedex/viewmodels/types_pokemons_viewmodel.dart';

class PokemonsTypeList extends StatelessWidget {
  final TypesPokemonViewmodel typesPokemonViewmodel;
  final ScrollController scrollController;
  const PokemonsTypeList({
    super.key,
    required this.typesPokemonViewmodel,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 120.0),
      itemCount:
          typesPokemonViewmodel.pokemonsByType.length +
          (typesPokemonViewmodel.filteredHasMore ? 1 : 0),
      separatorBuilder: (context, index) => const SizedBox(height: 16.0),
      itemBuilder: (context, index) {
        if (index == typesPokemonViewmodel.pokemonsByType.length) {
          return const Center(child: PokeballLoading(isSliverWidget: false));
        }

        final pokemon = typesPokemonViewmodel.pokemonsByType[index];
        return PokemonCard(
          id: pokemon.id,
          name: pokemon.name,
          types: pokemon.types,
          imagePath: pokemon.imageUrl,
          onPressed: () => context.push(Routes.pokemonDetails(pokemon.id.toString())),
          favoriteOnPressed: () => print('Apertou no favorito'),
        );
      },
    );
  }
}
