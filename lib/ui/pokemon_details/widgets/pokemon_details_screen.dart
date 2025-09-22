import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poke_app/ui/core/widgets/buttons/custom_button.dart';
import 'package:poke_app/ui/core/widgets/pokeball_loading.dart';
import 'package:poke_app/ui/core/widgets/pokemon_message.dart';
import 'package:poke_app/ui/pokemon_details/viewmodels/pokemon_details_viewmodel.dart';
import 'package:poke_app/ui/pokemon_details/widgets/pokemon_details_description.dart';
import 'package:poke_app/ui/pokemon_details/widgets/pokemon_details_header.dart';
import 'package:poke_app/ui/pokemon_details/widgets/pokemon_gender_rate.dart';
import 'package:poke_app/ui/pokemon_details/widgets/pokemon_species_characteristics.dart';
import 'package:poke_app/ui/pokemon_details/widgets/pokemon_weaknesses.dart';

class PokemonDetailsScreen extends StatelessWidget {
  final PokemonDetailsViewmodel pokemonDetailsViewmodel;
  const PokemonDetailsScreen({super.key, required this.pokemonDetailsViewmodel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: pokemonDetailsViewmodel.load,
        builder: (context, child) {
          if (pokemonDetailsViewmodel.load.running) {
            return const Center(child: PokeballLoading(isSliverWidget: false));
          }
          if (pokemonDetailsViewmodel.load.error) {
            return Padding(
              padding: const EdgeInsets.all(32.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    PokemonMessage(title: 'Não foi possível carregar os detalhes do pokémon'),
                    CustomButton(
                      title: 'Voltar para a tela inicial',
                      height: 40,
                      titleStyle: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                      backgroundColor: Theme.of(context).colorScheme.onSecondary,
                      onPressed: () => context.pop(),
                    ),
                  ],
                ),
              ),
            );
          }

          return child!;
        },
        child: ListenableBuilder(
          listenable: pokemonDetailsViewmodel,
          builder: (context, child) {
            return SingleChildScrollView(
              child: Column(
                spacing: 16.0,
                children: [
                  PokemonDetailsHeader(pokemonDetailsViewmodel: pokemonDetailsViewmodel),
                  PokemonDetailsDescription(pokemonDetailsViewmodel: pokemonDetailsViewmodel),
                  PokemonSpeciesCharacteristics(pokemonDetailsViewmodel: pokemonDetailsViewmodel),
                  PokemonGenderRate(pokemonDetailsViewmodel: pokemonDetailsViewmodel),
                  PokemonWeaknesses(typeWeaknesses: pokemonDetailsViewmodel.pokemon.weaknesses),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
