import 'package:flutter/material.dart';
import 'package:poke_app/ui/pokemon_details/viewmodels/pokemon_details_viewmodel.dart';
import 'package:poke_app/ui/pokemon_details/widgets/pokemon_species_characteristic_card.dart';
import 'package:poke_app/utils/assets/app_assets.dart';

class PokemonSpeciesCharacteristics extends StatelessWidget {
  final PokemonDetailsViewmodel pokemonDetailsViewmodel;

  const PokemonSpeciesCharacteristics({super.key, required this.pokemonDetailsViewmodel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 0.0,
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 0.0),
        childAspectRatio: 2.0,
        children: [
          PokemonSpeciesCharacteristicCard(
            iconPath: AppAssets.pokemonCharacteristics.weight,
            title: 'peso',
            information: pokemonDetailsViewmodel.formattedWeight,
          ),
          PokemonSpeciesCharacteristicCard(
            iconPath: AppAssets.pokemonCharacteristics.height,
            title: 'altura',
            information: pokemonDetailsViewmodel.formattedHeight,
          ),
          PokemonSpeciesCharacteristicCard(
            iconPath: AppAssets.pokemonCharacteristics.category,
            title: 'categoria',
            information: pokemonDetailsViewmodel.formattedCategory,
          ),
          PokemonSpeciesCharacteristicCard(
            iconPath: AppAssets.pokemonCharacteristics.ability,
            title: 'habilidade',
            information: pokemonDetailsViewmodel.firstAbility,
          ),
        ],
      ),
    );
  }
}
