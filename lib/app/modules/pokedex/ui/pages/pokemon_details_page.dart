import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:poke_app/app/core/ui/widgets/loadings/custom_loading_widget.dart';
import 'package:poke_app/app/core/ui/widgets/messages/message_widget.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_description_state.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_details_state.dart';
import 'package:poke_app/app/modules/pokedex/interactor/stories/pokemons/details/pokemon_informations/informations_pokemon_store.dart';
import 'package:poke_app/app/modules/pokedex/ui/widgets/pokemon_details/pokemon_damages_widget.dart';
import 'package:poke_app/app/modules/pokedex/ui/widgets/pokemon_details/pokemon_description_widget.dart';
import 'package:poke_app/app/modules/pokedex/ui/widgets/pokemon_details/pokemon_dimensions_widget.dart';
import 'package:poke_app/app/modules/pokedex/ui/widgets/pokemon_details/pokemon_evolutions_widget.dart';
import 'package:poke_app/app/modules/pokedex/ui/widgets/pokemon_details/pokemon_gender_rate_widget.dart';
import 'package:poke_app/app/modules/pokedex/ui/widgets/pokemon_details/pokemon_header_widget.dart';

class PokemonDetailsPage extends StatefulWidget {
  final String pokemon;
  const PokemonDetailsPage({super.key, required this.pokemon});

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> with TickerProviderStateMixin {
  final informationPokemonStore = Modular.get<InformationsPokemonStore>();
  final appTheme = Modular.get<AppTheme>();

  @override
  void initState() {
    super.initState();
    informationPokemonStore.descriptionPokemon(pokemon: widget.pokemon);
    informationPokemonStore.detailsPokemon(pokemon: widget.pokemon);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (context) {
          if (informationPokemonStore.isLoadingMainDetails) {
            return const Center(child: CustomLoadingWidget(isSliverWidget: false));
          }

          if (informationPokemonStore.isErrorMainDetails) {
            return Center(
              child: MessageWidget(
                theme: appTheme,
                title: 'Um erro aconteceu',
                subtitle: 'Houve uma falha na comunicação com o servidor',
                useSliverWidget: false,
                padding: EdgeInsetsGeometry.symmetric(horizontal: 32),
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              _pokemonHeader(),
              _pokemonDescription(),
              _pokemonDimensions(),
              _pokemonGenderRate(),
              _pokemonDamages(),
              _pokemonEvolutions(),
            ],
          );
        },
      ),
    );
  }

  Widget _pokemonHeader() {
    return PokemonHeaderWidget(store: informationPokemonStore);
  }

  Widget _pokemonDescription() {
    return PokemonDescriptionWidget(store: informationPokemonStore);
  }

  Widget _pokemonDimensions() {
    return PokemonDimensionsWidget(store: informationPokemonStore);
  }

  Widget _pokemonGenderRate() {
    return PokemonGenderRateWidget(store: informationPokemonStore);
  }

  Widget _pokemonDamages() {
    return SliverToBoxAdapter(
      child: switch (informationPokemonStore.pokemonDetailsState) {
        InitPokemonDetailsState() => Container(),
        SuccessPokemonDetailsState(:final pokemon) => PokemonDamagesWidget(urls: pokemon.typeUrls ?? []),
        LoadingPokemonDetailsState() => Container(),
        ErrorPokemonDetailsState() => Container(),
      },
    );
  }

  Widget _pokemonEvolutions() {
    return SliverToBoxAdapter(
      child: switch (informationPokemonStore.pokemonDescriptionState) {
        InitPokemonDescriptionState() => Container(),
        SuccessPokemonDescriptionState(:final description) => PokemonEvolutionsWidget(
          url: description.evolutionChainUrl ?? '',
        ),
        LoadingPokemonDescriptionState() => Container(),
        ErrorPokemonDescriptionState() => Container(),
      },
    );
  }
}
