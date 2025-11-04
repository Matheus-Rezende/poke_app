import 'package:flutter/material.dart';
import 'package:poke_app/ui/core/widgets/pokeball_loading.dart';
import 'package:poke_app/ui/core/widgets/pokemon_message.dart';
import 'package:poke_app/ui/regions/viewmodels/regions_viewmodel.dart';
import 'package:poke_app/ui/regions/widgets/region_card.dart';
import 'package:poke_app/utils/constants/regions/pokemon_region_images.dart';

class RegionsScreen extends StatelessWidget {
  final RegionsViewmodel regionsViewmodel;
  const RegionsScreen({super.key, required this.regionsViewmodel});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: regionsViewmodel,
      builder: (context, child) {
        final bool hasError = regionsViewmodel.load.error;
        final bool hasLoading = regionsViewmodel.load.running;

        if (hasError) {
          return Center(child: PokemonMessage(title: 'Não foi possível carregar as regiões.'));
        }

        if (hasLoading) {
          return const Center(child: PokeballLoading(isSliverWidget: false));
        }

        return Padding(
          padding: EdgeInsetsGeometry.only(left: 16.0, right: 16.0, bottom: 120.0),
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 12),
            itemCount: regionsViewmodel.regions.length,

            itemBuilder: (context, index) {
              final region = regionsViewmodel.regions[index];
              return RegionCard(
                regionName: region.regionName,
                generationName: region.generationName,
                backgroundImagePath: PokemonRegionImages.imageForGeneration(region.generationName),
              );
            },
          ),
        );
      },
    );
  }
}
