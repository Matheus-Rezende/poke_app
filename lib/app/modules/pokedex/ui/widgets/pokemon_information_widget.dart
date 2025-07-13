import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';

class PokemonInformationWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final String information;
  const PokemonInformationWidget({
    super.key,
    required this.iconPath,
    required this.title,
    required this.information,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Modular.get<AppTheme>();

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
              colorFilter: ColorFilter.mode(appTheme.colors.greyCCColor, BlendMode.srcIn),
            ),
            Text(
              title.toUpperCase(),
              style: appTheme.typography.poppins12px().copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Container(
          height: 43.0,
          constraints: BoxConstraints(minWidth: 154.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            border: Border.all(width: 1, color: appTheme.colors.greyCCColor),
          ),
          child: Center(
            child: FittedBox(
              child: Text(
                information,
                style: appTheme.typography.poppins18px().copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
