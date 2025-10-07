import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poke_app/ui/core/widgets/pokeball_loading.dart';
import 'package:poke_app/ui/core/widgets/pokemon_error_image.dart';
import 'package:poke_app/utils/constants/pokemon_type/pokemon_type_colors.dart';
import 'package:poke_app/utils/constants/pokemon_type/pokemon_type_transparency_icons.dart';
import 'package:poke_app/ui/core/widgets/pokemon_cards/pokemon_type_badge.dart';
import 'package:poke_app/utils/extensions/string_casting_extension.dart';

class PokemonCard extends StatelessWidget {
  final int id;
  final String name;
  final List<String> types;
  final String imagePath;
  final VoidCallback? onPressed;
  final VoidCallback? favoriteOnPressed;
  final bool isFavoritePage;
  final EdgeInsetsGeometry? margin;

  const PokemonCard({
    super.key,
    required this.id,
    required this.name,
    required this.types,
    required this.imagePath,
    this.onPressed,
    this.favoriteOnPressed,
    this.isFavoritePage = false,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final pokemonPrimaryType = types.isNotEmpty ? types[0] : 'Normal';
    final pokemonPrimaryColor = pokemonTypeColors[pokemonPrimaryType] ?? Colors.grey;
    final pokemonPrimaryIcon = pokemonTypeTransparencyIcons[pokemonPrimaryType] ?? '';
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: pokemonPrimaryColor.withAlpha(51),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              ),
              onTap: onPressed,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 12.0, 8.0, 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'N°${id.toString().padLeft(3, '0')}',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      name.toCapitalized,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FittedBox(
                        child: Row(
                          children: types
                              .map(
                                (type) => PokemonTypeBadge(
                                  type: type,
                                  margin: const EdgeInsets.only(right: 8.0),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // A segunda parte do card (imagem e favorito) não precisou de alterações.
          GestureDetector(
            onTap: isFavoritePage ? null : favoriteOnPressed,
            child: Container(
              width: 126.0,
              decoration: BoxDecoration(
                color: pokemonPrimaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 8.0,
                    right: 8.0,
                    child: Container(
                      width: 32.0,
                      height: 32.0,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: SvgPicture.asset(
                        'assets/icons/svg/pokemons/favorite/favorite_with_border_icon.svg',
                      ),
                    ),
                  ),
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(pokemonPrimaryIcon, width: 94, height: 94),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: CachedNetworkImage(
                        imageUrl: imagePath,
                        height: 80.0,
                        filterQuality: FilterQuality.none,
                        placeholder: (_, __) => const PokeballLoading(isSliverWidget: false),
                        errorWidget: (_, __, ___) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: PokemonErrorImage.content(context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
