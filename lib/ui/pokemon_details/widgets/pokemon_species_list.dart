import 'package:flutter/material.dart';
import 'package:poke_app/ui/pokemon_details/viewmodels/pokemon_details_viewmodel.dart';
import 'package:poke_app/ui/pokemon_details/widgets/pokemon_species_card.dart';

class PokemonSpeciesList extends StatelessWidget {
  final PokemonDetailsViewmodel pokemonDetailsViewmodel;

  const PokemonSpeciesList({super.key, required this.pokemonDetailsViewmodel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 0.0,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        childAspectRatio: 2.0,
        children: [
          PokemonSpeciesCard(
            iconPath: 'assets/icons/svg/pokemon_species/weight_icon.svg',
            title: 'peso',
            information: pokemonDetailsViewmodel.formattedWeight,
          ),
          PokemonSpeciesCard(
            iconPath: 'assets/icons/svg/pokemon_species/height_icon.svg',
            title: 'altura',
            information: pokemonDetailsViewmodel.formattedHeight,
          ),
          PokemonSpeciesCard(
            iconPath: 'assets/icons/svg/pokemon_species/category_icon.svg',
            title: 'categoria',
            information: pokemonDetailsViewmodel.formattedCategory,
          ),
          PokemonSpeciesCard(
            iconPath: 'assets/icons/svg/pokemon_species/ability_icon.svg',
            title: 'habilidade',
            information: pokemonDetailsViewmodel.firstAbility,
          ),
        ],
      ),
    );
  }
}
