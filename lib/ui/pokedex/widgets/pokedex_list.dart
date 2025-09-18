import 'package:flutter/material.dart';
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
      controller: scrollController, // Conecta o controller à lista
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 120.0), // Padding para o menu
      // MUDANÇA 7: O tamanho da lista agora considera o item de 'loading' no final.
      itemCount: pokedexViewmodel.pokedex.length + (pokedexViewmodel.hasMore ? 1 : 0),
      separatorBuilder: (context, index) => const SizedBox(height: 16.0),
      itemBuilder: (context, index) {
        print(pokedexViewmodel.pokedex.length);
        // MUDANÇA 8: Lógica para exibir o card ou o indicador de 'carregando mais'.
        if (index == pokedexViewmodel.pokedex.length) {
          // Se for o último item, exibe o spinner de 'carregando mais'.
          return const Center(child: PokeballLoading(isSliverWidget: false));
        }

        final pokemon = pokedexViewmodel.pokedex[index];
        return PokemonCard(
          id: pokemon.id,
          name: pokemon.name,
          types: pokemon.types,
          imagePath: pokemon.image,
          onPressed: () => print('Apertou no card ${pokemon.name}'),
          favoriteOnPressed: () => print('Apertou no favorito'),
        );
      },
    );
  }
}
