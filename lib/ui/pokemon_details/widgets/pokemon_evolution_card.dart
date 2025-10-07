// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:poke_app/domain/models/pokemon/evolution_step.dart';
import 'package:poke_app/routing/routes.dart';
import 'package:poke_app/ui/core/themes/colors.dart';
import 'package:poke_app/ui/core/widgets/pokeball_loading.dart';
import 'package:poke_app/ui/core/widgets/pokemon_cards/pokemon_type_badge.dart';
import 'package:poke_app/utils/assets/app_assets.dart';
import 'package:poke_app/utils/constants/pokemon_type/pokemon_type_colors.dart';
import 'package:poke_app/utils/constants/pokemon_type/pokemon_type_transparency_icons.dart';
import 'package:poke_app/utils/extensions/string_casting_extension.dart';

class PokemonEvolutionCard extends StatelessWidget {
  final EvolutionStep evolutionStep;
  final String pokemonCurrentNumber;
  const PokemonEvolutionCard({
    super.key,
    required this.evolutionStep,
    required this.pokemonCurrentNumber,
  });

  @override
  Widget build(BuildContext context) {
    final primaryType = evolutionStep.types.isNotEmpty ? evolutionStep.types[0] : 'normal';
    final primaryColor = pokemonTypeColors[primaryType] ?? Colors.grey;
    final primaryTypeIcon = pokemonTypeTransparencyIcons[primaryType] ?? '';
    final pokemonNumberFormat = evolutionStep.number.replaceFirst('N°', '');
    final pokemonNumberInt = int.parse(pokemonNumberFormat);

    return GestureDetector(
      onTap: () => pokemonCurrentNumber == evolutionStep.number
          ? null
          : context.go(Routes.pokemonDetails(pokemonNumberInt.toString())),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90.0),
          border: Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)),
        ),
        child: Row(
          spacing: 12.0,
          children: [
            _buildImage(
              backgroundColor: primaryColor,
              pokemonImage: evolutionStep.image,
              pokemonTypeIcon: primaryTypeIcon,
            ),
            _buildInfo(
              number: evolutionStep.number,
              name: evolutionStep.name,
              types: evolutionStep.types,
              context: context,
            ),
            _buildSpace(),
          ],
        ),
      ),
    );
  }

  Widget _buildImage({
    required Color backgroundColor,
    required String pokemonTypeIcon,
    required String pokemonImage,
  }) {
    return Flexible(
      flex: 2,
      child: Container(
        height: 74.0,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(90.0)),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SvgPicture.asset(
                pokemonTypeIcon,
                colorFilter: ColorFilter.mode(AppColors.white1.withAlpha(128), BlendMode.srcIn),
              ),
            ),
            CachedNetworkImage(
              imageUrl: pokemonImage,
              height: 60.0,
              width: 90.0,
              filterQuality: FilterQuality.none,
              placeholder: (_, __) => PokeballLoading(isSliverWidget: false),
              errorWidget: (_, __, ___) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [SvgPicture.asset(AppAssets.general.pokeball, height: 40.0)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo({
    required String number,
    required String name,
    required List<String> types,
    required BuildContext context,
  }) {
    return Flexible(
      flex: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            name.toCapitalized,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            number,
            style: Theme.of(
              context,
            ).textTheme.labelSmall!.copyWith(color: Theme.of(context).colorScheme.secondary),
          ),
          SizedBox(height: 8.0),
          SizedBox(
            height: 16.0,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: types.length == 1 ? 1 : 2,
                childAspectRatio: types.length == 1 ? 15.0 : 7.0,
                crossAxisSpacing: 8.0,
              ),
              itemCount: types.length,
              itemBuilder: (context, index) => PokemonTypeBadge(
                type: types[index],
                isContentCentralized: true,
                isSimpleBadge: true,
                padding: EdgeInsets.all(2.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpace() {
    return Flexible(child: Container());
  }
}
