import 'package:flutter/material.dart';
import '../constants/constant_string.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.brown[50], // Light parchment color

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: ConstantString.fontHarryP,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      headlineMedium: TextStyle(
        // Added headlineMedium for better heading styling
        fontFamily: ConstantString.fontHarryP,
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
      titleMedium: TextStyle(
        fontFamily: ConstantString.fontCinzel,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        fontFamily: ConstantString.fontGaramond,
        fontSize: 16,
        color: Colors.black87,
      ),
      bodySmall: TextStyle(
        fontFamily: ConstantString.fontGaramond,
        fontSize: 14,
        color: Colors.black87,
      ),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.deepPurple, // Hogwarts-style AppBar color
      titleTextStyle: TextStyle(
        fontFamily: ConstantString.fontCinzel,
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );
}
