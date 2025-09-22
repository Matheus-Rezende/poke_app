import 'package:flutter/material.dart';
import 'package:poke_app/ui/pokemon_details/viewmodels/pokemon_details_viewmodel.dart';

class PokemonDetailsDescription extends StatelessWidget {
  final PokemonDetailsViewmodel pokemonDetailsViewmodel;

  const PokemonDetailsDescription({super.key, required this.pokemonDetailsViewmodel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Align(
        alignment: AlignmentGeometry.centerLeft,
        child: Text(
          pokemonDetailsViewmodel.formattedDescription,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
