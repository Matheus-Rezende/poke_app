import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:poke_app/app/core/ui/widgets/buttons/custom_button_widget.dart';
import 'package:poke_app/app/modules/pokedex/interactor/stories/pokemons/type/pokemons_type_store.dart';
import 'package:poke_app/app/modules/pokedex/interactor/stories/pokemons/pokemons_store.dart';

class BottomSheetTypesWidget extends StatelessWidget {
  final AppTheme theme;
  final PokemonsTypeStore pokemonsTypeStore;
  final PokemonsStore pokemonsStore;
  const BottomSheetTypesWidget({
    super.key,
    required this.theme,
    required this.pokemonsTypeStore,
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
                pokemonsTypeStore.changeButtonTypePokemons(text: 'Todos os tipos');
                pokemonsStore.fetchInitial();
                pokemonsTypeStore.isFilterTypeSelected = false;
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
                pokemonsTypeStore.changeButtonTypePokemons(text: 'Água');
                pokemonsTypeStore.typePokemon(pokemonType: 'water');
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
                pokemonsTypeStore.changeButtonTypePokemons(text: 'Dragão');
                pokemonsTypeStore.typePokemon(pokemonType: 'dragon');

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
                pokemonsTypeStore.changeButtonTypePokemons(text: 'Elétrico');
                pokemonsTypeStore.typePokemon(pokemonType: 'electric');

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
                pokemonsTypeStore.changeButtonTypePokemons(text: 'Fada');
                pokemonsTypeStore.typePokemon(pokemonType: 'fairy');

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
                pokemonsTypeStore.changeButtonTypePokemons(text: 'Fantasma');
                pokemonsTypeStore.typePokemon(pokemonType: 'ghost');

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
                pokemonsTypeStore.changeButtonTypePokemons(text: 'Fogo');
                pokemonsTypeStore.typePokemon(pokemonType: 'fire');

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
                pokemonsTypeStore.changeButtonTypePokemons(text: 'Gelo');
                pokemonsTypeStore.typePokemon(pokemonType: 'ice');

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
                pokemonsTypeStore.changeButtonTypePokemons(text: 'Grama');
                pokemonsTypeStore.typePokemon(pokemonType: 'grass');

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
                pokemonsTypeStore.changeButtonTypePokemons(text: 'Inseto');
                pokemonsTypeStore.typePokemon(pokemonType: 'bug');

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
                pokemonsTypeStore.changeButtonTypePokemons(text: 'Lutador');
                pokemonsTypeStore.typePokemon(pokemonType: 'fighting');

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
                pokemonsTypeStore.changeButtonTypePokemons(text: 'Normal');
                pokemonsTypeStore.typePokemon(pokemonType: 'normal');

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
                pokemonsTypeStore.changeButtonTypePokemons(text: 'Noturno');
                pokemonsTypeStore.typePokemon(pokemonType: 'dark');

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
                pokemonsTypeStore.changeButtonTypePokemons(text: 'Metal');
                pokemonsTypeStore.typePokemon(pokemonType: 'steel');

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
                pokemonsTypeStore.changeButtonTypePokemons(text: 'Pedra');
                pokemonsTypeStore.typePokemon(pokemonType: 'rock');

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
                pokemonsTypeStore.changeButtonTypePokemons(text: 'Psíquico');
                pokemonsTypeStore.typePokemon(pokemonType: 'psychic');

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
                pokemonsTypeStore.changeButtonTypePokemons(text: 'Terrestre');
                pokemonsTypeStore.typePokemon(pokemonType: 'ground');

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
                pokemonsTypeStore.changeButtonTypePokemons(text: 'Venenoso');
                pokemonsTypeStore.typePokemon(pokemonType: 'poison');

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
                pokemonsTypeStore.changeButtonTypePokemons(text: 'Voador');
                pokemonsTypeStore.typePokemon(pokemonType: 'flying');

                Modular.to.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
