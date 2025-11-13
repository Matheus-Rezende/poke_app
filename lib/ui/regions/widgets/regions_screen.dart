import 'package:flutter/material.dart';
import 'package:poke_app/ui/core/widgets/app_bar/custom_app_bar.dart';
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
    return Scaffold(
      appBar: CustomAppBarWidget(
        appBarHeight: 66.0,
        widget: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 24.0,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Regiões',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Divider(height: 0, thickness: 1.0),
            ],
          ),
        ),
      ),
      body: ListenableBuilder(
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

          return ListView.separated(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 120.0),
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
          );
        },
      ),
    );
  }
}
