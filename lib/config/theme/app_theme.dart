import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColorLight = Color(0xFF005A9C);
  static const Color primaryColorDark = Color(0xFF54C5F8);

  static ThemeData get lightTheme {
    final baseTheme = ThemeData.light();
    return baseTheme.copyWith(
      brightness: Brightness.light,
      primaryColor: primaryColorLight,
      scaffoldBackgroundColor: const Color(0xFFF5F5F7),
      cardColor: Colors.white,
      textTheme: baseTheme.textTheme.apply(
        fontFamily: 'PretendardVariable',
        bodyColor: const Color(0xFF333333),
        displayColor: const Color(0xFF111111),
      ),
      colorScheme: const ColorScheme.light(
        primary: primaryColorLight,
        secondary: Color(0xFF007AFF),
        surface: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFF333333),
        error: Colors.redAccent,
        onError: Colors.white,
      ),
    );
  }

  static ThemeData get darkTheme {
    final baseTheme = ThemeData.dark();
    return baseTheme.copyWith(
      brightness: Brightness.dark,
      primaryColor: primaryColorDark,
      scaffoldBackgroundColor: const Color(0xFF0D1117),
      cardColor: const Color(0xFF161B22),
      textTheme: baseTheme.textTheme.apply(
        fontFamily: 'PretendardVariable',
        bodyColor: Colors.white.withOpacity(0.87),
        displayColor: Colors.white,
      ),
      colorScheme: ColorScheme.dark(
        primary: primaryColorDark,
        secondary: const Color(0xFF7E57C2),
        surface: const Color(0xFF161B22),
        onPrimary: const Color(0xFF0D1117),
        onSecondary: const Color(0xFF0D1117),
        onSurface: Colors.white.withOpacity(0.87),
        error: Colors.red,
        onError: const Color(0xFF0D1117),
      ),
    );
  }
}
