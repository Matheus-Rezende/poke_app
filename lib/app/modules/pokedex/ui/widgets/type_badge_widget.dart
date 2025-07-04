import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poke_app/app/core/interactor/utils/type_colors/pokemon_type_colors.dart';
import 'package:poke_app/app/core/interactor/utils/type_icons/pokemon_type_icons.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';

class TypeBadgeWidget extends StatelessWidget {
  final String type;
  final AppTheme theme;
  final EdgeInsets? margin;
  final bool isContentCentralized;
  final bool isSimpleBadge;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  const TypeBadgeWidget({
    super.key,
    required this.type,
    required this.theme,
    this.margin,
    this.isContentCentralized = false,
    this.isSimpleBadge = false,
    this.width,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final iconPath = typeIconsPath[type];
    final color = typeColors[type] ?? Colors.grey;

    if (iconPath == null) return const SizedBox.shrink();

    return Container(
      margin: margin,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      width: width,
      height: height,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(48.0)),
      child: isSimpleBadge
          ? SvgPicture.asset(
              iconPath,
              height: 9.0,
              width: 9.0,
              colorFilter: ColorFilter.mode(theme.colors.whiteColor, BlendMode.srcIn),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: isContentCentralized ? MainAxisAlignment.center : MainAxisAlignment.start,
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
}
