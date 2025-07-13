import 'package:flutter/material.dart';
import 'package:poke_app/app/core/ui/app_colors.dart';
import 'package:poke_app/app/core/ui/app_fonts.dart';

class AppTheme {
  final AppColors colors = AppColors();
  final AppFonts typography = AppFonts();

  ThemeData get lightTheme {
    return ThemeData.light();
  }

  ThemeData get darkTheme {
    return ThemeData.dark();
  }
}
