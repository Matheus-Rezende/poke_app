import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poke_app/ui/core/themes/colors.dart';
import 'package:poke_app/ui/pokemon_details/viewmodels/pokemon_details_viewmodel.dart';
import 'package:poke_app/ui/pokemon_details/widgets/pokemon_evolution_card.dart';

class PokemonEvolutions extends StatelessWidget {
  final PokemonDetailsViewmodel pokemonDetailsViewmodel;
  const PokemonEvolutions({super.key, required this.pokemonDetailsViewmodel});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDarkTheme = theme.brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 36.0),
      child: Column(
        spacing: 8.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Evoluções', style: Theme.of(context).textTheme.titleMedium),
          pokemonDetailsViewmodel.pokemon.evolutionChain.isEmpty
              ? Text(
                  'Este pokémon não possui evoluções.',
                  style: Theme.of(context).textTheme.labelSmall,
                )
              : Container(
                  padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                    ),
                  ),

                  child: Column(
                    spacing: 16.0,
                    children: List.generate(pokemonDetailsViewmodel.pokemon.evolutionChain.length, (
                      index,
                    ) {
                      final evolutions = pokemonDetailsViewmodel.pokemon.evolutionChain;
                      return Column(
                        spacing: 16.0,
                        children: [
                          PokemonEvolutionCard(
                            evolutionStep: evolutions[index],
                            pokemonCurrentName: pokemonDetailsViewmodel.pokemon.name,
                          ),
                          Row(
                            spacing: 8.0,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              index == evolutions.length - 1
                                  ? Container()
                                  : SvgPicture.asset(
                                      'assets/icons/svg/pokemon_species/arrow_down_icon.svg',
                                      colorFilter: ColorFilter.mode(
                                        isDarkTheme ? AppColors.white1 : AppColors.darkblue,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                              Text(
                                evolutions[index].triggerDescription ?? 'Initial',
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: isDarkTheme ? AppColors.white1 : AppColors.darkblue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                  ),
                ),
        ],
      ),
    );
  }
}
