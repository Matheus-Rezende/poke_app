import 'package:flutter/material.dart';
import 'package:poke_app/domain/models/pokemon/pokemon.dart';
import 'package:poke_app/ui/core/widgets/pokemon_cards/pokemon_card.dart';
import 'package:poke_app/ui/core/widgets/pokemon_message.dart';

class PokedexList extends StatelessWidget {
  final List<Pokemon> pokedex;
  const PokedexList({super.key, required this.pokedex});

  @override
  Widget build(BuildContext context) {
    if (pokedex.isEmpty) {
      return PokemonMessage(
        title: 'Hey treinador, sua pokedex está vazia :(',
        subtitle: 'Vamos procurar novos pokémons para começar a coleção',
      );
    }
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 112.0),
      itemCount: pokedex.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 16.0);
      },
      itemBuilder: (context, index) {
        return PokemonCard(
          id: pokedex[index].id,
          name: pokedex[index].name,
          types: pokedex[index].types,
          imagePath: pokedex[index].image,
          onPressed: () => print('Apertou no card'),
          favoriteOnPressed: () => print('Apertou no favorito'),
        );
      },
    );
  }
}
