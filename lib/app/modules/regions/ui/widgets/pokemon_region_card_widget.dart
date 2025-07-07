import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';

class PokemonRegionCardWidget extends StatelessWidget {
  final String regionName;
  final int generationNumber;
  final String backgroundImagePath;
  final VoidCallback? onPressed;
  const PokemonRegionCardWidget({
    super.key,
    required this.regionName,
    required this.generationNumber,
    required this.backgroundImagePath,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Modular.get<AppTheme>();
    return GestureDetector(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Image.asset(
              backgroundImagePath,
              width: MediaQuery.sizeOf(context).width,
              height: 102,
              fit: BoxFit.cover,
            ),

            Container(
              width: MediaQuery.sizeOf(context).width,
              height: 102,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [appTheme.colors.blackColor.withValues(alpha: 0.9), Colors.transparent],
                ),
              ),
            ),

            Positioned(
              left: 16,
              top: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    regionName,
                    style: appTheme.typography.poppins18px().copyWith(
                      fontWeight: FontWeight.w600,
                      color: appTheme.colors.whiteColor,
                    ),
                  ),

                  SizedBox(height: 4),
                  Text(
                    '${regionName == 'Hisui'
                        ? 8
                        : regionName == 'Paldea'
                        ? 9
                        : generationNumber}° GERAÇÃO',
                    style: appTheme.typography.poppins11px().copyWith(
                      fontWeight: FontWeight.w500,
                      color: appTheme.colors.greyCCColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
