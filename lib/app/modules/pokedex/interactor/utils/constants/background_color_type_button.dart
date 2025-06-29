import 'package:flutter/material.dart';
import 'package:poke_app/app/core/ui/app_colors.dart';

class BackgroundColorTypeButton {
  Color colors(String type) {
    return switch (type) {
      'Todos os tipos' => AppColors().blackColor.withValues(alpha: 0.75),
      'Água' => AppColors().pokemonWaterColor,
      'Dragão' => AppColors().pokemonDragonColor,
      'Elétrico' => AppColors().pokemonEletricColor,
      'Fada' => AppColors().pokemonFairyColor,
      'Fantasma' => AppColors().pokemonGhostColor,
      'Fogo' => AppColors().pokemonFireColor,
      'Gelo' => AppColors().pokemonIceColor,
      'Grama' => AppColors().pokemonGrassColor,
      'Inseto' => AppColors().pokemonBugColor,
      'Lutador' => AppColors().pokemonFightingColor,
      'Normal' => AppColors().pokemonNormalColor,
      'Noturno' => AppColors().pokemonDarkColor,
      'Metal' => AppColors().pokemonSteelColor,
      'Pedra' => AppColors().pokemonRockColor,
      'Psíquico' => AppColors().pokemonPsynicColor,
      'Terrestre' => AppColors().pokemonGroundColor,
      'Venenoso' => AppColors().pokemonPoisonColor,
      'Voador' => AppColors().pokemonFlyingColor,
      _ => AppColors().blackColor.withValues(alpha: 0.75),
    };
  }
}
