import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poke_app/ui/core/widgets/pokemon_type/pokemon_type_colors.dart';
import 'package:poke_app/ui/core/widgets/pokemon_type/pokemon_type_icons.dart';

class PokemonTypeBadge extends StatelessWidget {
  final String type;
  final EdgeInsets? margin;
  final bool isContentCentralized;
  final bool isSimpleBadge;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  const PokemonTypeBadge({
    super.key,
    required this.type,
    this.margin,
    this.isContentCentralized = false,
    this.isSimpleBadge = false,
    this.width,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final typeIcon = pokemonTypeIcons[type];
    final typeColor = pokemonTypeColors[type];

    if (typeIcon == null) return const SizedBox.shrink();

    return Container(
      margin: margin,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      width: width,
      height: height,
      decoration: BoxDecoration(color: typeColor, borderRadius: BorderRadius.circular(48.0)),
      child: isSimpleBadge
          ? SvgPicture.asset(typeIcon, height: 9.0, width: 9.0)
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: isContentCentralized
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: SvgPicture.asset(typeIcon, height: 11.0, width: 11.0),
                ),
                const SizedBox(width: 6.0),
                Text(
                  type,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
    );
  }
}
