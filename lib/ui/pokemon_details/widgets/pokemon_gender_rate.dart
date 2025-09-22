import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poke_app/ui/core/themes/colors.dart';
import 'package:poke_app/ui/pokemon_details/viewmodels/pokemon_details_viewmodel.dart';

class PokemonGenderRate extends StatelessWidget {
  final PokemonDetailsViewmodel pokemonDetailsViewmodel;
  const PokemonGenderRate({super.key, required this.pokemonDetailsViewmodel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        spacing: 8.0,
        children: [
          Text(
            'GÊNERO',
            style: Theme.of(
              context,
            ).textTheme.labelSmall!.copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
          if (pokemonDetailsViewmodel.isGenderUnknown)
            Column(
              spacing: 8.0,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/svg/pokemon_information/unknown_gender_bar.svg',
                  width: MediaQuery.sizeOf(context).width,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.onPrimary,
                    BlendMode.srcIn,
                  ),
                ),
                Text(
                  'desconhecido',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          else
            Column(
              spacing: 8.0,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 8.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: pokemonDetailsViewmodel.femalePercentage > 0
                            ? AppColors.pokemonFairyColor
                            : AppColors.darkblue,
                      ),
                    ),
                    if (pokemonDetailsViewmodel.malePercentage > 0)
                      FractionallySizedBox(
                        widthFactor: pokemonDetailsViewmodel.malePercentage / 100,
                        child: Container(
                          height: 8.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.pokemonMale,
                          ),
                        ),
                      )
                    else if (pokemonDetailsViewmodel.femalePercentage > 0)
                      FractionallySizedBox(
                        widthFactor: pokemonDetailsViewmodel.femalePercentage / 100,
                        child: Container(
                          height: 8.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.pokemonFemale,
                          ),
                        ),
                      ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 4.0,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/svg/pokemon_species/male_icon.svg',
                          colorFilter: ColorFilter.mode(AppColors.grey3, BlendMode.srcIn),
                        ),
                        Text(
                          '${pokemonDetailsViewmodel.malePercentage.toStringAsFixed(1)}%',
                          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 4.0,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/svg/pokemon_species/female_icon.svg',
                          colorFilter: ColorFilter.mode(AppColors.grey3, BlendMode.srcIn),
                        ),
                        Text(
                          '${pokemonDetailsViewmodel.femalePercentage.toStringAsFixed(1)}%',
                          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
