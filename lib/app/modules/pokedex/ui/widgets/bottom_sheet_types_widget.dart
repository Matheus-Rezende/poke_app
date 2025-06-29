import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:poke_app/app/core/ui/widgets/buttons/custom_button_widget.dart';
import 'package:poke_app/app/modules/pokedex/interactor/stories/pokedex_store.dart';

class BottomSheetTypesWidget extends StatelessWidget {
  final AppTheme theme;
  final PokedexStore store;
  const BottomSheetTypesWidget({super.key, required this.theme, required this.store});

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
                store.changeButtonTypePokemons(text: 'Todos os tipos');
                store.fetchInitial();
                store.isFilterTypeSelected = false;
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
                store.changeButtonTypePokemons(text: 'Água');
                store.typePokemon(pokemonType: 'water');
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
                store.changeButtonTypePokemons(text: 'Dragão');
                store.typePokemon(pokemonType: 'dragon');

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
                store.changeButtonTypePokemons(text: 'Elétrico');
                store.typePokemon(pokemonType: 'electric');

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
                store.changeButtonTypePokemons(text: 'Fada');
                store.typePokemon(pokemonType: 'fairy');

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
                store.changeButtonTypePokemons(text: 'Fantasma');
                store.typePokemon(pokemonType: 'ghost');

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
                store.changeButtonTypePokemons(text: 'Fogo');
                store.typePokemon(pokemonType: 'fire');

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
                store.changeButtonTypePokemons(text: 'Gelo');
                store.typePokemon(pokemonType: 'ice');

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
                store.changeButtonTypePokemons(text: 'Grama');
                store.typePokemon(pokemonType: 'grass');

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
                store.changeButtonTypePokemons(text: 'Inseto');
                store.typePokemon(pokemonType: 'bug');

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
                store.changeButtonTypePokemons(text: 'Lutador');
                store.typePokemon(pokemonType: 'fighting');

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
                store.changeButtonTypePokemons(text: 'Normal');
                store.typePokemon(pokemonType: 'normal');

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
                store.changeButtonTypePokemons(text: 'Noturno');
                store.typePokemon(pokemonType: 'dark');

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
                store.changeButtonTypePokemons(text: 'Metal');
                store.typePokemon(pokemonType: 'steel');

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
                store.changeButtonTypePokemons(text: 'Pedra');
                store.typePokemon(pokemonType: 'rock');

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
                store.changeButtonTypePokemons(text: 'Psíquico');
                store.typePokemon(pokemonType: 'psychic');

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
                store.changeButtonTypePokemons(text: 'Terrestre');
                store.typePokemon(pokemonType: 'ground');

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
                store.changeButtonTypePokemons(text: 'Venenoso');
                store.typePokemon(pokemonType: 'poison');

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
                store.changeButtonTypePokemons(text: 'Voador');
                store.typePokemon(pokemonType: 'flying');

                Modular.to.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
