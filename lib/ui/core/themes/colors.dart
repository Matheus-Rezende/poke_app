import 'package:flutter/material.dart';

abstract final class AppColors {
  // BASIC COLORS
  static const black1 = Color(0xFF101010);
  static const white1 = Color(0xFFFFF7FA);
  static const white2 = Color(0xFFF4F0F0);
  static const grey1 = Color(0xFFF2F2F2);
  static const grey2 = Color(0xFFA4A4A4);
  static const grey3 = Color(0xFF4D4D4D);
  static const grey4 = Color(0xFF333333);
  static const grey5 = Color(0xFF222222);
  static const red1 = Color(0xFFE74C3C);
  static const darkblue = Color(0xFF173EA5);

  //POKEMONS TYPE COLORS
  static const pokemonGrassColor = Color(0xFF63BC5A);
  static const pokemonWaterColor = Color(0xFF5090D6);
  static const pokemonDragonColor = Color(0xFF0B6DC3);
  static const pokemonEletricColor = Color(0xFFF4D23C);
  static const pokemonFairyColor = Color(0xFFEC8FE6);
  static const pokemonGhostColor = Color(0xFF5269AD);
  static const pokemonFireColor = Color(0xFFFF9D55);
  static const pokemonIceColor = Color(0xFF73CEC0);
  static const pokemonBugColor = Color(0xFF91C12F);
  static const pokemonFightingColor = Color(0xFFCE416B);
  static const pokemonNormalColor = Color(0xFF919AA2);
  static const pokemonDarkColor = Color(0xFF5A5465);
  static const pokemonSteelColor = Color(0xFF5A8EA2);
  static const pokemonRockColor = Color(0xFFC5B78C);
  static const pokemonPsynicColor = Color(0xFFFA7179);
  static const pokemonGroundColor = Color(0xFFD97845);
  static const pokemonPoisonColor = Color(0xFFB567CE);
  static const pokemonFlyingColor = Color(0xFF89AAE3);

  // COLORS THEME
  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.black1,
    onPrimary: AppColors.grey4,
    secondary: AppColors.black1,
    onSecondary: AppColors.white2,
    surface: Colors.white,
    onSurface: AppColors.black1,
    error: Colors.white,
    onError: Colors.red,
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.white1,
    onPrimary: AppColors.white2,
    secondary: AppColors.white1,
    onSecondary: AppColors.grey5,
    surface: AppColors.black1,
    onSurface: Colors.white,
    error: Colors.black,
    onError: AppColors.red1,
  );
}
