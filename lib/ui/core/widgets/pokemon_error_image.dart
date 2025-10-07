import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poke_app/ui/core/themes/colors.dart';
import 'package:poke_app/utils/assets/app_assets.dart';

abstract final class PokemonErrorImage {
  static List<Widget> content(BuildContext context) => [
    SvgPicture.asset(AppAssets.general.pokeball, height: 40.0),
    Container(
      padding: EdgeInsets.all(4.0),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: AppColors.grey1.withValues(alpha: 0.6),
      ),
      child: Text(
        'Imagem não encontrada',
        style: Theme.of(context).textTheme.labelSmall!.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.black1,
          fontSize: 11.0,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  ];
}
