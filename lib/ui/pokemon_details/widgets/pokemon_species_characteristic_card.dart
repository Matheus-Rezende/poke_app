import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PokemonSpeciesCharacteristicCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String information;
  const PokemonSpeciesCharacteristicCard({
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
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.secondary,
                BlendMode.srcIn,
              ),
            ),
            Text(
              title.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
        Container(
          height: 43.0,
          constraints: BoxConstraints(minWidth: 154.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            ),
          ),
          child: Center(
            child: FittedBox(
              child: Text(
                information,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
