import 'package:flutter/material.dart';

import 'colors.dart';

abstract final class AppTheme {
  static const _textTheme = TextTheme(
    headlineLarge: TextStyle(fontFamily: 'Poppins', fontSize: 32, fontWeight: FontWeight.w500),
    headlineSmall: TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w400),
    titleLarge: TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w500),
    titleMedium: TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w400),
    labelSmall: TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w500),
    labelLarge: TextStyle(fontFamily: 'Poppins', fontSize: 21, fontWeight: FontWeight.w500),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: AppColors.lightColorScheme,
    textTheme: _textTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: AppColors.darkColorScheme,
    textTheme: _textTheme,
  );
}
