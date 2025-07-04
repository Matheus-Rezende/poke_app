import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:poke_app/app/core/ui/widgets/buttons/custom_button_widget.dart';
import 'package:poke_app/app/modules/pokedex/interactor/stories/pokemons/details/pokemon_types/types_pokemon_store.dart';
import 'package:poke_app/app/modules/pokedex/interactor/stories/pokemons/pokemons_store.dart';

class BottomSheetTypesWidget extends StatelessWidget {
  final AppTheme theme;
  final TypesPokemonStore typesPokemonStore;
  final PokemonsStore pokemonsStore;
  const BottomSheetTypesWidget({
    super.key,
    required this.theme,
    required this.typesPokemonStore,
    required this.pokemonsStore,
  });

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24.0, left: 16.0, right: 16.0),
        child: Column(
          spacing: 16.0,
          children: [
            CustomButtonWidget(
              title: 'Todos os tipos',
              height: 42.0,
              width: sizeOf.width,
              padding: 0.0,
              borderRadius: 49.0,
              titleStyle: theme.typography.poppins14px().copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colors.whiteColor,
              ),
              backgroundColor: theme.colors.blackColor.withValues(alpha: 0.75),
              onPressed: () {
                typesPokemonStore.changeButtonTypePokemons(text: 'Todos os tipos');
                pokemonsStore.fetchInitial();
                typesPokemonStore.isFilterTypeSelected = false;
                Modular.to.pop();
              },
            ),
            CustomButtonWidget(
              title: 'Água',
              height: 42.0,
              width: sizeOf.width,
              padding: 0.0,
              borderRadius: 49.0,
              titleStyle: theme.typography.poppins14px().copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colors.blackColor,
              ),
              backgroundColor: theme.colors.pokemonWaterColor,
              onPressed: () {
                typesPokemonStore.changeButtonTypePokemons(text: 'Água');
                typesPokemonStore.typePokemon(pokemonType: 'water');
                Modular.to.pop();
              },
            ),
            CustomButtonWidget(
              title: 'Dragão',
              height: 42.0,
              width: sizeOf.width,
              padding: 0.0,
              borderRadius: 49.0,
              titleStyle: theme.typography.poppins14px().copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colors.whiteColor,
              ),
              backgroundColor: theme.colors.pokemonDragonColor,
              onPressed: () {
                typesPokemonStore.changeButtonTypePokemons(text: 'Dragão');
                typesPokemonStore.typePokemon(pokemonType: 'dragon');

                Modular.to.pop();
              },
            ),
            CustomButtonWidget(
              title: 'Elétrico',
              height: 42.0,
              width: sizeOf.width,
              padding: 0.0,
              borderRadius: 49.0,
              titleStyle: theme.typography.poppins14px().copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colors.blackColor,
              ),
              backgroundColor: theme.colors.pokemonEletricColor,
              onPressed: () {
                typesPokemonStore.changeButtonTypePokemons(text: 'Elétrico');
                typesPokemonStore.typePokemon(pokemonType: 'electric');

                Modular.to.pop();
              },
            ),
            CustomButtonWidget(
              title: 'Fada',
              height: 42.0,
              width: sizeOf.width,
              padding: 0.0,
              borderRadius: 49.0,
              titleStyle: theme.typography.poppins14px().copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colors.blackColor,
              ),
              backgroundColor: theme.colors.pokemonFairyColor,
              onPressed: () {
                typesPokemonStore.changeButtonTypePokemons(text: 'Fada');
                typesPokemonStore.typePokemon(pokemonType: 'fairy');

                Modular.to.pop();
              },
            ),
            CustomButtonWidget(
              title: 'Fantasma',
              height: 42.0,
              width: sizeOf.width,
              padding: 0.0,
              borderRadius: 49.0,
              titleStyle: theme.typography.poppins14px().copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colors.whiteColor,
              ),
              backgroundColor: theme.colors.pokemonGhostColor,
              onPressed: () {
                typesPokemonStore.changeButtonTypePokemons(text: 'Fantasma');
                typesPokemonStore.typePokemon(pokemonType: 'ghost');

                Modular.to.pop();
              },
            ),
            CustomButtonWidget(
              title: 'Fogo',
              height: 42.0,
              width: sizeOf.width,
              padding: 0.0,
              borderRadius: 49.0,
              titleStyle: theme.typography.poppins14px().copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colors.blackColor,
              ),
              backgroundColor: theme.colors.pokemonFireColor,
              onPressed: () {
                typesPokemonStore.changeButtonTypePokemons(text: 'Fogo');
                typesPokemonStore.typePokemon(pokemonType: 'fire');

                Modular.to.pop();
              },
            ),
            CustomButtonWidget(
              title: 'Gelo',
              height: 42.0,
              width: sizeOf.width,
              padding: 0.0,
              borderRadius: 49.0,
              titleStyle: theme.typography.poppins14px().copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colors.blackColor,
              ),
              backgroundColor: theme.colors.pokemonIceColor,
              onPressed: () {
                typesPokemonStore.changeButtonTypePokemons(text: 'Gelo');
                typesPokemonStore.typePokemon(pokemonType: 'ice');

                Modular.to.pop();
              },
            ),
            CustomButtonWidget(
              title: 'Grama',
              height: 42.0,
              width: sizeOf.width,
              padding: 0.0,
              borderRadius: 49.0,
              titleStyle: theme.typography.poppins14px().copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colors.blackColor,
              ),
              backgroundColor: theme.colors.pokemonGrassColor,
              onPressed: () {
                typesPokemonStore.changeButtonTypePokemons(text: 'Grama');
                typesPokemonStore.typePokemon(pokemonType: 'grass');

                Modular.to.pop();
              },
            ),
            CustomButtonWidget(
              title: 'Inseto',
              height: 42.0,
              width: sizeOf.width,
              padding: 0.0,
              borderRadius: 49.0,
              titleStyle: theme.typography.poppins14px().copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colors.blackColor,
              ),
              backgroundColor: theme.colors.pokemonBugColor,
              onPressed: () {
                typesPokemonStore.changeButtonTypePokemons(text: 'Inseto');
                typesPokemonStore.typePokemon(pokemonType: 'bug');

                Modular.to.pop();
              },
            ),
            CustomButtonWidget(
              title: 'Lutador',
              height: 42.0,
              width: sizeOf.width,
              padding: 0.0,
              borderRadius: 49.0,
              titleStyle: theme.typography.poppins14px().copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colors.whiteColor,
              ),
              backgroundColor: theme.colors.pokemonFightingColor,
              onPressed: () {
                typesPokemonStore.changeButtonTypePokemons(text: 'Lutador');
                typesPokemonStore.typePokemon(pokemonType: 'fighting');

                Modular.to.pop();
              },
            ),
            CustomButtonWidget(
              title: 'Normal',
              height: 42.0,
              width: sizeOf.width,
              padding: 0.0,
              borderRadius: 49.0,
              titleStyle: theme.typography.poppins14px().copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colors.blackColor,
              ),
              backgroundColor: theme.colors.pokemonNormalColor,
              onPressed: () {
                typesPokemonStore.changeButtonTypePokemons(text: 'Normal');
                typesPokemonStore.typePokemon(pokemonType: 'normal');

                Modular.to.pop();
              },
            ),
            CustomButtonWidget(
              title: 'Noturno',
              height: 42.0,
              width: sizeOf.width,
              padding: 0.0,
              borderRadius: 49.0,
              titleStyle: theme.typography.poppins14px().copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colors.whiteColor,
              ),
              backgroundColor: theme.colors.pokemonDarkColor,
              onPressed: () {
                typesPokemonStore.changeButtonTypePokemons(text: 'Noturno');
                typesPokemonStore.typePokemon(pokemonType: 'dark');

                Modular.to.pop();
              },
            ),
            CustomButtonWidget(
              title: 'Metal',
              height: 42.0,
              width: sizeOf.width,
              padding: 0.0,
              borderRadius: 49.0,
              titleStyle: theme.typography.poppins14px().copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colors.blackColor,
              ),
              backgroundColor: theme.colors.pokemonSteelColor,
              onPressed: () {
                typesPokemonStore.changeButtonTypePokemons(text: 'Metal');
                typesPokemonStore.typePokemon(pokemonType: 'steel');

                Modular.to.pop();
              },
            ),
            CustomButtonWidget(
              title: 'Pedra',
              height: 42.0,
              width: sizeOf.width,
              padding: 0.0,
              borderRadius: 49.0,
              titleStyle: theme.typography.poppins14px().copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colors.blackColor,
              ),
              backgroundColor: theme.colors.pokemonRockColor,
              onPressed: () {
                typesPokemonStore.changeButtonTypePokemons(text: 'Pedra');
                typesPokemonStore.typePokemon(pokemonType: 'rock');

                Modular.to.pop();
              },
            ),
            CustomButtonWidget(
              title: 'Psíquico',
              height: 42.0,
              width: sizeOf.width,
              padding: 0.0,
              borderRadius: 49.0,
              titleStyle: theme.typography.poppins14px().copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colors.blackColor,
              ),
              backgroundColor: theme.colors.pokemonPsynicColor,
              onPressed: () {
                typesPokemonStore.changeButtonTypePokemons(text: 'Psíquico');
                typesPokemonStore.typePokemon(pokemonType: 'psychic');

                Modular.to.pop();
              },
            ),
            CustomButtonWidget(
              title: 'Terrestre',
              height: 42.0,
              width: sizeOf.width,
              padding: 0.0,
              borderRadius: 49.0,
              titleStyle: theme.typography.poppins14px().copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colors.blackColor,
              ),
              backgroundColor: theme.colors.pokemonGroundColor,
              onPressed: () {
                typesPokemonStore.changeButtonTypePokemons(text: 'Terrestre');
                typesPokemonStore.typePokemon(pokemonType: 'ground');

                Modular.to.pop();
              },
            ),
            CustomButtonWidget(
              title: 'Venenoso',
              height: 42.0,
              width: sizeOf.width,
              padding: 0.0,
              borderRadius: 49.0,
              titleStyle: theme.typography.poppins14px().copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colors.blackColor,
              ),
              backgroundColor: theme.colors.pokemonPoisonColor,
              onPressed: () {
                typesPokemonStore.changeButtonTypePokemons(text: 'Venenoso');
                typesPokemonStore.typePokemon(pokemonType: 'poison');

                Modular.to.pop();
              },
            ),
            CustomButtonWidget(
              title: 'Voador',
              height: 42.0,
              width: sizeOf.width,
              padding: 0.0,
              borderRadius: 49.0,
              titleStyle: theme.typography.poppins14px().copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colors.blackColor,
              ),
              backgroundColor: theme.colors.pokemonFlyingColor,
              onPressed: () {
                typesPokemonStore.changeButtonTypePokemons(text: 'Voador');
                typesPokemonStore.typePokemon(pokemonType: 'flying');

                Modular.to.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
