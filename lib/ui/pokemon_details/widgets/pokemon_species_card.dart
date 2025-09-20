import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poke_app/ui/core/themes/colors.dart';

class PokemonSpeciesCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String information;
  const PokemonSpeciesCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.information,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 2.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 8.0,
          children: [
            SvgPicture.asset(
              iconPath,
              height: 12.0,
              width: 12.0,
              colorFilter: ColorFilter.mode(AppColors.grey66, BlendMode.srcIn),
            ),
            Text(title.toUpperCase(), style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        Container(
          height: 43.0,
          constraints: BoxConstraints(minWidth: 154.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            border: Border.all(width: 1, color: AppColors.grey66),
          ),
          child: Center(
            child: FittedBox(
              child: Text(information, style: Theme.of(context).textTheme.bodyMedium),
            ),
          ),
        ),
      ],
    );
  }
}
