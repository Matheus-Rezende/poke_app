import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:poke_app/app/modules/pokedex/data/pokemon_gender_data.dart';

class PokemonGenderBarWidget extends StatelessWidget {
  final PokemonGenderData data;

  const PokemonGenderBarWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final appTheme = Modular.get<AppTheme>();
    final sizeOf = MediaQuery.sizeOf(context);

    if (data.isUnknown) {
      return Column(
        spacing: 8.0,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/svg/pokemon_information/unknown_gender_bar.svg',
            width: sizeOf.width,
          ),
          Text(
            'desconhecido',
            style: appTheme.typography.poppins12px().copyWith(
              fontWeight: FontWeight.w500,
              color: appTheme.colors.blackColor.withValues(alpha: 0.7),
            ),
          ),
        ],
      );
    }

    return Column(
      spacing: 8.0,
      children: [
        Stack(
          children: [
            Container(
              height: 8.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: data.female > 0 ? appTheme.colors.pinkColor : appTheme.colors.blueColor,
              ),
            ),
            if (data.male > 0)
              FractionallySizedBox(
                widthFactor: data.male / 100,
                child: Container(
                  height: 8.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: appTheme.colors.blueColor,
                  ),
                ),
              )
            else if (data.female > 0)
              FractionallySizedBox(
                widthFactor: data.female / 100,
                child: Container(
                  height: 8.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: appTheme.colors.pinkColor,
                  ),
                ),
              ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 4.0,
              children: [
                SvgPicture.asset('assets/icons/svg/pokemon_informations/male_icon.svg'),
                Text(
                  '${data.male.toStringAsFixed(1)}%',
                  style: appTheme.typography.poppins12px().copyWith(
                    fontWeight: FontWeight.w500,
                    color: appTheme.colors.blackColor.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
            Row(
              spacing: 4.0,
              children: [
                SvgPicture.asset('assets/icons/svg/pokemon_informations/female_icon.svg'),
                Text(
                  '${data.female.toStringAsFixed(1)}%',
                  style: appTheme.typography.poppins12px().copyWith(
                    fontWeight: FontWeight.w500,
                    color: appTheme.colors.blackColor.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
