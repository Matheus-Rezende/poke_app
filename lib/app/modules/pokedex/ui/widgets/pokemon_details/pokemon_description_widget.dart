import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_description_state.dart';
import 'package:poke_app/app/modules/pokedex/interactor/stories/pokemons/details/pokemon_informations/informations_pokemon_store.dart';

class PokemonDescriptionWidget extends StatelessWidget {
  final InformationsPokemonStore store;

  const PokemonDescriptionWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    final appTheme = Modular.get<AppTheme>();
    return Observer(
      builder: (context) {
        return SliverToBoxAdapter(
          child: switch (store.pokemonDescriptionState) {
            InitPokemonDescriptionState() => Container(),
            LoadingPokemonDescriptionState() => Container(),
            SuccessPokemonDescriptionState(:final description) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                description.description ?? '',
                style: appTheme.typography.poppins14px().copyWith(
                  color: appTheme.colors.blackColor.withValues(alpha: 0.7),
                ),
              ),
            ),
            ErrorPokemonDescriptionState() => Container(),
          },
        );
      },
    );
  }
}
