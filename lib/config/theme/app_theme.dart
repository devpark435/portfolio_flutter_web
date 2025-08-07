import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColorLight = Color(0xFF005A9C);
  static const Color primaryColorDark = Color(0xFF53A9FF);

  static ThemeData get lightTheme {
    final baseTheme = ThemeData.light();
    return baseTheme.copyWith(
      brightness: Brightness.light,
      primaryColor: primaryColorLight,
      scaffoldBackgroundColor: const Color(0xFFF5F5F7),
      cardColor: Colors.white,
      textTheme: GoogleFonts.notoSansKrTextTheme(baseTheme.textTheme).apply(
        bodyColor: const Color(0xFF333333),
        displayColor: const Color(0xFF111111),
      ),
      colorScheme: const ColorScheme.light(
        primary: primaryColorLight,
        secondary: Color(0xFF007AFF),
        background: Color(0xFFF5F5F7),
        surface: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: Color(0xFF333333),
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
      scaffoldBackgroundColor: const Color(0xFF121212),
      cardColor: const Color(0xFF1E1E1E),
      textTheme: GoogleFonts.notoSansKrTextTheme(baseTheme.textTheme).apply(
        bodyColor: Colors.white.withOpacity(0.87),
        displayColor: Colors.white,
      ),
      colorScheme: ColorScheme.dark(
        primary: primaryColorDark,
        secondary: const Color(0xFF5EBCF6),
        background: const Color(0xFF121212),
        surface: Color(0xFF1E1E1E),
        onPrimary: Color(0xFF1E1E1E),
        onSecondary: Color(0xFF1E1E1E),
        onBackground: Colors.white.withOpacity(0.87),
        onSurface: Colors.white.withOpacity(0.87),
        error: Colors.red,
        onError: const Color(0xFF1E1E1E),
      ),
    );
  }
}
