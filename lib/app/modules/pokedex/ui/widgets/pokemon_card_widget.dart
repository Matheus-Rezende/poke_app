// REESTRUTURAÇÃO - PokemonCardWidget
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:poke_app/app/core/interactor/utils/type_colors/pokemon_type_colors.dart';
import 'package:poke_app/app/core/interactor/utils/type_icons/pokemon_type_icons.dart';
import 'package:poke_app/app/core/interactor/utils/type_icons/pokemon_type_transparency_icons.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';

class PokemonCardWidget extends StatelessWidget {
  final int id;
  final String name;
  final List<String> types;
  final String imagePath;
  final AppTheme theme;
  final Animation<double> animationLoading;

  const PokemonCardWidget({
    super.key,
    required this.id,
    required this.name,
    required this.types,
    required this.imagePath,
    required this.animationLoading,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final primaryType = types.isNotEmpty ? types[0] : 'normal';
    final primaryColor = typeColors[primaryType] ?? Colors.grey;
    final primaryIcon = typeIconsTransparencyPath[primaryType] ?? '';

    return Container(
      margin: const EdgeInsets.only(top: 12.0),
      decoration: BoxDecoration(color: primaryColor.withAlpha(51), borderRadius: BorderRadius.circular(15.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_buildInfo(primaryType), _buildImage(primaryColor, primaryIcon)],
      ),
    );
  }

  Widget _buildInfo(String primaryType) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'N°${id.toString().padLeft(3, '0')}',
              style: theme.typography.poppins12px().copyWith(
                fontWeight: FontWeight.w500,
                color: theme.colors.grey33Color,
              ),
            ),
            Text(
              name.toCapitalized,
              style: theme.typography.poppins21px().copyWith(
                fontWeight: FontWeight.w500,
                color: theme.colors.blackColor,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(spacing: 6.0, runSpacing: 4.0, children: types.map(_buildTypeBadge).toList()),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeBadge(String type) {
    final iconPath = typeIconsPath[type];
    final color = typeColors[type] ?? Colors.grey;

    if (iconPath == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(48.0)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(color: theme.colors.whiteColor, shape: BoxShape.circle),
            child: SvgPicture.asset(iconPath, height: 11.0, width: 11.0),
          ),
          const SizedBox(width: 6.0),
          Text(
            type,
            style: theme.typography.poppins11px().copyWith(
              fontWeight: FontWeight.w500,
              color: theme.colors.blackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(Color backgroundColor, String iconPath) {
    return Container(
      width: 126.0,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset(
              iconPath,
              width: 94,
              height: 94,
              colorFilter: ColorFilter.mode(theme.colors.whiteColor.withAlpha(128), BlendMode.srcIn),
            ),
          ),
          CachedNetworkImage(
            imageUrl: imagePath,
            height: 80.0,
            filterQuality: FilterQuality.none,
            placeholder: (_, __) => RotationTransition(
              turns: animationLoading,
              child: SvgPicture.asset('assets/icons/svg/bottom_menu/pokedex_filled.svg', height: 40.0),
            ),
            errorWidget: (_, __, ___) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icons/svg/bottom_menu/pokedex_filled.svg', height: 40.0),
                Text(
                  'Imagem não encontrada',
                  style: theme.typography.poppins12px().copyWith(fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension StringCasingExtension on String {
  String get toCapitalized => isNotEmpty ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String get toTitleCase =>
      replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized).join(' ');
}
