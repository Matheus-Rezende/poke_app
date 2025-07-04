import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_details_state.dart';
import 'package:poke_app/app/modules/pokedex/interactor/stories/pokemons/details/pokemon_informations/informations_pokemon_store.dart';
import 'package:poke_app/app/modules/pokedex/ui/widgets/pokemon_information_widget.dart';

class PokemonDimensionsWidget extends StatelessWidget {
  final InformationsPokemonStore store;

  const PokemonDimensionsWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return SliverToBoxAdapter(
          child: switch (store.pokemonDetailsState) {
            InitPokemonDetailsState() => Container(),
            LoadingPokemonDetailsState() => Container(),
            SuccessPokemonDetailsState(:final pokemon) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),

              child: GridView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.3,
                  crossAxisSpacing: 16.0,
                ),
                children: [
                  PokemonInformationWidget(
                    iconPath: 'assets/icons/svg/pokemon_informations/weight_icon.svg',
                    title: 'peso',
                    information: '${((pokemon.weight ?? 0) / 10).toStringAsFixed(1)} kg',
                  ),
                  PokemonInformationWidget(
                    iconPath: 'assets/icons/svg/pokemon_informations/height_icon.svg',
                    title: 'altura',
                    information: '${((pokemon.height ?? 0) / 10).toStringAsFixed(1)} m',
                  ),
                  PokemonInformationWidget(
                    iconPath: 'assets/icons/svg/pokemon_informations/ability_icon.svg',
                    title: 'habilidade 1',
                    information: pokemon.abilities![0],
                  ),
                  pokemon.abilities!.length == 2
                      ? PokemonInformationWidget(
                          iconPath: 'assets/icons/svg/pokemon_informations/ability_icon.svg',
                          title: 'habilidade 2',
                          information: pokemon.abilities![1],
                        )
                      : Container(),
                ],
              ),
            ),
            ErrorPokemonDetailsState(:final message) => Text(message),
          },
        );
      },
    );
  }
}
