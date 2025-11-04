import 'package:flutter/material.dart';
import 'package:poke_app/ui/core/themes/colors.dart';
import 'package:poke_app/utils/extensions/string_casting_extension.dart';

class RegionCard extends StatelessWidget {
  final String regionName;
  final String generationName;
  final String backgroundImagePath;
  final VoidCallback? onPressed;
  const RegionCard({
    super.key,
    required this.regionName,
    required this.generationName,
    required this.backgroundImagePath,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final sizeOf = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Image.asset(backgroundImagePath, width: sizeOf.width, height: 102, fit: BoxFit.cover),

            Container(
              width: MediaQuery.sizeOf(context).width,
              height: 102,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [AppColors.black1, Colors.transparent],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    regionName.toCapitalized,
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.white1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 4),
                  Text(
                    generationName == '0' ? 'GERAÇÃO DESCONHECIDA' : '$generationName° GERAÇÃO',
                    style: textTheme.labelSmall?.copyWith(
                      color: AppColors.grey1,
                      fontWeight: FontWeight.w500,
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
