import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poke_app/ui/core/themes/colors.dart';
import 'package:poke_app/ui/core/widgets/buttons/custom_button.dart';
import 'package:poke_app/ui/pokedex/viewmodels/pokedex_viewmodel.dart';
import 'package:poke_app/ui/pokedex/viewmodels/types_pokemons_viewmodel.dart';
import 'package:poke_app/utils/constants/pokemon_type/pokemon_type_colors.dart';
import 'package:poke_app/utils/extensions/string_casting_extension.dart';

class PokemonTypesBottomSheet extends StatelessWidget {
  final TypesPokemonViewmodel typesPokemonViewmodel;
  final PokedexViewmodel pokedexViewmodel;
  const PokemonTypesBottomSheet({
    super.key,
    required this.typesPokemonViewmodel,
    required this.pokedexViewmodel,
  });

  @override
  Widget build(BuildContext context) {
    final List<MapEntry<String, Color>> typesEntries = pokemonTypeColors.entries.toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          spacing: 8.0,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomButton(
              title: 'All types',
              height: 42.0,
              titleStyle: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600, color: AppColors.grey1),
              backgroundColor: AppColors.grey5,
              onPressed: () {
                typesPokemonViewmodel.selectAllTypes();
                pokedexViewmodel.load.execute();

                context.pop();
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: typesEntries.length,
              itemBuilder: (context, index) {
                final type = typesEntries[index];
                final typeName = type.key;
                final typeColor = type.value;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomButton(
                    height: 42.0,
                    title: typeName.toCapitalized,

                    titleStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey1,
                    ),
                    backgroundColor: typeColor.withValues(alpha: 1.5),
                    onPressed: () {
                      print('tipo selecionado: $typeName');
                      typesPokemonViewmodel.pokemonTypeText = typeName.toCapitalized;
                      typesPokemonViewmodel.pokemonTypeColor = typeColor;
                      typesPokemonViewmodel.load.execute(typeName);
                      context.pop();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
