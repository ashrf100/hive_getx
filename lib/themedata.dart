import 'package:flutter/material.dart';
import 'package:hive_test/core/const/ui_constants.dart';

class AppThemes {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: UI.primary,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.deepPurple,
      ).copyWith(
        primary: UI.primary,
        secondary: UI.secondary,
        error: UI.error,
        surface: UI.surface,
        onPrimary: UI.onPrimary,
        onSecondary: UI.onSecondary,
        onError: UI.onError,
      ),
      scaffoldBackgroundColor: UI.background,
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UI.radMd),
        ),
      ),
      textTheme: TextTheme(
        displayLarge: UI.h1,
        displayMedium: UI.h2,
        titleLarge: UI.body1.copyWith(fontWeight: FontWeight.w600),
        bodyLarge: UI.body1,
        bodyMedium: UI.body2,
        labelLarge: UI.btn,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: UI.onPrimary,
          backgroundColor: UI.primary,
          padding: const EdgeInsets.symmetric(
              horizontal: UI.padLg, vertical: UI.padMd),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UI.radMd),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UI.radMd),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: UI.primary),
          borderRadius: BorderRadius.circular(UI.radMd),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: UI.error),
          borderRadius: BorderRadius.circular(UI.radMd),
        ),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UI.radMd),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: UI.primary,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: UI.primary,
        secondary: UI.secondary,
        error: UI.error,
        surface: Color(0xFF2A2A2A), // For cards and other surfaces
        onPrimary: UI.onPrimary,
        onSecondary: UI.onSecondary,
        onError: UI.onError,
      ),
      scaffoldBackgroundColor: const Color(0xFF121212), // Dark grey
      cardTheme: CardTheme(
        color: const Color(
            0xFF1E1E1E), // Slightly lighter than scaffold background
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UI.radMd),
        ),
      ),
      textTheme: TextTheme(
        displayLarge: UI.h1.copyWith(color: UI.onPrimary),
        displayMedium: UI.h2.copyWith(color: UI.onPrimary),
        titleLarge:
            UI.body1.copyWith(fontWeight: FontWeight.w600, color: UI.onPrimary),
        bodyLarge: UI.body1.copyWith(color: UI.onPrimary),
        bodyMedium: UI.body2.copyWith(color: Colors.grey[400]),
        labelLarge: UI.btn.copyWith(color: UI.onPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black, // Replaces onPrimary
          backgroundColor: UI.primary, // Replaces primary
          padding: const EdgeInsets.symmetric(
              horizontal: UI.padLg, vertical: UI.padMd),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UI.radMd),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2A2A2A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UI.radMd),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: UI.primary),
          borderRadius: BorderRadius.circular(UI.radMd),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: UI.error),
          borderRadius: BorderRadius.circular(UI.radMd),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: const Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UI.radMd),
        ),
      ),
    );
  }
}
