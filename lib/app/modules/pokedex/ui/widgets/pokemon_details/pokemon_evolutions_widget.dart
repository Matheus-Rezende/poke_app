import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:poke_app/app/core/ui/widgets/loadings/custom_loading_widget.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_evolution_stage_state.dart';
import 'package:poke_app/app/modules/pokedex/interactor/stories/pokemons/details/pokemon_evolutions/evolutions_pokemon_store.dart';
import 'package:poke_app/app/modules/pokedex/ui/widgets/pokemon_evolution_card_widget.dart';

class PokemonEvolutionsWidget extends StatefulWidget {
  final String url;
  const PokemonEvolutionsWidget({super.key, required this.url});

  @override
  State<PokemonEvolutionsWidget> createState() => _PokemonEvolutionsWidgetState();
}

class _PokemonEvolutionsWidgetState extends State<PokemonEvolutionsWidget> {
  final appTheme = Modular.get<AppTheme>();
  final store = Modular.get<EvolutionsPokemonStore>();

  @override
  void initState() {
    store.evolutionStagePokemon(url: widget.url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Column(
        spacing: 8.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              'Evoluções',
              style: appTheme.typography.poppins18px().copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          Observer(
            builder: (context) {
              return switch (store.pokemonEvolutionStageState) {
                InitPokemonEvolutionStageState() => Container(),
                LoadingPokemonEvolutionStageState() => CustomLoadingWidget(isSliverWidget: false),
                SuccessPokemonEvolutionStageState(:final evolutions) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: appTheme.colors.greyE6Color),
                  ),

                  child: Column(
                    spacing: 16.0,
                    children: List.generate(evolutions.length, (index) {
                      final results = store.pokemonEvolutionsDetails[evolutions[index].name];
                      if (results == null) {
                        return Center(child: CustomLoadingWidget(isSliverWidget: false));
                      }
                      return Column(
                        spacing: 16.0,
                        children: [
                          PokemonEvolutionCardWidget(
                            id: results.pokemon.id ?? 0,
                            imagePath: results.pokemon.imagePath ?? '',
                            name: evolutions[index].name,
                            theme: appTheme,
                            types: results.pokemon.types ?? [],
                          ),
                          Row(
                            spacing: 8.0,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              index == evolutions.length - 1
                                  ? Container()
                                  : SvgPicture.asset(
                                      'assets/icons/svg/pokemon_informations/arrow_down_icon.svg',
                                    ),
                              Text(
                                evolutions[index].evolutionTriggerText,
                                style: appTheme.typography.poppins14px().copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: appTheme.colors.backgroundBlueColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                ErrorPokemonEvolutionStageState(:final message) => Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                  child: Text(
                    message,
                    style: appTheme.typography.poppins14px().copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              };
            },
          ),
        ],
      ),
    );
  }
}
