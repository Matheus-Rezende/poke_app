import 'package:flutter/material.dart';
import 'package:poke_app/app/core/ui/app_colors.dart';

class ForegroundColorTypeButton {
  Color colors(String type) {
    return switch (type) {
      'Todos os tipos' => AppColors().whiteColor,
      'Água' => AppColors().blackColor,
      'Dragão' => AppColors().whiteColor,
      'Elétrico' => AppColors().blackColor,
      'Fada' => AppColors().blackColor,
      'Fantasma' => AppColors().whiteColor,
      'Fogo' => AppColors().blackColor,
      'Gelo' => AppColors().blackColor,
      'Grama' => AppColors().blackColor,
      'Inseto' => AppColors().blackColor,
      'Lutador' => AppColors().whiteColor,
      'Normal' => AppColors().blackColor,
      'Noturno' => AppColors().whiteColor,
      'Metal' => AppColors().blackColor,
      'Pedra' => AppColors().blackColor,
      'Psíquico' => AppColors().blackColor,
      'Terrestre' => AppColors().blackColor,
      'Venenoso' => AppColors().blackColor,
      'Voador' => AppColors().blackColor,
      _ => AppColors().whiteColor,
    };
  }
}
